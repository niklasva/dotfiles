(setq vc-follow-symlinks t)

(setq package-enable-at-startup nil)
(defvar bootstrap-version)
(let ((bootstrap-file
        (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
      (url-retrieve-synchronously
        "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
        'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
  (straight-use-package 'org)
(straight-use-package 'use-package)


;; (if (file-exists-p "~/.config/emacs/config.elc")
;;   (load "~/.config/emacs/config.elc")
;;   (if (file-exists-p "~/.config/emacs/config.el")
;;     (load (expand-file-name "config.el" user-emacs-directory))
;;     (org-babel-load-file (expand-file-name "config.org" user-emacs-directory))))

(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))
