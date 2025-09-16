;; -*- lexical-binding: t; -*-

(defvar my-after-init-complete-hook nil)


(setq niva-use-new-config        nil
      niva-enable-evil-mode      t
      niva-inhibit-elfeed-images t
      niva-inhibit-eww-images    t)

(use-package pinentry :ensure t :defer t :config (pinentry-start))

(load (expand-file-name "lisp/theme-packages.el" user-emacs-directory))
(load (expand-file-name "local-env.el" user-emacs-directory))


(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(defconst private-config-file (expand-file-name "private/config.el" user-emacs-directory))

(when (file-readable-p private-config-file) (load-file private-config-file))
(let* ((org (expand-file-name "config.org" user-emacs-directory))
       (el  (expand-file-name "config.el"  user-emacs-directory)))
  (when (file-newer-than-file-p org el)
    (require 'org)
    (org-babel-tangle-file org el))
  (load el nil 'nomessage))

(setq inhibit-message nil)
(setq inhibit-redisplay nil)

(run-hooks 'my-after-init-complete-hook)
