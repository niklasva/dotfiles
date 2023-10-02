(setq package-enable-at-startup nil)
(setq default-frame-alist
        (append (list
                 '(min-height              . 1)
                 '(height                  . 45)
                 '(min-width               . 1)
                 '(width                   . 155)
                 '(vertical-scroll-bars    . nil)
                 '(internal-border-width   . 8)
                 '(left-fringe             . 3)
                 '(right-fringe            . 3)
                 '(tool-bar-lines          . 0)
                 '(ns-transparent-titlebar . t)
                 '(ns-appearance           . dark)
                 '(font                    . "Unifont 16"))))

(setq lexical-binding t)
(require 'use-package-core)
