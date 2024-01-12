(setq package-enable-at-startup nil)
(setq native-comp-speed -1)
(setq default-frame-alist
    (append (list '(min-height              . 1)
                  '(height                  . 45)
                  '(min-width               . 1)
                  '(width                   . 155)
                  '(internal-border-width   . 24)
                  '(vertical-scroll-bars    . nil)
                  '(tool-bar-lines          . 0)
                  '(ns-transparent-titlebar . t)
                  '(ns-appearance           . dark)
                  '(font                    . "Iosevka Comfy 17"))))

(set-face-attribute 'default nil :font "Iosevka Comfy 17" :weight 'regular)

(setq ns-antialias-text t)
(setq ns-use-thin-smoothing nil)
(setq ns-use-native-fullscreen nil)
(setq custom-safe-themes t)

;;(ignore-errors
;;    (load-theme 'wheatgrass))

(setq lexical-binding t)
(require 'use-package-core)
