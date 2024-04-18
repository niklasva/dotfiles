(setq vc-follow-symlinks t)

(setq native-comp-speed -1)
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
                  '(font                    . "Iosevka Comfy 15"))))

(set-face-attribute 'default nil :font "Iosevka Comfy 15" :height 160 :weight 'regular)

(setq ns-antialias-text t)
(setq ns-use-thin-smoothing t)
(setq ns-use-native-fullscreen t)
(setq custom-safe-themes t)
(setq frame-title-format "")
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode nil)
(menu-bar-mode 1)
(set-fringe-mode 1)

(setq lexical-binding t)
(require 'use-package-core)

(load (expand-file-name "lisp/init-straight.el" user-emacs-directory))
(load (expand-file-name "lisp/theme-packages.el" user-emacs-directory))

(setq niva/theme 'ef-tritanopia-dark)
(load-theme niva/theme)
