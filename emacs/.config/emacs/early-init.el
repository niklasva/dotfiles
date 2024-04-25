(setq vc-follow-symlinks t)
(setq native-comp-speed -1)
(setq lexical-binding t)

(setq default-frame-alist
      (append (list '(min-height              . 1)
                    '(height                  . 45)
                    '(min-width               . 1)
                    '(width                   . 155)
                    '(internal-border-width   . 0)
                    '(vertical-scroll-bars    . nil)
                    '(tool-bar-lines          . 0)
                    '(ns-transparent-titlebar . t)
                    '(ns-appearance           . dark)
                    '(font                    . "Mononoki 14"))))

(load (expand-file-name "lisp/init-straight.el" user-emacs-directory))
(load (expand-file-name "lisp/theme-packages.el" user-emacs-directory))

(setq frame-resize-pixelwise t
      frame-title-format ""
      ns-antialias-text t
      ns-use-proxy-icon nil
      ns-use-thin-smoothing t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode nil)
(menu-bar-mode 1)
(set-fringe-mode 1)

(setq niva/theme 'doom-dark+)
(load-theme niva/theme)
