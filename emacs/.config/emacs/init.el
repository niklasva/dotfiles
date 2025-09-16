;; -*- lexical-binding: t; -*-

(defvar my-after-init-complete-hook nil)
(setq-default niva-use-new-config        nil)
(setq-default niva-enable-evil-mode      t)
(setq-default niva-inhibit-elfeed-images t)
(setq-default niva-inhibit-eww-images    t)
;; (setq inhibit-startup-message t
;;       inhibit-startup-echo-area-message nil)

;; (elpaca benchmark-init
;;   (require 'benchmark-init)
;;   (benchmark-init/activate))

(load (expand-file-name "lisp/theme-packages.el" user-emacs-directory))

(load (expand-file-name "local-env.el" user-emacs-directory))

;; Don't show eldoc mode at startup
;; (diminish 'eldoc-mode)


;; (setq inhibit-message t)
(use-package pinentry :ensure t :defer t :config (pinentry-start))
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(defconst private-config-file (expand-file-name "private/config.el" user-emacs-directory))
(when (file-readable-p private-config-file) (load-file private-config-file))
;; (org-babel-load-file (expand-file-name "config.org" user-emacs-directory))
;; (load-file (expand-file-name "config.el" user-emacs-directory))

(let* ((org (expand-file-name "config.org" user-emacs-directory))
       (el  (expand-file-name "config.el"  user-emacs-directory)))
  (when (file-newer-than-file-p org el)
    (require 'org)                ;; ensure org is loaded only when needed for tangling
    (org-babel-tangle-file org el))
  (load el nil 'nomessage))

(setq inhibit-message nil)
(setq inhibit-redisplay nil)

(run-hooks 'my-after-init-complete-hook)

