(setq use-new-config nil) 
(if use-new-config
    (org-babel-load-file (expand-file-name "new-init.el" user-emacs-directory))
  (org-babel-load-file (expand-file-name "config.org" user-emacs-directory)))
