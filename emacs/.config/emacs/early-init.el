;;; early-init.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(setq default-frame-alist
      (append (list '(min-height              . 1)
                    '(height                  . 45)
                    '(min-width               . 1)
                    '(width                   . 155)
                    '(internal-border-width   . 10)
                    '(vertical-scroll-bars    . nil)
                    '(tool-bar-lines          . 0)
                    '(ns-transparent-titlebar . t)
                    '(ns-appearance           . light))))

(setq-default package-enable-at-startup nil)
(setq-default gc-cons-threshold most-positive-fixnum)
(setq-default vc-follow-symlinks t)
(setq-default native-comp-speed -1)
(setq-default lexical-binding t)
(setq-default gnus-init-inhibit t)

(custom-set-variables
 '(org-modules nil))

(setq-default header-line-format (buffer-file-name))
(load (expand-file-name "lisp/init-straight.el" user-emacs-directory))
(load (expand-file-name "lisp/theme-packages.el" user-emacs-directory))
(use-package benchmark-init :straight t :config (add-hook 'after-init-hook 'benchmark-init/deactivate))

(setq-default frame-resize-pixelwise t
              frame-title-format ""
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
