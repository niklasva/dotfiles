(setq package-enable-at-startup nil)
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
                  '(font                    . "MxPlus IBM VGA 8x16 16"))))

(set-face-attribute 'default nil :font "MxPlus IBM VGA 8x16" :height 160 :weight 'regular)

(setq ns-antialias-text nil)
(setq ns-use-thin-smoothing nil)
(setq ns-use-native-fullscreen nil)
(setq custom-safe-themes t)
(setq frame-title-format "")
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode nil)
(menu-bar-mode 1)
(set-fringe-mode 1)

;;(ignore-errors
;;    (load-theme 'wheatgrass))

(setq lexical-binding t)
(require 'use-package-core)
