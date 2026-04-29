;;; early-init.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
;;; -------------------------------------------------------------------------

;;; Startup/window behavior -------------------------------------------------
(require 'server)

;; (setq inhibit-redisplay t
;;       inhibit-message   t)

(defun my/redirect-to-running-server ()
  (when (and (not (daemonp))
             (server-running-p))
    (let ((args (append '("-c") command-line-args-left)))
      (apply #'call-process "/opt/homebrew/bin/emacsclient" nil 0 nil args))
    (kill-emacs)))

(my/redirect-to-running-server)

(unless (server-running-p)
  (server-start))

(setq frame-inhibit-implied-resize nil
      frame-resize-pixelwise       t
      window-resize-pixelwise      t)

(defconst my/init-frame-params
  '((min-height              . 1)
    (height                  . 40)
    (min-width               . 1)
    (width                   . 120)
    (vertical-scroll-bars    . nil)
    (undecorated             . nil)
    ;; (visibility              . nil)
    (left-margin . 0)
    (right-margin . 0))
  "Initial frame parameters applied both before and after init.")

(defun my/init-apply-frame-params ()
  "Populate both frame alists with `my/init-frame-params`."
  (dolist (param my/init-frame-params)
    (setf (alist-get (car param) initial-frame-alist) (cdr param)
          (alist-get (car param) default-frame-alist) (cdr param))))

(my/init-apply-frame-params)


;;; Paths -------------------------------------------------------------------
(defconst my/init-exec-path-dirs
  '( "/Users/niklas/.pyenv/shims"
     "/Users/niklas/.pyenv/bin"
     "/Users/niklas/scripts"
     "/Users/niklas/.local/bin"
     "/Users/niklas/.cargo/bin"
     "/Users/niklas/.go/bin"
     "/Users/niklas/.bin/mipsel-none-elf/bin"
     "/Users/niklas/.bin"
     "/opt/homebrew/opt/gnu-sed/libexec/gnubin"
     "/opt/homebrew/opt/coreutils/libexec/gnubin"
     "/opt/arm-gnu-toolchain-13.2.Rel1-darwin-arm64-arm-none-eabi/bin"
     ;; "/Applications/ARM/bin"
     "/opt/homebrew/bin"
     "/opt/homebrew/sbin"
     "/Applications/Xcode.app/Contents/Developer/usr/bin"
     "/Library/Frameworks/Mono.framework/Versions/Current/Commands"
     "/usr/local/bin")
  "Directories pushed into `exec-path` during early init.")

(defun my/init-refresh-exec-path ()
  "Add `my/init-exec-path-dirs` to `exec-path` and sync $PATH."
  (dolist (dir my/init-exec-path-dirs)
    (let ((expanded (expand-file-name dir)))
      (when (file-directory-p expanded)
        (add-to-list 'exec-path expanded))))
  (setenv "PATH" (mapconcat #'identity exec-path path-separator)))

(defun my/init-set-ls-colors ()
  "Populate `LS_COLORS` for GUI Emacs."
  (unless (getenv "LS_COLORS")
    (setenv
     "LS_COLORS"
     "rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32")))

(my/init-refresh-exec-path)
(my/init-set-ls-colors)

;;; General behavior --------------------------------------------------------
(setq gc-cons-threshold         most-positive-fixnum
      gc-cons-percentage        0.6
      package-enable-at-startup nil
      package-quickstart        nil
      site-run-file             nil
      inhibit-startup-screen    t
      inhibit-startup-message   t
      use-file-dialog           nil
      use-dialog-box            nil
      auto-mode-case-fold       nil
      ns-antialias-text         t
      ns-use-native-fullscreen  t
      ns-use-proxy-icon         nil
      ns-use-thin-smoothing     nil
      custom-file               (expand-file-name "custom.el" user-emacs-directory)
      vc-follow-symlinks        t
      gnus-init-inhibit         t)

(unless (or (eq system-type 'darwin) (display-graphic-p))
  (menu-bar-mode -1))

(when (boundp 'native-comp-speed)
  (setq native-comp-speed 2))

;;; Bootstrap straight.el ---------------------------------------------------
(load (expand-file-name "lisp/init-elpaca.el" user-emacs-directory))


;;; Local variables ---------------------------------------------------------
;; Local Variables:
;; mode: emacs-lisp
;; outline-minor-mode: t
;; outline-regexp: ";;;+ "
;; eval: (progn (require 'outline) (outline-hide-sublevels 1))
;; End:
;;; -------------------------------------------------------------------------
;;; early-init.el ends here
