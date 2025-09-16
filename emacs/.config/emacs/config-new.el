;;; config-new.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
;;; ----------------------------------------------------------------------------

;; (setq initial-major-mode 'fundamental-mode)
(advice-add #'display-startup-echo-area-message :override #'ignore)
(advice-add #'display-startup-screen            :override #'ignore)

(add-to-list 'safe-local-eval-forms      '(outline-minor-mode))
(add-to-list 'safe-local-eval-forms      '(outline-hide-sublevels 1))
(add-to-list 'safe-local-variable-values '(outline-minor-mode . t))
(add-to-list 'safe-local-variable-values '(outline-regexp . ";;;+ "))
(add-to-list 'safe-local-variable-values
             '(eval progn (require 'outline) (outline-hide-sublevels 1)))

;;; Eshell ---------------------------------------------------------------------
;;;; eshell --------------------------------------------------------------------
(use-package eshell
  :ensure nil
  :defines eshell-prompt-function
  :config
  (defalias 'ff 'find-file)
  (add-hook 'shell-mode-hook 'with-editor-export-editor)
  (add-hook 'eshell-mode-hook
            (lambda ()
              (define-key eshell-hist-mode-map (kbd "C-c C-l") nil)
              (define-key eshell-hist-mode-map (kbd "M-s")     nil)
              (define-key eshell-mode-map      (kbd "C-a")     'eshell-bol)
              (define-key eshell-mode-map      (kbd "C-l")     'eshell/clear)
              (define-key eshell-mode-map      (kbd "C-r")     'eshell-isearch-backward)
              (define-key eshell-mode-map      (kbd "C-u")     'eshell-kill-input)))

  (setq eshell-ask-to-save-history 'always
        eshell-banner-message ""
        eshell-cmpl-cycle-completions t
        eshell-cmpl-ignore-case t
        eshell-destroy-buffer-when-process-dies nil
        eshell-error-if-no-glob t
        eshell-glob-case-insensitive t
        eshell-hist-ignoredups t
        eshell-history-size 4096
        eshell-input-filter (lambda (input) (not (string-match-p "\\`\\s-+" input)))
        eshell-kill-processes-on-exit t
        eshell-scroll-to-bottom-on-input 'all
        eshell-scroll-to-bottom-on-output 'all)

  (setq pcomplete-cycle-completions nil)

  (setq system-name (car (split-string system-name "\\.")))
  (setq eshell-prompt-regexp "^.+@.+:.+> ")
  (setq eshell-prompt-function
        (lambda ()
          (concat
           (propertize (user-login-name) 'face 'font-lock-keyword-face)
           (propertize (format "@%s" (system-name)) 'face 'default)
           (propertize ":" 'face 'font-lock-doc-face)
           (propertize (abbreviate-file-name (eshell/pwd)) 'face 'font-lock-type-face)
           (propertize " $" 'face 'font-lock-doc-face)
           (propertize " " 'face 'default))))

  (advice-add 'eshell/clear :override
              (defun niva--eshell/clear (&optional scrollback)
                (interactive)
                (let ((inhibit-read-only t))
                  (erase-buffer)
                  (eshell-send-input)))))

;;;; eshell-syntax-highlighting ------------------------------------------------
(use-package eshell-syntax-highlighting
  :defer t
  :ensure t
  :hook (eshell-mode . eshell-syntax-highlighting-mode))

;;;; Kill buffer on quit -------------------------------------------------------
(defun niva/term-handle-exit (&optional process-name msg)
  "Kill buffer on quit"
  (kill-buffer (current-buffer)))

(advice-add 'term-handle-exit :after 'niva/term-handle-exit)

;; ;; ** Log coloring
;; ;; #+begin_src disabled
;; ;; (defun niva/font-lock-comment-annotations ()
;; ;;   "Colorize keywords in eshell buffers"
;; ;;   (interactive)
;; ;;   (font-lock-add-keywords
;; ;;    nil
;; ;;    '(("\\<\\(.*ERR.*\\)"                                            1 'compilation-error   t)
;; ;;      ("\\<\\(.*INFO.*\\)"                                           1 'compilation-info    t)
;; ;;      ("\\<\\(.*DEBUG.*\\)"                                          1 'compilation-info    t)
;; ;;      ("\\<\\(.*WARN.*\\)"                                           1 'compilation-warning t)
;; ;;      ("\\<\\(.*DEBUG: --- CMD: POLL(60) REPLY: ISTATR(49) ---.*\\)" 1 'completions-common-part t)
;; ;;      ("\\<\\(.*DEBUG: --- CMD: OUT(68) REPLY: ACK(40) ---.*\\)"     1 'completions-common-part t))))
;; ;;
;; ;; (add-hook 'eshell-mode-hook 'niva/font-lock-comment-annotations)
;; ;; #+end_src

;;;; Alias ---------------------------------------------------------------------
(defalias 'ff    "for i in ${eshell-flatten-list $*} {find-file $i}")
(defalias 'emacs "ff")
(defalias 'fo    "find-file-other-window $1")
(defalias 'ts    "ts '[%Y-%m-%d %H:%M:%S]'")

;;; Defaults -------------------------------------------------------------------
;;;; Defaults ------------------------------------------------------------------
(setq-default warning-minimum-level :error)
(setq-default c-basic-offset 4
              c-default-style "user"
              display-line-numbers-width 4
              ;; confirm-kill-emacs 'y-or-n-p
              ring-bell-function 'ignore
              column-number-mode nil)

(setq-default backup-directory-alist '(("." . "~/.cache/emacs/backup"))
              auto-save-file-name-transforms '((".*" "~/.cache/emacs/auto-save/" t))
              backup-by-copying t
              version-control t
              delete-old-versions t
              kept-new-versions 20
              kept-old-versions 20
              create-lockfiles nil)

(setq-default case-fold-search t)

(add-hook 'window-setup-hook 'delete-other-windows)
(fset 'yes-or-no-p 'y-or-n-p)

(global-display-line-numbers-mode -1)


(electric-indent-mode)
(delete-selection-mode)
(context-menu-mode)
(repeat-mode)

(setq-default evil-auto-indent t
              indent-tabs-mode nil
              tab-width 4
              org-src-tab-acts-natively t
              org-edit-src-content-indentation 0
              org-indent-indentation-per-level 2
              org-indent-mode-turns-on-hiding-stars t)

(defun indent-tabs-hook ()
  (setq tab-width 4
        indent-tabs-mode t
        evil-auto-indent t
        c-basic-offset tab-width))

(dolist (hook '(c++-mode-hook c-mode-hook c++-ts-mode-hook c-ts-mode-hook cmake-ts-mode-hook)) (add-hook hook 'indent-tabs-hook))

(setq org-src-strip-leading-and-trailing-blank-lines t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(recentf-mode 1)
(setq history-length 9999
      history-delete-duplicates t
      recentf-max-saved-items 1000
      recentf-auto-cleanup 'never
      recentf-auto-save-timer (run-with-idle-timer 600 t 'recentf-save-list))

(setq-default maximum-scroll-margin 1
              scroll-margin 0
              scroll-conservatively 5
              compilation-scroll-output t
              scroll-preserve-screen-position t)


(global-visual-line-mode t)
(global-hl-line-mode -1)
(setq fringes-outside-margins t)

(setq-default left-fringe-width 8
              right-fringe-width 8)

(setq inhibit-startup-buffer-menu t)

(setq pp-use-max-width t)
(setq pp-max-width 120)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'indent-region nil t)))

(save-place-mode +1)

;;;; OS defaults ---------------------------------------------------------------
(setq-default mac-escape-modifier nil
              mac-option-modifier 'meta
              mac-right-command-modifier 'meta
              mac-right-option-modifier 'meta)

(global-set-key (kbd "s-,") 'menu-set-font)
(global-set-key (kbd "M-,") 'menu-set-font)

(use-package ultra-scroll
  :ensure (ultra-scroll :type git :host github :repo "jdtsmith/ultra-scroll")
  :config
  (ultra-scroll-mode))

(use-package simpleclip
  :ensure t
  :config
  (setq interprogram-cut-function 'simpleclip-set-contents
        interprogram-paste-function 'simpleclip-get-contents)
  (simpleclip-mode 1))

;;;;; Emacsclient --------------------------------------------------------------
(defun niva/foreground-emacsclient ()
  (when (eq system-type 'darwin)
    (start-process "bring-emacs-to-front" nil
                   "osascript"
                   "-e"
                   "tell application \"Emacs\" to activate")))
(add-hook 'server-after-make-frame-hook #'niva/foreground-emacsclient)


;;;; Garbage collection --------------------------------------------------------
(setq garbage-collection-messages t)

(defvar niva/gc-timer nil)
(defun niva/do-garbage-collect ()
  (setq gc-cons-threshold (* 1024 1024 1024))
  (message "do focus loss garbage collect")
  (garbage-collect))

(defun niva/garbage-collect-on-focus-lost ()
  (if (frame-focus-state)
      (when (timerp niva/gc-timer)
        (cancel-timer niva/gc-timer))
    (setq my/gc-timer (run-with-idle-timer 300 nil #'niva/do-garbage-collect))))
(add-function :after after-focus-change-function #'niva/garbage-collect-on-focus-lost)

;;; Customization --------------------------------------------------------------
;;;; Theme ---------------------------------------------------------------------
;;(ignore-errors (niva/update-theme-faces))

;;;; Colors --------------------------------------------------------------------
(require 'color-operations)

;;;; GUI settings --------------------------------------------------------------
;;;; Display time --------------------------------------------------------------
(setq-default display-time-format " %H:%M "
              display-time-interval 60
              display-time-default-load-average nil
              display-time-string-forms '((propertize (format-time-string display-time-format now) 'help-echo (format-time-string "%a %b %e, %Y" now)) " "))
(display-time-mode -1)

;;;; Font ----------------------------------------------------------------------
(defun niva/remove-font-weight ()
  "Set weights to regular on common faces"
  (interactive)
  (set-face-attribute 'bold               nil :weight 'unspecified)
  (set-face-attribute 'buffer-menu-buffer nil :weight 'unspecified)
  (set-face-attribute 'compilation-error  nil :weight 'unspecified)
  (set-face-attribute 'default            nil :weight 'unspecified)
  (set-face-attribute 'help-key-binding   nil :weight 'unspecified :family 'unspecified :box 'unspecified :inherit 'default)
  (set-face-attribute 'outline-1          nil :weight 'unspecified)
  (set-face-attribute 'outline-2          nil :weight 'unspecified)
  (set-face-attribute 'outline-3          nil :weight 'unspecified)
  (set-face-attribute 'tooltip            nil :inherit 'default))
(set-face-attribute 'fixed-pitch nil :family 'unspecified)

;;;; solaire-mode --------------------------------------------------------------
(use-package solaire-mode
  :ensure t
  :config
  (defun solaire-mode-real-buffer-custom-p ()
    (cond ((string= (buffer-name (buffer-base-buffer)) "*scratch*") t)
          ((buffer-file-name (buffer-base-buffer)) t)
          (t nil)))

  (setq solaire-mode-real-buffer-fn #'solaire-mode-real-buffer-custom-p)
  (solaire-global-mode t)

  (add-hook 'compilation-mode-hook (lambda () (solaire-mode t) (solaire-mode-reset)))
  (add-hook 'eshell-mode-hook      (lambda () (solaire-mode t) (solaire-mode-reset)))
  (add-hook 'gptel-mode-hook       (lambda () (solaire-mode t) (solaire-mode-reset)))
  (add-hook 'read-only-mode-hook   (lambda () (solaire-mode t) (solaire-mode-reset))))

;;; Window management ----------------------------------------------------------
;;;; help-window-select --------------------------------------------------------
;; Always move cursor to help window.
(setq help-window-select t)

;;;; winner-mode ---------------------------------------------------------------
(winner-mode 1)

;;;; tab-bar-echo-area ---------------------------------------------------------
(use-package tab-bar-echo-area
  :ensure t
  :custom
  (tab-bar-show nil)
  :config
  (tab-bar-echo-area-mode 1))

;;;; frame-decorations ---------------------------------------------------------
(defun niva/toggle-internal-border-width (&optional frame)
  (interactive)
  (let* ((frame (or frame (selected-frame)))
         (now   (frame-parameter frame 'internal-border-width)))
    (set-frame-parameter frame 'internal-border-width
                         (if (= now 40) 5 40))))

(defun niva/toggle-frame-decorations (&optional frame)
  (interactive)
  (let* ((frame (or frame (selected-frame)))
         (now   (frame-parameter frame 'undecorated)))
    (set-frame-parameter frame 'undecorated (not now))))

(defun niva/toggle-frame-decorations (&optional frame)
  (interactive)
  (let* ((frame (or frame (selected-frame)))
         (now   (frame-parameter frame 'undecorated)))
    (set-frame-parameter frame 'undecorated (not now))))
(defun niva/toggle-ns-transparent-titlebar ()
  (interactive)
  (let ((current-setting (frame-parameter nil 'ns-transparent-titlebar)))
    (set-frame-parameter nil 'ns-transparent-titlebar
                         (if (= current-setting t)
                             nil
                           t))))

(defun niva/toggle-ns-appearance ()
  (interactive)
  (let ((current-appearance (frame-parameter nil 'ns-appearance)))
    (set-frame-parameter nil 'ns-appearance
                         (if (equal current-appearance 'dark)
                             'light
                           'dark))))

(global-set-key (kbd "C-c <backspace>") 'niva/toggle-internal-border-width)

;;;; Popper --------------------------------------------------------------------
(use-package popper
  :ensure t
  :defer t
  :hook (prog-mode . popper-mode)
  :config
  (setq popper-reference-buffers
        '("Output\\*$" "\\*Pp Eval Output\\*$"
          "\\*Compile-Log\\*"
          ;; compilation-mode
          "^\\*eldoc.*\\*.*$" eldoc-mode
          "\\*Flycheck errors\\*$" " \\*Flycheck checker\\*$"
          ;; "\\*ChatGPT\\*$"
          ;; "\\*gptel\\*$" gptel-mode
          ))

  (popper-echo-mode +1)
  (popper-mode +1)

  ;; HACK: close popper window with `C-g'
  (defun +popper-close-window-hack (&rest _)
    "Close popper window via `C-g'."
    (when (and (called-interactively-p 'interactive)
               (not (region-active-p))
               popper-open-popup-alist)
      (let ((window (caar popper-open-popup-alist)))
        (when (window-live-p window)
          (delete-window window)))))
  (advice-add #'keyboard-quit :before #'+popper-close-window-hack))

;;; Controls -------------------------------------------------------------------
;;;; Evil mode -----------------------------------------------------------------
;;;;; evil-mode ----------------------------------------------------------------
(global-set-key (kbd "<escape>") nil)
(when niva-enable-evil-mode
  (use-package evil
    :ensure t
    :custom
    (evil-want-integration t)
    (evil-want-keybinding nil)
    (evil-vsplit-window-right t)
    (evil-split-window-below t)
    (evil-want-C-u-scroll t)
    (evil-undo-system 'undo-fu)
    (evil-scroll-count 8)
    (evil-respect-visual-line-mode t)
    (evil-mode-line-format nil)
    (evil-search-module 'evil-search)
    :config
    (add-hook 'emacs-startup-hook
              (lambda ()
                (run-with-idle-timer 0.2 nil (lambda () (evil-mode 1))))))

  (with-eval-after-load 'evil-maps
    (define-key evil-motion-state-map (kbd "RET") nil)))

;;;;; general ------------------------------------------------------------------
(when niva-enable-evil-mode
  (use-package general
    :ensure t
    :defer t
    :config (general-evil-setup t)))

;;;;; Evil collection ----------------------------------------------------------
;; (when niva-enable-evil-mode
;;   (use-package evil-collection
;;     :ensure t
;;     :diminish evil-collection-unimpaired-mode
;;     :delight
;;     :custom
;;     (evil-collection-setup-minibuffer t)
;;     :config
;;     (setq evil-collection-mode-list
;;       (remove 'xwidgets evil-collection-mode-list))
;;       (run-with-idle-timer 0.1 nil (lambda () (
;;     (evil-collection-init 1)
;;     (evil-set-initial-state 'dired-mode 'normal))))))

;;;; savehist ------------------------------------------------------------------
(use-package savehist
  :ensure nil
  :config
  (savehist-mode))

;;;; Window management ---------------------------------------------------------
;;;;; transpose-frame ----------------------------------------------------------
(use-package transpose-frame :ensure t)

;;;; Keybindings ---------------------------------------------------------------
;;;;; - ------------------------------------------------------------------------

(global-set-key                    (kbd "C-j")  nil)
(global-set-key                    (kbd "<f1>") nil)
(global-set-key                    (kbd "<f2>") nil)
(global-set-key                    (kbd "<f3>") nil)
(global-set-key                    (kbd "<f4>") nil)
(global-set-key (kbd "€")          (kbd "$"))
(global-set-key (kbd "s-n")        (kbd "M-n"))
(global-set-key (kbd "s-p")        (kbd "M-p"))
(global-set-key (kbd "s-f")        (kbd "M-f"))
(global-set-key (kbd "s-b")        (kbd "M-b"))
(global-set-key (kbd "s-m")        nil)
(global-set-key (kbd "s-s")        nil)
(global-set-key (kbd "s-q")        nil)
(global-set-key (kbd "C-x b")      'consult-buffer)
(global-set-key (kbd "C-x C-b")    'consult-buffer)
(global-set-key (kbd "s-q")        'save-buffers-kill-terminal)
(global-set-key (kbd "s-<return>") 'toggle-frame-fullscreen)
(global-set-key (kbd "s-t")        'tab-new)
(global-set-key (kbd "s-w")        'delete-frame)
(global-set-key (kbd "s-z")        nil)
(global-set-key (kbd "C-c bbl")    'niva/toggle-bing-bong-light)
(global-set-key (kbd "C-c bbd")    'niva/toggle-bing-bong-dark)
(global-set-key (kbd "C-c ct")     'consult-theme)

(defun niva/new-untitled-frame ()
  (interactive)
  (let* ((buf   (generate-new-buffer "untitled"))
         (frame (make-frame)))
    (select-frame-set-input-focus frame)
    (set-window-buffer (frame-root-window frame) buf)
    (with-current-buffer buf
      (fundamental-mode)
      (setq buffer-offer-save t))))

(global-set-key (kbd "s-n") #'niva/new-untitled-frame)

(defun niva/kill-untitled-buffers ()
  (interactive)
  (dolist (buf (buffer-list))
    (when (string-match-p "\\`untitled" (buffer-name buf))
      (kill-buffer buf))))

(unless niva-enable-evil-mode
  (global-set-key (kbd "<escape>") nil))

(with-eval-after-load 'evil-maps
  (define-key evil-normal-state-map (kbd "C-<return>") 'eldoc-doc-buffer)
  (define-key evil-normal-state-map (kbd "C-x k")      'kill-current-buffer)
  (define-key evil-normal-state-map (kbd "C-x K")      'kill-buffer)
  (define-key evil-normal-state-map (kbd "C-w C-x")    'delete-window)
  (define-key evil-normal-state-map (kbd "s-e")        'eshell)
  (define-key evil-normal-state-map (kbd "M-e")        'eshell)
  (define-key evil-normal-state-map (kbd "C-n")        'next-line)
  (define-key evil-normal-state-map (kbd "C-p")        'previous-line)
  (define-key evil-insert-state-map (kbd "C-n")        'nil)
  (define-key evil-insert-state-map (kbd "C-p")        'nil)
  (define-key evil-motion-state-map (kbd "RET")        nil)
  (define-key evil-normal-state-map (kbd "C-p")        'previous-line)
  (define-key evil-insert-state-map (kbd "C-n")        'nil)
  (define-key evil-normal-state-map (kbd "C-.")        'nil)
  (define-key evil-normal-state-map (kbd "C-w n")      'tab-next)
  (define-key evil-normal-state-map (kbd "C-w c")      'tab-new)
  (define-key evil-normal-state-map (kbd "C-<tab>")    'tab-next)
  (define-key evil-normal-state-map (kbd "C-S-<tab>")  'tab-previous)
  (define-key evil-normal-state-map (kbd "C-w SPC")    'transpose-frame)
  (define-key evil-normal-state-map (kbd "C-w H")      'buf-move-left)
  (define-key evil-normal-state-map (kbd "C-w J")      'buf-move-down)
  (define-key evil-normal-state-map (kbd "C-w K")      'buf-move-up)
  (define-key evil-normal-state-map (kbd "C-w L")      'buf-move-right)
  (define-key evil-normal-state-map (kbd "M-<")        'ns-next-frame)
  (define-key evil-normal-state-map (kbd "M->")        'ns-prev-frame)
  (define-key evil-normal-state-map (kbd "s-<")        'ns-next-frame)
  (define-key evil-normal-state-map (kbd "s->")        'ns-prev-frame))

;; (define-key evil-normal-state-map (kbd "C-w <SPC>")  (lambda () (interactive) (message "Warning! Use C-x w t")))
;; (define-key evil-normal-state-map (kbd "C-w h")      (lambda () (interactive) (message "Warning! Use C-x o")))
;; (define-key evil-normal-state-map (kbd "C-w j")      (lambda () (interactive) (message "Warning! Use C-x o")))
;; (define-key evil-normal-state-map (kbd "C-w k")      (lambda () (interactive) (message "Warning! Use C-x o")))
;; (define-key evil-normal-state-map (kbd "C-w l")      (lambda () (interactive) (message "Warning! Use C-x o")))

;;;;; Project ------------------------------------------------------------------
;; Don't prompt project switch action
(setq project-switch-commands 'project-find-file)

;;;; which-key -----------------------------------------------------------------
(defun niva/show-command-keys (command)
  (interactive
   (list (intern (completing-read "Command: " obarray #'commandp t))))
  (let* ((all (where-is-internal command nil))
         (keys (seq-remove (lambda (key)
                             (string-prefix-p "<menu-bar>" (key-description key)))
                           all))
         (pretty (mapconcat #'key-description keys ", ")))
    (if keys
        (message "%s → %s" command pretty)
      (message "%s is not bound to any *key* (only menu-bar or none)" command))))

(use-package which-key
  :ensure t
  :demand t
  :diminish
  :config
  (setq which-key-side-window-location 'bottom
	    which-key-sort-order #'which-key-key-order-alpha
	    which-key-sort-uppercase-first nil
	    which-key-add-column-padding 1
	    which-key-max-display-columns nil
	    which-key-min-display-lines 6
	    which-key-side-window-slot -10
	    which-key-side-window-max-height 0.25
	    which-key-idle-delay 0.6
	    which-key-max-description-length 25
	    which-key-allow-imprecise-window-fit t
        which-key-separator " → " )
  (which-key-mode))

;; (when niva-enable-evil-mode
;;   (nvmap :keymaps 'override :prefix "SPC"
;;     "SPC"   '((lambda () (interactive) (niva/show-command-keys 'execute-extended-command          )) :which-key "M-x")
;;     "B"     '((lambda () (interactive) (niva/show-command-keys 'consult-buffer-other-window       )) :which-key "consult-buffer-other-window")
;;     "b"     '((lambda () (interactive) (niva/show-command-keys 'consult-buffer                    )) :which-key "consult-buffer")
;;     "c C"   '((lambda () (interactive) (niva/show-command-keys 'recompile                         )) :which-key "recompile")
;;     "c a"   '((lambda () (interactive) (niva/show-command-keys 'eglot-code-actions                )) :which-key "eglot-code-actions")
;;     "c c"   '((lambda () (interactive) (niva/show-command-keys 'project-compile                   )) :which-key "project-compile")
;;     "c e"   '((lambda () (interactive) (niva/show-command-keys 'consult-compile-error             )) :which-key "consult-compile-error")
;;     "c T"   '((lambda () (interactive) (niva/show-command-keys 'niva/run-test-command             )) :which-key "niva/run-test-command")
;;     "p d"   '((lambda () (interactive) (niva/show-command-keys 'project-dired                     )) :which-key "project-dired")
;;     "d d"   '((lambda () (interactive) (niva/show-command-keys 'dired                             )) :which-key "dired")
;;     "d l"   '((lambda () (interactive) (niva/show-command-keys 'devdocs-lookup                    )) :which-key "devdocs-lookup")
;;     "d r"   '((lambda () (interactive) (niva/show-command-keys 'niva/deobfuscate-region           )) :which-key "niva/deobfuscate-region")
;;     "d u"   '((lambda () (interactive) (niva/show-command-keys 'magit-diff-unstaged               )) :which-key "magit-diff-unstaged")
;;     "e r"   '((lambda () (interactive) (niva/show-command-keys 'eval-region                       )) :which-key "eval-region")
;;     "e i"   '((lambda () (interactive) (niva/show-command-keys 'eglot-inlay-hints-mode            )) :which-key "eglot-inlay-hints-mode")
;;     "f f"   '((lambda () (interactive) (niva/show-command-keys 'find-file                         )) :which-key "find-file")
;;     "f m"   '((lambda () (interactive) (niva/show-command-keys 'consult-flymake                   )) :which-key "consult-flymake")
;;     "h p"   '((lambda () (interactive) (niva/show-command-keys 'ff-get-other-file                 )) :which-key "ff-get-other-file")
;;     "h g"   '((lambda () (interactive) (niva/show-command-keys 'niva-guards                       )) :which-key "niva-guards")
;;     "h h"   '((lambda () (interactive) (niva/show-command-keys 'consult-history                   )) :which-key "consult-history")
;;     "i m"   '((lambda () (interactive) (niva/show-command-keys 'consult-imenu-multi               )) :which-key "consult-imenu")
;;     "L n"   '((lambda () (interactive) (niva/show-command-keys 'global-display-line-numbers-mode  )) :which-key "global-display-line-numbers-mode")
;;     "l n"   '((lambda () (interactive) (niva/show-command-keys 'display-line-numbers-mode         )) :which-key "display-line-numbers-mode")
;;     "o r"   '((lambda () (interactive) (niva/show-command-keys 'niva/obfuscate-region             )) :which-key "niva/obfuscate-region")
;;     "p e"   '((lambda () (interactive) (niva/show-command-keys 'profiler-stop                     )) :which-key "profiler-stop")
;;     "p f"   '((lambda () (interactive) (niva/show-command-keys 'project-find-file                 )) :which-key "project-find-file")
;;     "p p"   '((lambda () (interactive) (niva/show-command-keys 'project-switch-project            )) :which-key "project-switch-project")
;;     "p r"   '((lambda () (interactive) (niva/show-command-keys 'profiler-report                   )) :which-key "profiler-report")
;;     "p s"   '((lambda () (interactive) (niva/show-command-keys 'profiler-start                    )) :which-key "profiler-start")
;;     "r o"   '((lambda () (interactive) (niva/show-command-keys 'read-only-mode                    )) :which-key "read-only-mode")
;;     "s h"   '((lambda () (interactive) (niva/show-command-keys 'git-gutter:stage-hunk             )) :which-key "git-gutter:stage-hunk")
;;     "t r"   '((lambda () (interactive) (niva/show-command-keys 'treemacs                          )) :which-key "treemacs")
;;     "t t"   '((lambda () (interactive) (niva/show-command-keys 'toggle-truncate-lines             )) :which-key "Toggle truncate lines")
;;     "w U"   '((lambda () (interactive) (niva/show-command-keys 'winner-redo                       )) :which-key "winner-redo")
;;     "w u"   '((lambda () (interactive) (niva/show-command-keys 'winner-undo                       )) :which-key "winner-undo")
;;     "p b"   '((lambda () (interactive) (niva/show-command-keys 'consult-project-buffer            )) :which-key "project-list-buffers")
;;
;;     "gpt"   '((lambda () (interactive) (niva/show-command-keys 'niva/gptel-common-buffer          )) :which-key "niva/gptel-common-buffer")
;;     "cmd"   '((lambda () (interactive) (niva/show-command-keys 'project-async-shell-command       )) :which-key "project-async-shell-command")
;;     "elf"   '((lambda () (interactive) (niva/show-command-keys 'elfeed                            )) :which-key "elfeed")
;;     "eww"   '((lambda () (interactive) (niva/show-command-keys 'eww                               )) :which-key "eww")
;;     "rec"   '((lambda () (interactive) (niva/show-command-keys 'consult-recent-file               )) :which-key "consult-recent-file")
;;     "rip"   '((lambda () (interactive) (niva/show-command-keys 'niva/consult-ripgrep-in-directory )) :which-key "niva/consult-ripgrep-in-directory")
;;     "cir"   '((lambda () (interactive) (niva/show-command-keys 'circe                             )) :which-key "circe")
;;     "ir"    '((lambda () (interactive) (niva/show-command-keys 'niva/switch-irc-buffers           )) :which-key "niva/switch-irc-buffers")
;;     "SCR"   '((lambda () (interactive) (niva/show-command-keys 'scratch-buffer                    )) :which-key "scratch-buffer")
;;     "tsfll" '((lambda () (interactive) (niva/show-command-keys 'niva/prompt-treesit-level         )) :which-key "niva/prompt-treesit-level")))

