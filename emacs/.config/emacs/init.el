(setq vc-follow-symlinks t)

(if (file-exists-p "~/.config/emacs/config.elc")
  (load "~/.config/emacs/config.elc")
  (if (file-exists-p "~/.config/emacs/config.elc")
    (org-babel-load-file (expand-file-name "config.el" user-emacs-directory))
    (org-babel-load-file (expand-file-name "config.org" user-emacs-directory))))
