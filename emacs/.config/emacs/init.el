(setq-default niva-use-new-config        t)
(setq-default niva-enable-evil-mode      t)
(setq-default niva-inhibit-elfeed-images nil)
(setq-default niva-inhibit-eww-images    nil)

(ignore-errors
  (load (expand-file-name "local-env.el" user-emacs-directory)))

(if niva-use-new-config
    (org-babel-load-file (expand-file-name "new-init.el" user-emacs-directory))
  (org-babel-load-file (expand-file-name "config.org" user-emacs-directory)))
