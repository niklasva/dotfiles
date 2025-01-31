(setq package-enable-at-startup nil)
(setq gc-cons-threshold most-positive-fixnum)
(setq vc-follow-symlinks t)
(setq native-comp-speed -1)
(setq lexical-binding t)

(load (expand-file-name "lisp/init-straight.el" user-emacs-directory))

(setq-default header-line-format (buffer-file-name))

(setq default-frame-alist
      (append (list '(min-height              . 1)
                    '(height                  . 45)
                    '(min-width               . 1)
                    '(width                   . 155)
                    '(internal-border-width   . 10)
                    '(vertical-scroll-bars    . nil)
                    '(tool-bar-lines          . 0)
                    '(ns-transparent-titlebar . t)
                    '(ns-appearance           . light)
                    '(visibility              . nil)
                    '(undecorated-round       . t)
                    '(font                    . "MxPlus IBM VGA 8x16 16"))))

                                        ; (custom-theme-set-faces 'user '(default ((t (:font "MxPlus ToshibaSat 8x16 16" :weight unspecified :height unspecified)))))

(custom-theme-set-faces 'user '(default ((t (:font "MxPlus IBM VGA 8x16 16" :weight unspecified :height unspecified)))))

;; (custom-theme-set-faces 'user '(default ((t (:font "MxPlus AST PremiumExec 20" :weight unspecified :height unspecified)))))

(setq ns-antialias-text nil)

(use-package benchmark-init
  :straight t
  :config
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

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
