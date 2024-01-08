(setq package-enable-at-startup nil)
(setq native-comp-speed -1)
(setq default-frame-alist
      (append (list
               '(min-height              . 1)
               '(height                  . 45)
               '(min-width               . 1)
               '(width                   . 155)
               '(vertical-scroll-bars    . nil)
               '(internal-border-width   . 0)
               ;; '(left-fringe             . 7)
               ;; '(right-fringe            . 7)
               '(tool-bar-lines          . 0)
               ;;'(undecorated-round       . t)
               '(ns-transparent-titlebar . t)
               '(ns-appearance           . dark)
               '(font                    . "Liga Mononoki 16"))))

(set-face-attribute 'default nil :font "Liga Mononoki 16")

(setq ns-antialias-text t)
(setq ns-use-thin-smoothing nil)
(setq custom-safe-themes t)

;; (ignore-errors
;;   (load-theme 'wheatgrass))

(setq lexical-binding t)
(require 'use-package-core)
