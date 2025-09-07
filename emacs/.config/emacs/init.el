;; -*- lexical-binding: t; -*-

(setq-default niva-use-new-config        nil)
(setq-default niva-enable-evil-mode      t)
(setq-default niva-inhibit-elfeed-images t)
(setq-default niva-inhibit-eww-images    t)
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message nil)

(load (expand-file-name "lisp/init-straight.el" user-emacs-directory))
(use-package benchmark-init :straight t :config (add-hook 'after-init-hook 'benchmark-init/deactivate))
(load (expand-file-name "lisp/theme-packages.el" user-emacs-directory))

(ignore-errors
  (load (expand-file-name "local-env.el" user-emacs-directory)))
(make-frame-visible)

;; Don't show eldoc mode at startup
(diminish 'eldoc-mode)

;; Quiet init
(run-with-idle-timer
 0.01 nil
 (lambda ()
   (setq inhibit-message t)
   (use-package org :straight t)
   (use-package pinentry :straight t :config (pinentry-start))
   (add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
   (defconst private-config-file (expand-file-name "private/config.el" user-emacs-directory))
   (when (file-readable-p private-config-file) (load-file private-config-file))
   (require 'time-since)

   (use-package exec-path-from-shell
     :straight t
     :init (exec-path-from-shell-initialize))

   (if niva-use-new-config
       (org-babel-load-file (expand-file-name "new-init.el" user-emacs-directory))
     (org-babel-load-file (expand-file-name "config.org" user-emacs-directory)))
   (setq inhibit-message nil)))