(global-set-key (kbd "C-c Ln")     'global-display-line-numbers-mode)
(global-set-key (kbd "C-c ln")     'display-line-numbers-mode)
(global-set-key (kbd "C-c early")  (lambda () (interactive) (find-file "~/.config/emacs/early-init.el")))
(global-set-key (kbd "C-c scr")    (lambda () (interactive) (find-file "~/dev/stuff/persist-scratch.org")))
(global-set-key (kbd "C-c conf")   (lambda () (interactive) (find-file "~/.config/emacs/config.org")))
(global-set-key (kbd "C-c local")  (lambda () (interactive) (find-file "~/.config/emacs/local-env.el")))
(global-set-key (kbd "C-c ff")     'find-file)
(global-set-key (kbd "C-c er")    'eval-region)
(global-set-key (kbd "C-c elf")    'elfeed)
(global-set-key (kbd "C-x p h")    'ff-get-other-file)
(global-set-key (kbd "C-c no")   (lambda () (interactive) (find-file "~/org/notes.org")))
(global-set-key (kbd "C-c rip") 'niva/consult-ripgrep-in-directory)

(global-set-key (kbd "C-c c a")   (lambda () (interactive)
                                    (when (eglot-managed-p)
                                      (call-interactively #'eglot-code-actions))))

;;;; Undo ----------------------------------------------------------------------
;;;;; undo-fu ------------------------------------------------------------------
(use-package undo-fu
  :ensure t
  :custom
  (undo-fu-allow-undo-in-region t)
  :config
  (global-set-key (kbd "s-z")  'undo-fu-only-undo)
  (global-set-key (kbd "s-Z")  'undo-fu-only-redo)
  (with-eval-after-load 'evil-maps
    (define-key evil-normal-state-map (kbd "u") 'undo-fu-only-undo)
    (define-key evil-normal-state-map (kbd "U") 'undo-fu-only-redo)))

;;;;; undo-fu-session ----------------------------------------------------------
(use-package undo-fu-session
  :ensure t
  :custom
  (undo-fu-session-incompatible-files '(".cache/*" "/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'"))
  :config
  (global-undo-fu-session-mode))

;;;;; vundo --------------------------------------------------------------------
(use-package vundo
  :ensure t
  :defer t
  :custom
  ;; (vundo-glyph-alist vundo-unicode-symbols)
  (vundo-window-max-height 5)
  (vundo-compact-display t))

;;;; buffer-move ---------------------------------------------------------------
(use-package buffer-move :ensure t)

;;;; Hydra ---------------------------------------------------------------------

(use-package hydra
  :ensure t
  :custom
  (hydra-is-helpful t)
  :config
  (defhydra hydra-win-resize (:prefix "C-c C-w")
    "Resize window"
    ("C-j" (lambda () (interactive) (shrink-window 4)) "↓ shrink")
    ("C-k" (lambda () (interactive) (enlarge-window 4)) "↑ enlarge")
    ("C-h" (lambda () (interactive) (shrink-window-horizontally 8)) "← shrink")
    ("C-l" (lambda () (interactive) (enlarge-window-horizontally 8)) "→ enlarge")
    ("h" windmove-left     "← move"    :exit t)
    ("j" windmove-down     "↓ move"    :exit t)
    ("k" windmove-up       "↑ move"    :exit t)
    ("l" windmove-right    "→ move"    :exit t)
    ;; ("h" (lambda () (message "use C-x o")) "← move"    :exit t)
    ;; ("j" (lambda () (message "use C-x o")) "↓ move"    :exit t)
    ;; ("k" (lambda () (message "use C-x o")) "↑ move"    :exit t)
    ;; ("l" (lambda () (message "use C-x o")) "→ move"    :exit t)
    ("H" buf-move-left     "← swap"    :exit t)
    ("J" buf-move-down     "↓ swap"    :exit t)
    ("K" buf-move-up       "↑ swap"    :exit t)
    ("L" buf-move-right    "→ swap"    :exit t)
    ("SPC" transpose-frame "transpose" :exit t))
  (bind-key* "C-c C-w" #'hydra-win-resize/body)

  (with-eval-after-load 'org
    (define-key org-mode-map (kbd "C-c C-w") nil))

  (with-eval-after-load 'evil-maps
    (setq hydra-is-helpful nil)
    (defhydra hydra-win-resize (evil-normal-state-map "C-w")
      "Resize window"
      ("C-j" (lambda () (interactive) (evil-window-decrease-height 4)))
      ("C-k" (lambda () (interactive) (evil-window-increase-height 4)))
      ("C-h" (lambda () (interactive) (evil-window-decrease-width 8)))
      ("C-l" (lambda () (interactive) (evil-window-increase-width 8)))))

  (with-eval-after-load 'evil-maps
    (with-eval-after-load 'magit
      (setq hydra-is-helpful nil)
      (defhydra hydra-win-resize (magit-file-section-map "C-w")
        "Resize window"
        ("C-j" (lambda () (interactive) (evil-window-decrease-height 4)))
        ("C-k" (lambda () (interactive) (evil-window-increase-height 4)))
        ("C-h" (lambda () (interactive) (evil-window-decrease-width 8)))
        ("C-l" (lambda () (interactive) (evil-window-increase-width 8)))))))


;;;; imenu ---------------------------------------------------------------------
(use-package imenu
  :ensure nil
  :defer t
  :custom
  (org-imenu-depth 8))

;;;; zoom ----------------------------------------------------------------------
(global-set-key (kbd "s-O") 'global-text-scale-adjust)

;;;; embark --------------------------------------------------------------------
(use-package embark
  :ensure t
  :bind (("C-." . embark-act)
         ("M-." . embark-dwim)
         :map minibuffer-local-map
         ("C-d" . embark-act)
         :map embark-region-map
         ("D" . denote-region)))

(use-package embark-consult
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;;; Completion -----------------------------------------------------------------
;;;; Vertico -------------------------------------------------------------------
(use-package vertico
  :ensure t
  :config
  (setq vertico-count 10)
  (setq vertico-resize t)
  (setq vertico-cycle t)
  (setq-default vertico-sort-function #'vertico-sort-history-alpha
                vertico-multiform-commands
                '((consult-theme (vertico-sort-function . vertico-sort-alpha))))

  (vertico-mode)
  (vertico-multiform-mode)
  (vertico-mouse-mode +1))

;;;; Consult -------------------------------------------------------------------
(use-package consult
  :ensure t
  :demand t
  :bind (("C-s"     . consult-line)
         ("C-M-l"   . consult-focus-lines)
         ("C-x b"   . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("M-s" . consult-history)
         ("M-y"     . consult-yank-pop))
  :config
  (setq consult-preview-key '(:debounce 0.5 any))

  (consult-customize
   consult--source-buffer
   consult--source-hidden-buffer
   consult--source-project-buffer
   consult-line
   :preview-key 'any)

  (consult-customize
   consult--source-recent-file
   consult--source-bookmark
   :preview-key '("M-." "C-SPC" :debounce 0.5 any))

  (consult-customize
   consult-theme
   :preview-key '("M-." "C-SPC" :debounce 0.3 any))

  (consult-customize
   consult-ripgrep
   :preview-key '("M-." "C-SPC" :debounce 0 any))

  (setq consult-ripgrep-args "rg \
            --null \
            --line-buffered \
            --color=never \
            --max-columns=1000 \
            --path-separator / \
            --smart-case \
            --no-heading \
            --with-filename \
            --line-number \
            --hidden \
            --follow \
            --glob \"!.git/*\"")

  (add-to-list 'consult-mode-histories '(compilation-mode compile-history))

  (setq consult-preview-max-count 50)

  (defun niva/consult-ripgrep-in-directory ()
    (interactive)
    (let ((directory-to-search (read-directory-name "Search in directory: " nil nil t)))
      (consult-ripgrep (expand-file-name "." directory-to-search))))

  (global-set-key (kbd "C-s") 'consult-line)
  (global-set-key (kbd "C-c s") 'consult-line-multi))

;;;; Marginalia ----------------------------------------------------------------
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

;;;; Yasnippet -----------------------------------------------------------------
(with-eval-after-load 'org
  (require 'org-tempo)
  (add-to-list 'org-modules 'org-tempo t))
(use-package yasnippet-snippets :ensure t :defer t)

(use-package yasnippet
  :ensure t
  :defer t
  :diminish yas-minor-mode
  :config (yas-global-mode 1))

;;;; Corfu ---------------------------------------------------------------------
(use-package corfu
  :ensure t
  :defer t
  :hook ((prog-mode . corfu-mode)
         (eshell-mode . corfu-mode))
  :config
  (setq corfu-cycle t
        corfu-auto t
        corfu-echo-documentation t
        corfu-preselect 'prompt
        corfu-auto-prefix 2
        corfu-count 5
        corfu-bar-width 0.0)
  (corfu-popupinfo-mode))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))

(use-package cape
  :ensure t
  :defer t
  :config
  (setq cape-elisp-symbol-wrapper nil
        cape-dabbrev-min-length 4)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  (add-to-list 'completion-at-point-functions #'cape-elisp-symbol)
  (add-to-list 'completion-at-point-functions #'cape-keyword))

;;; File management ------------------------------------------------------------
;;;; Dired ---------------------------------------------------------------------
(use-package dired
  :ensure nil
  :defer t
  :config
  (setq-default insert-directory-program "gls"
                dired-use-ls-dired t
                dired-subtree-use-backgrounds nil
                dired-listing-switches "-alh --group-directories-first"
                dired-subtree-line-prefix "  "
                dired-kill-when-opening-new-dired-buffer t
                dired-subtree-line-prefix-face 'subtree))

;; (use-package dirtree
;;   :ensure t
;;   :defer t)

(use-package dired-subtree
  :ensure t
  :after dired
  :defer t
  :hook ((dired-mode . dired-hide-details-mode)
         (dired-mode . hl-line-mode))
  :bind
  (:map dired-mode-map
        ("<tab>" . dired-subtree-toggle)
        ("TAB" . dired-subtree-toggle)
        ("<backtab>" . dired-subtree-remove)
        ("S-TAB" . dired-subtree-remove)))

(use-package dired-collapse
  :ensure t
  :after dired
  :defer t
  :config
  (with-eval-after-load 'evil-maps
    (evil-define-key 'normal dired-mode-map (kbd "H") 'dired-up-directory)
    (evil-define-key 'normal dired-mode-map (kbd "L") 'dired-find-file))
  (add-hook 'dired-mode-hook 'dired-collapse-mode))

(use-package async
  :ensure t
  :defer t
  :config
  (autoload 'dired-async-mode "dired-async.el" nil t)
  (dired-async-mode 1))

(use-package dired-toggle
  :ensure t
  :after dired
  :defer t
  :bind (("C-c t" . #'dired-toggle)
         :map dired-mode-map
         ("q" . #'dired-toggle-quit)
         ([remap dired-find-file] . #'dired-toggle-find-file)
         ([remap dired-up-directory] . #'dired-toggle-up-directory)
         ("C-c C-u" . #'dired-toggle-up-directory))
  :config
  (setq dired-toggle-window-size 32)
  (setq dired-toggle-window-side 'left)

  (with-eval-after-load 'evil (evil-define-key 'normal dired-mode-map (kbd "q") #'dired-toggle-quit))

  (add-hook 'dired-toggle-mode-hook
            (lambda () (interactive)
              ;; (variable-pitch-mode 1)
              (visual-line-mode -1)
              (setq-local visual-line-fringe-indicators '(nil right-curly-arrow))
              (setq-local word-wrap nil))))

;; (use-package dired-hacks
;;   :ensure t
;;   :defer t)


;;;; treemacs ------------------------------------------------------------------
(use-package treemacs
  :ensure t
  :defer t
  :config
  (setq treemacs-no-png-images nil
        treemacs-file-follow-delay 0.03
        treemacs--icon-size 16
        )
  (set-face-attribute 'treemacs-root-face nil :height 'unspecified :weight 'unspecified)
  (treemacs-hide-gitignored-files-mode nil))

;;; Development ----------------------------------------------------------------
;;;; C++ -----------------------------------------------------------------------
;;;;; Other file ---------------------------------------------------------------
(setq cc-other-file-alist
      '(("\\.h\\'" (".cpp" ".c"))
        ("\\.hpp\\'" (".cpp" ".tpp"))
        ("\\.c\\'" (".h"))
        ("\\.cpp\\'" (".h" ".hpp" ".tpp"))
        ("\\.tpp\\'" (".hpp" ".cpp"))))

;;;;; Mode extension -----------------------------------------------------------
(dolist (pair '(("\\.tpp\\'" . c++-mode)
                ("\\.kts\\'" . java-mode)))
  (push pair auto-mode-alist))

;;;;; Header guards ------------------------------------------------------------
(require 'niva-guards)
(global-set-key (kbd "C-c h g") 'niva-guards)

;;;; Python --------------------------------------------------------------------
;;;;; Editing ------------------------------------------------------------------
(setq-default python-indent-block-paren-deeper t)
(setq-default python-indent-guess-indent-offset nil)
(setq-default python-indent-guess-indent-offset-verbose nil)
(setq-default python-indent-offset 4)

;;;;; zmq ----------------------------------------------------------------------
(use-package zmq
  :ensure (zmq :host github :repo "nnicandro/emacs-zmq"))
;;;;; jupyter ------------------------------------------------------------------
;; (use-package jupyter
;;   :ensure (jupyter :type git :host github :repo "emacs-jupyter/jupyter")
;;   :defer t
;;   :bind ("C-c j p" . tempo-template-org-src-jupyter-:session-py))
;; ;; Copied from nowislewis/nowisemacs
;; (with-eval-after-load 'org
;;   (defun my/org-babel-execute-src-block (&optional _arg info _params)
;;     "Load language if needed"
;;     (let* ((lang (nth 0 info))
;;            (sym (cond ((member (downcase lang) '("c" "cpp" "c++")) 'C)
;;                       ((member (downcase lang) '("jupyter-python")) 'jupyter)
;;                       ((member (downcase lang) '("sh" "bash" "zsh")) 'shell)
;;                       (t (intern lang))))
;;            (backup-languages org-babel-load-languages))
;;       (unless (assoc sym backup-languages)
;;         (condition-case err
;;             (progn
;;               (org-babel-do-load-languages 'org-babel-load-languages (list (cons sym t)))
;;               (setq-default org-babel-load-languages (append (list (cons sym t)) backup-languages)))
;;           (file-missing
;;            (setq-default org-babel-load-languages backup-languages)
;;            err)))))
;;   (advice-add 'org-babel-execute-src-block :before #'my/org-babel-execute-src-block )
;;
;;   (setq org-babel-default-header-args:jupyter '((:kernel . "python") (:async . "yes")))
;;   (add-to-list 'org-src-lang-modes '("jupyter" . python))
;; (setq-default org-confirm-babel-evaluate nil))

;; (use-package pyenv :ensure t :defer t)

;;;; Eldoc ---------------------------------------------------------------------
(setq resize-mini-windows nil
      max-mini-window-height 2)

(use-package eldoc
  :ensure nil
  :diminish
  :config
  ;; (setq max-mini-window-height 1.0)
  ;; (setq eldoc-echo-area-use-multiline-p 'truncate-sym-name-if-fit)
  (setq-default eldoc-idle-delay 0.2
                ;; eldoc-echo-area-use-multiline-p t
                eldoc-echo-area-prefer-doc-buffer t
                eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  ;; (diminish 'eldoc-mode)
  )
;; (diminish 'abbrev-mode)

(use-package eldoc-box
  :ensure t
  :config
  (setq eldoc-box-clear-with-C-g t)
  (with-eval-after-load 'evil
    (define-key evil-normal-state-map (kbd "C-c k") 'eldoc-box-help-at-point)))

;;;; Language server -----------------------------------------------------------
;;;;; Eglot --------------------------------------------------------------------
;; (run-with-idle-timer 10 nil (lambda () (require 'eglot)))
(use-package eglot
  :ensure nil
  :defer t
  :hook ((c-mode          . eglot-ensure)
         (c++-mode        . eglot-ensure)
         (c-ts-mode       . eglot-ensure)
         (c++-ts-mode     . eglot-ensure)
         (python-mode     . eglot-ensure)
         (python-ts-mode  . eglot-ensure)
         (cmake-ts-mode   . eglot-ensure)
         (yaml-ts-mode    . eglot-ensure))

  :custom
  (eglot-sync-connect 0)
  (eglot-autoshutdown t)
  (eglot-sync-connect nil)
  ;; (eglot-events-buffer-size 0)
  ;; (eglot-extend-to-xref t)
  ;; (eglot-report-progress 'messages)
  (eglot-code-action-indications '(eldoc-hint))
  (eglot-code-action-indicator "?")
  ;; (setq-default eglot-send-changes-idle-time 5.0)
  :config
  (setq-default eglot-workspace-configuration
                '((:basedpyright . (:typeCheckingMode "recommended"
                                                      :analysis (:diagnosticSeverityOverrides
                                                                 (:reportUnusedCallResult "none")
                                                                 :inlayHints (:callArgumentNames :json-false))))))
  (fset #'jsonrpc--log-event #'ignore)

  (add-to-list 'eglot-server-programs '((c-mode c++-mode c++-ts-mode) .
                                        ("/opt/homebrew/opt/llvm/bin/clangd"
                                         "--query-driver=/Applications/ARM/bin/arm-none-eabi-g++"
                                         "--clang-tidy"
                                         ;; "--completion-style=detailed"
                                         "--completion-style=bundled"
                                         ;; "--pch-storage=memory"
                                         "--pch-storage=disk"
                                         "--header-insertion=never"
                                         ;; "--background-index-priority=background"
                                         "-j=8")))

  (add-to-list 'eglot-server-programs '((python-mode python-ts-mode)
                                        "basedpyright-langserver"
                                        "--stdio"))

  (add-to-list 'eglot-server-programs '((cmake-mode cmake-ts-mode)
                                        "neocmakelsp"
                                        "--stdio"))

  (add-to-list 'eglot-server-programs '((yaml-mode yaml-ts-mode)
                                        "yaml-language-server"
                                        "--stdio")))


(advice-add 'eglot--mode-line-format :override (lambda () ""))

(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (kill-local-variable 'flymake-indicator-type)))

(with-eval-after-load 'eglot
  (add-hook 'eglot-managed-mode-hook (lambda () (eglot-inlay-hints-mode -1)))
  (set-face-attribute 'eglot-mode-line nil :inherit 'unspecified)

  (defun eglot--format-markup (markup)
    "Format MARKUP according to LSP's spec."
    (pcase-let ((`(,string ,mode)
                 (if (stringp markup) (list markup 'gfm-view-mode)
                   (list (plist-get markup :value)
                         (pcase (plist-get markup :kind)
                           ("markdown" 'gfm-view-mode)
                           ("plaintext" 'text-mode)
                           (_ major-mode))))))
      (with-temp-buffer
        (setq-local markdown-fontify-code-blocks-natively t)
        ;; >>> start of change >>>
        (setq string (replace-regexp-in-string "\n---" "  " string))
        ;; <<< end of change <<<
        (insert string)
        (let ((inhibit-message t)
              (message-log-max nil)
              match)
          (ignore-errors (delay-mode-hooks (funcall mode)))
          (font-lock-ensure)
          (goto-char (point-min))
          (let ((inhibit-read-only t))
            (when (fboundp 'text-property-search-forward)
              (while (setq match (text-property-search-forward 'invisible))
                (delete-region (prop-match-beginning match)
                               (prop-match-end match)))))
          (string-trim (buffer-string)))))))

(use-package eglot-booster
  :ensure
  (eglot-booster :type git :host github :repo "jdtsmith/eglot-booster")
  :defer t
  :config (eglot-booster-mode))

(use-package eglot-inactive-regions
  :ensure t
  :defer t
  :after eglot
  :custom
  (eglot-inactive-regions-opacity 0.4)
  :config
  (eglot-inactive-regions-mode 1))

;;;; Flymake -------------------------------------------------------------------
(use-package flymake
  :ensure nil
  :defer t
  :config
  (setq flymake-start-on-save-buffer t
        flymake-no-changes-timeout 0.2
        flymake-fringe-indicator-position nil
        flymake-indicator-type nil
        flymake-mode-line-lighter nil)

  (add-hook 'sh-mode-hook 'flymake-mode)
  (add-hook 'prog-mode-hook 'flymake-mode)
  (add-hook 'text-mode-hook 'flymake-mode)

  (global-set-key (kbd "C-c f m")   'consult-flymake))

;; (use-package flymake-cursor
;;   :ensure t
;;   :defer t
;;   :config
;;   (setq-default flymake-cursor-number-of-errors-to-display 3))

;;;; Tree-sitter ---------------------------------------------------------------
(use-package kotlin-ts-mode
  :ensure t
  :defer t
  :after treesit)

(use-package treesit
  :ensure nil
  :config
  (add-to-list 'treesit-extra-load-path "~/.cache/emacs/tree-sitter")
  (setq-default c-ts-mode-indent-offset   tab-width
                json-ts-mode-indent-offset 4
                treesit-language-source-alist '((bash         "https://github.com/tree-sitter/tree-sitter-bash")
                                                (c            "https://github.com/tree-sitter/tree-sitter-c")
                                                (cpp          "https://github.com/tree-sitter/tree-sitter-cpp")
                                                (cmake        "https://github.com/uyha/tree-sitter-cmake")
                                                (js           "https://github.com/tree-sitter/tree-sitter-javascript")
                                                (json         "https://github.com/tree-sitter/tree-sitter-json")
                                                (kotlin       "https://github.com/fwcd/tree-sitter-kotlin")
                                                (python       "https://github.com/tree-sitter/tree-sitter-python")
                                                (tsx          "https://github.com/tree-sitter/tree-sitter-typescript")
                                                (typescript   "https://github.com/tree-sitter/tree-sitter-typescript")
                                                (rust         "https://github.com/tree-sitter/tree-sitter-rust")
                                                (yaml         "https://github.com/ikatyang/tree-sitter-yaml")))

  (dolist (pair '(("\\.sh\\'"           . bash-ts-mode)
                  ("\\.c\\'"            . c-ts-mode)
                  ("\\.h\\'"            . c-ts-mode)
                  ("\\.cpp\\'"          . c++-ts-mode)
                  ("\\.hpp\\'"          . c++-ts-mode)
                  ("\\.tpp\\'"          . c++-ts-mode)
                  ("\\.java\\'"         . java-ts-mode)
                  ("\\.js\\'"           . js-ts-mode)
                  ("\\.kts\\'"          . kotlin-ts-mode)
                  ("\\.md\\'"           . json-ts-mode)
                  ("\\.json\\'"         . json-ts-mode)
                  ("\\.ts\\'"           . typescript-ts-mode)
                  ("\\.tsx\\'"          . tsx-ts-mode)
                  ("\\.cmake\\'"        . cmake-ts-mode)
                  ("\\.py\\'"           . python-ts-mode)
                  ("\\.rs\\'"           . rust-ts-mode)
                  ("\\.yaml\\'"         . yaml-ts-mode)
                  ("\\.clangd\\'"       . yaml-ts-mode)
                  ("\\.yml\\'"          . yaml-ts-mode)
                  ("\\.clang-format\\'" . yaml-ts-mode)
                  ("\\.clang-tidy\\'"   . yaml-ts-mode)))
    (push pair auto-mode-alist)))

(defun niva/prompt-treesit-level () (interactive)
       (setq treesit-font-lock-level (string-to-number (consult--prompt :prompt "treesit-font-lock-level: ")))
       (funcall major-mode))

;;;; Formatting ----------------------------------------------------------------
;;;;; Apheleia -----------------------------------------------------------------
(use-package apheleia
  :ensure t
  :init
  ;; Turn on apheleia in all programming buffers.
  (add-hook 'prog-mode-hook #'apheleia-mode)
  :config
  (dolist (fmt '((ruff       . ("ruff" "format" "--silent" "-"))
                 (ruff-isort . ("ruff" "check" "--fix" "--select" "I" "-"))))
    (setf (alist-get (car fmt) apheleia-formatters) (cdr fmt)))

  (dolist (mode '((python-mode     . (ruff ruff-isort))
                  (python-ts-mode  . (ruff ruff-isort))
                  (sh-mode         . (shfmt))
                  (bash-ts-mode    . (shfmt))
                  (c++-mode        . (clang-format))
                  (c++-ts-mode     . (clang-format))
                  (cmake-mode      . (cmake-format))
                  (cmake-ts-mode   . (cmake-format))
                  (c-mode          . nil)
                  (c-ts-mode       . nil)))
    (setf (alist-get (car mode) apheleia-mode-alist) (cdr mode))))


;;;;; Delete empty lines -------------------------------------------------------
(defun niva/delete-empty-lines-at-top ()
  "Delete topmost lines if they contain no characters"
  (interactive)
  (save-excursion
    (when (> (count-lines (point-min) (point-max)) 1)
      (goto-char (point-min))
      (while (and (looking-at "^$") (> (count-lines (point-min) (point-max)) 1))
        (message "Removing empty first line")
        (delete-region (point) (progn (forward-line 1) (point)))))))

(add-hook 'before-save-hook #'niva/delete-empty-lines-at-top)

;;;; Version control -----------------------------------------------------------
;;;;; diff-hl ------------------------------------------------------------------
(defun niva/diff-hl-fix ()
  (interactive)
  (set-face-attribute 'diff-hl-change nil :inherit 'unspecified :background 'unspecified)
  (set-face-attribute 'diff-hl-insert nil :inherit 'unspecified :background 'unspecified)
  (set-face-attribute 'diff-hl-delete nil :inherit 'unspecified :background 'unspecified)
  )

(use-package diff-hl
  :ensure t
  :defer t
  :config

  (defun my-diff-hl-fringe-bmp-function (_type _pos)
    "Fringe bitmap function for use as `diff-hl-fringe-bmp-function'."
    (define-fringe-bitmap 'my-diff-hl-bmp
      (vector
       #b0100
       #b0010
       #b1000
       #b0100
       #b0010
       #b1000
       )
      2 8
      '(center t)))

  ;; (setq diff-hl-fringe-bmp-function #'my-diff-hl-fringe-bmp-function)

  (setq diff-hl-draw-borders t
        diff-hl-side 'left
        diff-hl-margin-symbols-alist '((change  . "=")
                                       (delete  . "-")
                                       (ignored . "i")
                                       (insert  . "+")
                                       (unknown . "u")
                                       ))

  ;; (add-hook 'prog-mode-hook 'niva/diff-hl-fix)
  (diff-hl-margin-mode)
  (global-diff-hl-mode))

;;;;; magit --------------------------------------------------------------------
(use-package magit
  :ensure t
  :defer t
  :config
  (setq ediff-split-window-function 'split-window-horizontally
        ediff-window-setup-function 'ediff-setup-windows-plain
        magit-no-confirm nil
        magit-git-executable "/opt/homebrew/bin/git"
        magit-auto-revert-immediately t)

  (setq magit-section-initial-visibility-alist
        '((stashes . hide) (untracked . hide) (unpushed . hide) ([unpulled status] . show)
          ([file unstaged status] . hide)
          ([file diffbuf] . hide)
          ([file commit stash] . hide)))

  (defun disable-y-or-n-p (orig-fun &rest args)
    (cl-letf (((symbol-function 'y-or-n-p) (lambda (prompt) t)))
      (apply orig-fun args)))

  (advice-add 'ediff-quit :around #'disable-y-or-n-p))


(defun my-replace-git-status (tstr)
  (let* ((tstr (replace-regexp-in-string "Git" "" tstr))
         (first-char (substring tstr 0 1))
         (rest-chars (substring tstr 1)))
    (cond
     ((string= ":" first-char) ;;; Modified
      (replace-regexp-in-string "^:" "*" tstr))
     ((string= "-" first-char) ;; No change
      (replace-regexp-in-string "^-" "-️" tstr))
     (t tstr))))
;; (advice-add #'vc-git-mode-line-string :filter-return #'my-replace-git-status)
;;;; Documentation -------------------------------------------------------------
;;;;; markdown-mode ------------------------------------------------------------
(use-package markdown-mode
  :ensure t
  :defer t
  :config
  (setq markdown-list-item-bullets '(""))
  (set-face-attribute 'markdown-code-face nil :background 'unspecified)
  (set-face-attribute 'markdown-line-break-face nil :underline 'unspecified)
  (setq markdown-hr-display-char nil))

;;;;; helpful ------------------------------------------------------------------
(use-package helpful
  :ensure (:host github :repo "wilfred/helpful")
  :bind (("C-h f" . helpful-callable)
		 ("C-h v" . helpful-variable)
		 ("C-h k" . helpful-key)
		 ("C-h F" . helpful-function)
		 ("C-h C" . helpful-command)
		 ("C-c C-d" . helpful-at-point)))

;;;;; devdocs ------------------------------------------------------------------
(use-package devdocs
  :ensure t
  :defer t
  :config
  (defvar lps/devdocs-alist
    '((python-ts-mode-hook     . "python~3.12")
      (c-ts-mode-hook          . "c")
      (c++-mode-hook           . "cpp")
      (c++-ts-mode-hook        . "cpp")
      (org-mode-hook           . "elisp")
      (emacs-lisp-mode-hook    . "elisp")
      (sh-mode-hook            . "bash")))

  (setq devdocs-window-select t)

  (dolist (pair lps/devdocs-alist)
    (let ((hook (car pair))
          (doc (cdr pair)))
      (add-hook hook `(lambda () (setq-local devdocs-current-docs (list ,doc))))))

  (with-eval-after-load 'evil-maps
    (define-key evil-normal-state-map (kbd "SPC g d")
                (lambda ()
                  (interactive)
                  (devdocs-lookup nil (thing-at-point 'symbol t))))))

;;;; Running tests -------------------------------------------------------------
(defun niva/run-test-command ()
  "Run command for testing"
  (interactive)
  (let* ((command-history (symbol-value 'my-run-test-project-command-history))
         (last-command (car command-history))
         (command (read-shell-command "Test command: " last-command 'my-run-test-project-command-history)))
    (compile command)))
(defvar niva/run-test-command-history nil)

;;;; Compilation mode ----------------------------------------------------------
(use-package xterm-color
  :ensure t
  :config
  (defun from-face (face)
    (face-attribute face :foreground))
  (setq xterm-color-names
        `[,(from-face 'default)
          ,(from-face 'ansi-color-red)
          ,(from-face 'ansi-color-green)
          ,(from-face 'ansi-color-yellow)
          ,(from-face 'ansi-color-blue)
          ,(from-face 'ansi-color-magenta)
          ,(from-face 'ansi-color-cyan)
          ,(from-face 'ansi-color-white)
          ]))

(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)
(defun niva/advice-compilation-filter (f proc string)
  (funcall f proc (xterm-color-filter string)))

(use-package compile
  :ensure nil
  :config
  (setq compilation-error-regexp-alist (delete 'gnu compilation-error-regexp-alist))

  (add-to-list 'compilation-error-regexp-alist-alist
               '(niva--compile-warning
                 "\\[Warning\\] \\(.*?\\):\\([0-9]+\\)"
                 1 2 3
                 0 1))

  (add-to-list 'compilation-error-regexp-alist-alist
               '(niva--compile-error
                 "\\[Error\\] \\(.*?\\):\\([0-9]+\\):?\\([0-9]+\\)?"
                 1 2 3
                 1 1))

  (add-to-list 'compilation-error-regexp-alist-alist
               '(niva--compile-mbed-error
                 "\\[mbed\\] ERROR: \"\\(.*?\\)\""
                 1 nil nil
                 1 1))

  (add-to-list 'compilation-error-regexp-alist-alist
               '(niva--compile-include
                 "^\\(?:In file included \\|                 \\|\t\\)from \ \\([0-9]*[^0-9\n]\\(?:[^\n :]\\| [^-/\n]\\|:[^ \n]\\)*?\\):\ \\([0-9]+\\)\\(?::\\([0-9]+\\)\\)?\\(?:\\([:,]\\|$\\)\\)?"
                 1 2 3
                 (0 . 0) 1))

  (add-to-list 'compilation-error-regexp-alist-alist
               '(niva--compile-include2
                 "\\[ERROR\\] In file included from \\(.*?\\):\\([0-9]+\\),"
                 1 2 nil
                 1 1))

  (add-to-list 'compilation-error-regexp-alist-alist
               '(niva--compile-gcc-warning
                 "^\\(\\.\\/.*?\\|\\/.*?\\):\\([0-9]+\\)?:?\\([0-9]+\\)?: warning:"
                 1 2 3
                 1 1))

  (add-to-list 'compilation-error-regexp-alist-alist
               '(niva--compile-gcc-required
                 "^\\(\\.\\/.*?\\|\\/.*?\\):\\([0-9]+\\)?:?\\([0-9]+\\)?: +required"
                 1 2 3
                 1 1))


  (add-to-list 'compilation-error-regexp-alist-alist
               '(niva--compile-gcc-note
                 "^\\(\\.\\/.*?\\|\\/.*?\\):\\([0-9]+\\)?:?\\([0-9]+\\)?: note:" 1 2 3
                 0 1))

  (add-to-list 'compilation-error-regexp-alist-alist
               '(niva--compile-gcc-error
                 "^\\(\\.\\/.*?\\|\\/.*?\\):\\([0-9]+\\)?:?\\([0-9]+\\)?: error:"
                 1 2 3
                 nil 1))

  (add-to-list 'compilation-error-regexp-alist-alist
               '(niva--compile-sil-passed
                 ".*PASSED.*"
                 nil nil nil
                 0 1))

  (setq compilation-error-regexp-alist nil)
  (add-to-list 'compilation-error-regexp-alist 'niva--compile-sil-passed)
  (add-to-list 'compilation-error-regexp-alist 'niva--compile-warning)
  (add-to-list 'compilation-error-regexp-alist 'niva--compile-error)
  (add-to-list 'compilation-error-regexp-alist 'niva--compile-mbed-error)
  (add-to-list 'compilation-error-regexp-alist 'niva--compile-include)
  (add-to-list 'compilation-error-regexp-alist 'niva--compile-include2)
  (add-to-list 'compilation-error-regexp-alist 'niva--compile-gcc-required)
  (add-to-list 'compilation-error-regexp-alist 'niva--compile-gcc-warning)
  (add-to-list 'compilation-error-regexp-alist 'niva--compile-gcc-note)
  (add-to-list 'compilation-error-regexp-alist 'niva--compile-gcc-error)

  (advice-add 'compilation-filter :around #'niva/advice-compilation-filter))

;;; Org Mode -------------------------------------------------------------------
(use-package org-bullets :ensure t :defer t)
(with-eval-after-load 'org
  (setq org-hide-emphasis-markers t
        org-fontify-quote-and-verse-blocks t
        org-ellipsis " .."
        org-use-sub-superscripts nil)
  (set-face-attribute 'org-ellipsis nil :foreground 'unspecified :underline 'unspecified)

  (setq org-todo-keywords
        '((sequence "TODO" "STARTED" "REVIEW" "|" "DONE" "CANCELED")))

  (setq org-todo-keyword-faces
        '(("TODO" . org-todo)
          ("STARTED" . (:foreground "darkorange3" :weight bold))
          ("REVIEW" . (:foreground "darkblue" :weight bold))))

  (dolist (face '(org-level-1 org-level-2 org-level-3 org-level-4
                              org-level-5 org-level-6 org-level-7 org-level-8))
    (set-face-attribute face nil :weight 'unspecified :height 1.0))

  (setq org-capture-templates
        '(("t" "Todo or Note" entry (file+headline "~/org/notes.org" "Inbox")
           "* TODO %?\ncaptured: %u")))

  (global-set-key (kbd "C-c o c") 'org-capture))
;; (dolist (face '(org-level-1 org-level-2 org-level-3 org-level-4
;;                org-level-5 org-level-6 org-level-7 org-level-8))
;;   (set-face-attribute face nil :inherit 'unspecified :weight 'unspecified :height 1.0)))

;;;; scratch -------------------------------------------------------------------
;; Use org mode in scratch buffer
;; ;; #+begin_src disabled
;; ;; (with-eval-after-load 'org
;; ;;   (setq-default initial-major-mode 'org-mode))
;; ;; #+end_src

;;;; org-tempo -----------------------------------------------------------------
(with-eval-after-load 'org
  (require 'org-tempo)
  (add-to-list 'org-modules 'org-tempo)
  (dolist (pair '(("sh"   . "src sh")
                  ("el"   . "src emacs-lisp")
                  ("els"  . "src emacs-lisp :results silent")
                  ("sc"   . "src scheme")
                  ("ts"   . "src typescript")
                  ("py"   . "src python")
                  ("go"   . "src go")
                  ("yaml" . "src yaml")
                  ("json" . "src json")
                  ("jp"   . "src jupyter :session py")
                  ("cpp"  . "src cpp")))
    (add-to-list 'org-structure-template-alist pair)))

;;;; ob-async ------------------------------------------------------------------
(with-eval-after-load 'org
  (use-package ob-async
    :ensure t
    :defer t
    :config
    (setq ob-async-no-async-languages-alist '("jupyter"))))

;;;; org code blocks -----------------------------------------------------------
(with-eval-after-load 'org
  (setq org-confirm-babel-evaluate nil)
  (defun ek/babel-ansi ()
    (when-let ((beg (org-babel-where-is-src-block-result nil nil)))
      (save-excursion
        (goto-char beg)
        (when (looking-at org-babel-result-regexp)
          (let ((end (org-babel-result-end))
                (ansi-color-context-region nil))
            (ansi-color-apply-on-region beg end))))))
  (add-hook 'org-babel-after-execute-hook 'ek/babel-ansi))

(defun narrow-to-region-indirect (start end)
  "Restrict editing in this buffer to the current region, indirectly."
  (interactive "r")
  (deactivate-mark)
  (let ((buf (clone-indirect-buffer nil nil)))
    (with-current-buffer buf
      (narrow-to-region start end))
    (switch-to-buffer buf)))

;; Disable < matching with (
(defun niva/org-syntax-remove-angle-bracket-match ()
  "Disable < matching with ("
  (interactive)
  (modify-syntax-entry ?< "." org-mode-syntax-table)
  (modify-syntax-entry ?> "." org-mode-syntax-table))

(add-hook 'org-mode-hook #'niva/org-syntax-remove-angle-bracket-match)

;;;; org-roam ------------------------------------------------------------------
;; (use-package org-roam
;;   :ensure t
;;   :defer t
;;   :after org
;;   :config
;;   (when (fboundp 'niva/setup-org-roam)
;;     (niva/setup-org-roam))
;;   (org-roam-db-autosync-enable)
;;   (global-set-key (kbd "C-c z z") 'org-roam-capture)
;;   (setq-default org-roam-ui-browser-function #'xwidget-webkit-browse-url))

;;;;; websocket ----------------------------------------------------------------

;; (use-package websocket
;;   :ensure t
;;   :defer t
;;   :after org-roam)

;;;;; org-roam-ui --------------------------------------------------------------
;; (use-package org-roam-ui
;;   :ensure t
;;   :defer t
;;   :after org-roam
;;   ;; :hook (after-init . org-roam-ui-mode)
;;   :config
;;   (setq org-roam-ui-sync-theme t
;;         org-roam-ui-follow t
;;         org-roam-ui-open-on-start nil
;;         org-roam-ui-update-on-save t))

;;;; visual-fill-column --------------------------------------------------------
(use-package visual-fill-column
  :ensure t)

;;;; adaptive-wrap -------------------------------------------------------------
(use-package adaptive-wrap
  :ensure t
  :defer t
  :hook (visual-line-mode . adaptive-wrap-prefix-mode))

;;; Web ------------------------------------------------------------------------
;;;; shr -----------------------------------------------------------------------
;;;;; shr ----------------------------------------------------------------------
(use-package shr
  :ensure nil
  :defer t
  :config
  (setq shr-use-fonts nil)
  (setq shr-max-width nil)
  (setq shr-fill-text nil)
  (setq shr-use-colors nil))

;;;;; shr-face -----------------------------------------------------------------
(use-package shr-tag-pre-highlight
  :ensure t
  :after shr
  :defer t
  :config
  (defun shrface-shr-tag-pre-highlight (pre)
    "Highlighting code in PRE."
    (let* ((shr-folding-mode 'none)
           (shr-current-font 'default)
           (code (with-temp-buffer
                   (shr-generic pre)
                   (buffer-string)))
           (lang (or (shr-tag-pre-highlight-guess-language-attr pre)
                     (let ((sym (language-detection-string code)))
                       (and sym (symbol-name sym)))))
           (mode (and lang
                      (shr-tag-pre-highlight--get-lang-mode lang))))
      (shr-ensure-newline)
      (shr-ensure-newline)
      (setq start (point))
      (insert
       (propertize (concat "#+begin_src " lang "\n") 'face 'org-block-begin-line)
       (or (and (fboundp mode)
                (with-demoted-errors "Error while fontifying: %S"
                  (shr-tag-pre-highlight-fontify code mode)))
           code)
       (propertize "\n#+end_src" 'face 'org-block-end-line ))
      (shr-ensure-newline)
      (setq end (point))
      (add-face-text-property start end 'org-block)
      (shr-ensure-newline)
      (insert "\n")))
  :config
  (add-to-list 'shr-external-rendering-functions
               '(pre . shrface-shr-tag-pre-highlight))

  (add-to-list 'shr-tag-pre-highlight-lang-modes '("console" . sh))
  (add-to-list 'shr-tag-pre-highlight-lang-modes '("groovy"  . java))
  (add-to-list 'shr-tag-pre-highlight-lang-modes '("json"    . js-json))
  (add-to-list 'shr-tag-pre-highlight-lang-modes '("systemd" . conf))
  (add-to-list 'shr-tag-pre-highlight-lang-modes '("rust"    . rust-ts)))

(use-package shrface
  :ensure t
  :defer t
  :config
  (shrface-basic)
  (shrface-trial)
  (shrface-default-keybindings)
  (setq shrface-href-versatile t))

(add-hook 'eww-mode-hook
          (lambda ()
            (setq visual-fill-column-center-text nil
                  visual-fill-column-fringes-outside-margins t
                  visual-fill-column-extra-text-width '(-4 . 0)
                  visual-fill-column-width 100)
            (adaptive-wrap-prefix-mode 1)
            (visual-fill-column-mode)))

(add-hook 'eww-mode-hook
          (lambda ()
            (setq-local evil-normal-state-cursor '(hollow))))

;;;; eww -----------------------------------------------------------------------
(setq-default browse-url-browser-function 'eww-browse-url
              shr-use-fonts nil
              shr-use-colors t
              eww-search-prefix "https://duckduckgo.com/?q=")

(with-eval-after-load 'eww
  (with-eval-after-load 'evil-maps
    (define-key eww-mode-map (kbd "ö")     (lambda () (interactive) (evil-forward-paragraph) (forward-line 1) (evil-scroll-line-to-center nil)))
    (define-key eww-mode-map (kbd "ä")     (lambda () (interactive) (evil-backward-paragraph 2) (forward-line 1) (evil-scroll-line-to-center nil)))))

(dolist (face '(;; shr-h1
                ;; shr-text
                ;; shr-code
                ;; variable-pitch-text
                gnus-header
                info-title-1
                info-title-2
                info-title-3
                info-title-4
                help-for-help-header
                ;; variable-pitch
                ;; variable-pitch-text
                read-multiple-choice-face
                help-key-binding
                ;; fixed-pitch
                ;; fixed-pitch-serif
                info-menu-header))
  (ignore-errors
    (set-face-attribute face nil
                        :height 'unspecified
                        :inherit 'default
                        ;; :family 'unspecified
                        :weight 'unspecified)))

(defun niva/eww-toggle-images ()
  (interactive)
  (setq-local shr-inhibit-images (not shr-inhibit-images))
  (eww-reload))

;;;; webkit --------------------------------------------------------------------
;; (setq browse-url-browser-function (lambda (url session) (other-window 1) (xwidget-webkit-browse-url url)))
;; (setq-default xwidget-webkit-cookie-file (expand-file-name "webkit-cookies.txt" no-littering-var-directory))
;;
;; (use-package xwidgete :ensure t)
;;
;; (define-key xwidget-webkit-mode-map (kbd "<escape>") #'evil-force-normal-state)
;; (define-key xwidget-webkit-edit-mode-map (kbd "<escape>") #'evil-force-normal-state)
;;
;; (add-hook 'xwidget-webkit-edit-mode-hook
;;           (lambda ()
;;             (deactivate-input-method)
;;             (setq-local input-method-function nil)))

;;;; elfeed --------------------------------------------------------------------
(use-package elfeed
  :ensure t
  :defer t
  ;; :hook (elfeed-search-mode . elfeed-update)
  :config
  (setq elfeed-search-title-max-width 120)
  (setq elfeed-search-filter "+unread")
  (setq elfeed-show-truncate-long-urls nil)
  (setq shr-inhibit-images niva-inhibit-elfeed-images)
  (require 'niva-elfeed))

;; (add-to-list 'display-buffer-alist
;;              '(("\\*elfeed-show\\*"
;;                 (display-buffer-same-window))))

;; mark every elfeed-search window as sacred


(defun niva/elfeed-search-hook ()
  (elfeed-update)
  (set-window-dedicated-p (selected-window) t)
  (visual-line-mode 0)
  (setf (cdr (assq 'truncation   fringe-indicator-alist)) '(nil nil)
        (cdr (assq 'continuation fringe-indicator-alist)) '(nil nil))
  (setq-local truncate-lines t))

(add-hook 'elfeed-search-mode-hook #'niva/elfeed-search-hook)
(add-hook 'elfeed-show-mode-hook (lambda ()
                                   (blink-cursor-mode 0)))
;; (setq-local evil-normal-state-cursor '(nil))

(use-package elfeed-summary
  :ensure t
  :defer t
  :after elfeed
  :config
  (setopt elfeed-summary-settings
          '((group
             (:title . "Tags")
             (:elements
              (search (:title . "alt/games")   (:filter . "+alt/games"))
              (search (:title . "jp/lang")     (:filter . "+jp/lang"))
              (search (:title . "mail/gnu")    (:filter . "+mail/gnu"))
              (search (:title . "alt/music")   (:filter . "+alt/music"))
              (search (:title . "news/bummer") (:filter . "+news/bummer"))
              (search (:title . "tech/news")   (:filter . "+tech/news"))
              (search (:title . "tech/blogs")  (:filter . "+tech/blogs"))
              (search (:title . "tech/sec")    (:filter . "+tech/sec"))
              (search (:title . "")            (:filter . "+none"))
              (search (:title . "stallman")    (:filter . "RMS"))
              (search (:title . "slashdot")    (:filter . "Slashdot"))
              (search (:title . "pluralistic") (:filter . "pluralistic"))
              (search (:title . "unread")      (:filter . "+unread")))))))

;;;; elfeed-protocol -----------------------------------------------------------
(use-package elfeed-protocol
  :ensure t
  :after elfeed
  :defer t
  :config
  (require 'niva-elfeed-protocol)
  (setq elfeed-use-curl t
        elfeed-sort-order 'descending
        elfeed-protocol-enabled-protocols '(fever)
        elfeed-protocol-fever-update-unread-only nil
        elfeed-protocol-fever-maxsize 120
        elfeed-protocol-fever-fetch-category-as-tag t
        elfeed-protocol-feeds (list (list niva/elfeed-fever-url
                                          :api-url niva/elfeed-api-url
                                          :password (niva/lookup-password :host "fever"))))

  (unless niva-enable-evil-mode
    (define-key elfeed-search-mode-map (kbd "x") #'(lambda () (interactive) (elfeed-search-untag-all-unread) (next-line)))
    (define-key elfeed-search-mode-map (kbd "X") #'(lambda () (interactive) (elfeed-search-untag-all-unread) (previous-line))))


  (define-key elfeed-search-mode-map              (kbd "I") #'niva/elfeed-toggle-images)
  (with-eval-after-load 'evil-maps
    (evil-define-key 'normal elfeed-show-mode-map "I" #'niva/elfeed-toggle-images)
    (evil-define-key 'normal elfeed-search-mode-map (kbd "C-p") #'evil-previous-line)
    (evil-define-key 'normal elfeed-search-mode-map (kbd "C-n") #'evil-next-line)
    (evil-define-key 'normal elfeed-search-mode-map (kbd "k") #'evil-previous-line)
    (evil-define-key 'normal elfeed-search-mode-map (kbd "j") #'evil-next-line)
    (evil-define-key 'normal elfeed-search-mode-map (kbd "x") #'(lambda () (interactive) (elfeed-search-untag-all-unread) (next-line)))
    (evil-define-key 'normal elfeed-search-mode-map (kbd "X") #'(lambda () (interactive) (elfeed-search-untag-all-unread) (previous-line)))
    (evil-define-key 'normal elfeed-show-mode-map   (kbd "'") #'niva/elfeed--move-paragraph-up)
    (evil-define-key 'normal elfeed-show-mode-map   (kbd ";") #'niva/elfeed--move-paragraph-down)
    (evil-define-key 'normal elfeed-search-mode-map "r" 'elfeed-update)

    (defun niva/eww--move-paragraph-up ()
      (interactive)
      (if (derived-mode-p 'eww-mode)
          (condition-case nil
              (progn
                (evil-backward-paragraph 2)
                (forward-line 1)
                (evil-scroll-line-to-center nil)))))

    (defun niva/eww--move-paragraph-down ()
      (interactive)
      (if (derived-mode-p 'eww-mode)
          (condition-case nil
              (progn
                (evil-forward-paragraph)
                (evil-scroll-line-to-center nil)
                (forward-line 1)))))

    (evil-define-key 'normal eww-mode-map   (kbd "'") #'niva/eww--move-paragraph-up)
    (evil-define-key 'normal eww-mode-map   (kbd ";") #'niva/eww--move-paragraph-down))

  (elfeed-protocol-enable))


;;;;; Customization ------------------------------------------------------------
(use-package relative-date :ensure (relative-date :host github :repo "rougier/relative-date"))


;;;; Mastodon ------------------------------------------------------------------
;; ;; #+begin_src disabled
;; ;; (use-package mastodon
;; ;;   :ensure (:host codeberg :repo "martianh/mastodon.el")
;; ;;   :defer t
;; ;;   :config
;; ;;   (setq mastodon-active-user "@niklasva"
;; ;;         mastodon-instance-url "https://social.tchncs.de"
;; ;;         mastodon-tl--show-avatars t
;; ;;         mastodon-tl--horiz-bar ""
;; ;;         mastodon-tl--after-update-marker t
;; ;;         mastodon-tl--display-media-p t
;; ;;         mastodon-tl--no-fill-on-render t
;; ;;         mastodon-tl--show-stats nil
;; ;;         mastodon-tl--expand-content-warnings t
;; ;;         mastodon-tl--timeline-posts-count "40")
;; ;;   (custom-set-faces '(mastodon-display-name-face ((t (:inherit 'org-level-1)))))
;; ;;
;; ;;
;; ;;   (defun my-mastodon-more () (interactive) (mastodon-tl--more))
;; ;;   (add-hook 'mastodon-mode-hook (lambda ()
;; ;;                                   (setq-local visual-fill-column-center-text nil
;; ;;                                               visual-fill-column-fringes-outside-margins t
;; ;;                                               visual-fill-column-extra-text-width '(-2 . 0)
;; ;;                                               fill-column 9999
;; ;;                                               visual-fill-column-width 60)
;; ;;                                   (visual-fill-column-mode)))
;; ;;   (define-key mastodon-mode-map (kbd "m")   'my-mastodon-more))
;; ;;
;; ;; (use-package mastodon-alt
;; ;;   :after mastodon
;; ;;   :defer t
;; ;;   :ensure (:host github :repo "rougier/mastodon-alt")
;; ;;   :config
;; ;;   (mastodon-alt-tl-activate)
;; ;;   (setq mastodon-alt-tl-box-width 50
;; ;;         mastodon-media--preview-max-height 150
;; ;;         mastodon-tl--enable-relative-timestamps t
;; ;;         mastodon-tl--enable-relative-timestamps nil)
;; ;;   (defun mastodon-alt-tl--toot-status (toot))
;; ;;   (advice-add 'mastodon-tl--byline :filter-return (lambda (ret) (string-remove-suffix "\n" ret)))
;; ;;   (advice-remove 'mastodon-tl--byline #'mastodon-alt-tl--byline)
;; ;;   (advice-remove 'mastodon-media--process-image-response #'mastodon-alt-media--process-image-response))
;; ;; #+end_src

;;; My packages ----------------------------------------------------------------
;; (use-package iscroll
;;   :ensure t
;;   :diminish iscroll-mode
;;   :hook ((text-mode elfeed-show-mode eww-mode shr-mode) . iscroll-mode))
;;   ;; :config
;;   ;; (evil-define-key 'normal iscroll-mode-map (kbd "k") 'iscroll-previous-line)
;;   ;; (evil-define-key 'normal iscroll-mode-map (kbd "j") 'iscroll-next-line))

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (when (and buffer-file-name
                       (string-match-p "config\\.el$" buffer-file-name))
              (outline-minor-mode 1)
              (setq-local outline-regexp ";; \\[\\[file:"))))

;;; Other ----------------------------------------------------------------------
;; (advice-add 'save-buffers-kill-terminal :around
;;             (lambda (orig-fun &rest args)
;;               (when (y-or-n-p "Really close this Emacsclient frame? ")
;;                 (apply orig-fun args))))

(use-package iscroll
  :ensure t
  :defer t
  :diminish iscroll-mode
  :hook ((text-mode elfeed-show-mode eww-mode shr-mode) . iscroll-mode)
  :config
  (evil-define-key 'normal iscroll-mode-map (kbd "k") 'iscroll-previous-line)
  (evil-define-key 'normal iscroll-mode-map (kbd "j") 'iscroll-next-line))

;; (use-package mixed-pitch
;;   :ensure t
;;   :defer nil
;;   :diminish mixed-pitch-mode
;;   :hook ((eww-mode         . mixed-pitch-mode)
;;          (elfeed-show-mode . mixed-pitch-mode)
;;          (gptel-mode       . mixed-pitch-mode))
;;   :config
;;   (setq mixed-pitch-set-height t)
;;   (custom-set-faces '(variable-pitch ((t (:font "Arial" :height 0.9))))))

(use-package nerd-icons
  :ensure t
  :defer t
  :config
  (setq nerd-icons-color-icons t))

(use-package nerd-icons-completion
  :ensure t
  :defer t
  :config
  (nerd-icons-completion-mode))

(use-package nerd-icons-corfu
  :ensure t
  :defer t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package vterm
  :ensure t
  :defer t
  :bind
  (:map vterm-mode-map
        ("C-c <escape>" . vterm-send-escape))
  :config
  (setq vterm-timer-delay nil))

(setq scroll-margin 0
      scroll-conservatively 101
      scroll-step 1
      auto-window-vscroll nil)

;;; Local variables ------------------------------------------------------------
;; Local Variables:
;; mode: emacs-lisp
;; outline-minor-mode: t
;; outline-regexp: ";;;+ "
;; eval: (progn (require 'outline) (outline-hide-sublevels 1))
;; End:
;;; ----------------------------------------------------------------------------
