;;; early-init.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(setq vc-follow-symlinks t)
(load (expand-file-name "lisp/init-straight.el" user-emacs-directory))

(setq default-frame-alist
      (append (list '(min-height              . 1)
                    '(height                  . 45)
                    '(min-width               . 1)
                    '(width                   . 115)
                    '(internal-border-width   . 24)
                    '(vertical-scroll-bars    . nil)
                    '(tool-bar-lines          . 0)
                    '(ns-transparent-titlebar . t)
                    '(ns-appearance           . light)
                    '(left-fringe             . 1)
                    '(right-fringe            . 1))))

(setq-default window-divider-default-right-width 24)
(setq-default window-divider-default-places 'right-only)

(setq-default package-enable-at-startup nil)

(setq-default gc-cons-threshold most-positive-fixnum)
(setq-default vc-follow-symlinks t)
(setq-default native-comp-speed 2)
(setq-default lexical-binding t)
(setq-default gnus-init-inhibit t)

(custom-set-variables
 '(org-modules nil))

(setq-default header-line-format (buffer-file-name))
(load (expand-file-name "lisp/theme-packages.el" user-emacs-directory))
(use-package benchmark-init :straight t :config (add-hook 'after-init-hook 'benchmark-init/deactivate))

(setq-default frame-resize-pixelwise t
              window-resize-pixelwise t
              ns-antialias-text t
              ns-use-native-fullscreen t
              ns-use-proxy-icon nil
              ns-use-thin-smoothing t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode nil)

(unless (eq system-type 'darwin)
  (menu-bar-mode -1))

(set-fringe-mode 1)
