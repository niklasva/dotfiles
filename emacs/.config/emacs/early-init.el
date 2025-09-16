;;; early-init.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
;;; -------------------------------------------------------------------------

;;; Startup/window behavior -------------------------------------------------
(setq frame-inhibit-implied-resize nil
      frame-resize-pixelwise       t
      window-resize-pixelwise      t)

(setq inhibit-redisplay t
      inhibit-message   t)

(defconst my/init-frame-params
  '((min-height              . 1)
    (height                  . 40)
    (min-width               . 1)
    (width                   . 120)
    (internal-border-width   . 10)
    (left-fringe             . 1)
    (right-fringe            . 1)
    (vertical-scroll-bars    . nil)
    (tool-bar-lines          . 1)
    (undecorated             . nil)
    (visible                 . nil)
    (ns-appearance           . 'dark)
    (ns-transparent-titlebar . t))
  "Initial frame parameters applied both before and after init.")

(defun my/init-apply-frame-params ()
  "Populate both frame alists with `my/init-frame-params`."
  (dolist (param my/init-frame-params)
    (setf (alist-get (car param) initial-frame-alist) (cdr param)
          (alist-get (car param) default-frame-alist) (cdr param))))

(my/init-apply-frame-params)

;;; Paths -------------------------------------------------------------------
(defconst my/init-exec-path-dirs
  '("/usr/local/bin"
    "/Users/niklas/.pyenv/shims"
    "/Users/niklas/.pyenv/bin"
    "/Users/niklas/scripts"
    "/Users/niklas/.local/bin"
    "/Users/niklas/.cargo/bin"
    "/Users/niklas/.go/bin"
    "/Users/niklas/.bin/mipsel-none-elf/bin"
    "/Users/niklas/.bin"
    "/opt/homebrew/opt/gnu-sed/libexec/gnubin"
    "/opt/homebrew/opt/coreutils/libexec/gnubin"
    "/Applications/ARM/bin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    "/Applications/Xcode.app/Contents/Developer/usr/bin")
  "Directories pushed into `exec-path` during early init.")

(defun my/init-refresh-exec-path ()
  "Add `my/init-exec-path-dirs` to `exec-path` and sync $PATH."
  (dolist (dir my/init-exec-path-dirs)
    (let ((expanded (expand-file-name dir)))
      (when (file-directory-p expanded)
        (add-to-list 'exec-path expanded t))))
  (setenv "PATH" (mapconcat #'identity exec-path path-separator)))

(my/init-refresh-exec-path)

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

(unless (eq system-type 'darwin)
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
