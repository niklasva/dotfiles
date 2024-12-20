(setq custom-safe-themes t)

(use-package kaolin-themes
  :straight (:host github :repo "ogdenwebb/emacs-kaolin-themes")
  :defer t
  :config
  (setq kaolin-themes-bold t
        kaolin-themes-comments-style 'contrast
        kaolin-themes-italic t
        kaolin-themes-italic-comments t
        kaolin-themes-underline t
        kaolin-themes-org-scale-headings nil
        kaolin-themes-modeline-border nil))

(use-package doom-themes
  :straight t
  :defer t
  :custom
  (doom-themes-org-config)
  :config
  (setq doom-themes-enable-bold                nil
        doom-themes-enable-italic              t
        doom-miramare-brighter-comments        t
        doom-tomorrow-night-brighter-comments  t
        doom-tokyo-night-brighter-comments     t
        doom-city-lights-brighter-comments     t
        doom-monokai-machine-brighter-comments t))

(use-package acme-theme
  :straight t
  :defer t
  :config
  (setq-default acme-theme-black-fg t))

(use-package catppuccin-theme
  :straight t
  :defer t
  :config
  (setq-default catppuccin-flavor 'mocha))

(use-package ef-themes
  :straight (:host github :repo "protesilaos/ef-themes")
  :defer t)

(use-package os1-theme
  :straight (:type git :host github :repo "sashimacs/os1-theme")
  :defer t)

(use-package colorless-themes
  :straight (:host github :repo "lthms/colorless-themes.el"
                   :files ("colorless-themes.el" "*.el")))

(use-package almost-mono-themes    :straight t :defer t)
(use-package avk-emacs-themes      :straight t :defer t)
(use-package base16                :straight t :defer t)
(use-package basic-theme           :straight t :defer t)
(use-package chocolate-theme       :straight t :defer t)
(use-package chyla-theme           :straight t :defer t)
(use-package cloud-theme           :straight t :defer t)
(use-package color-theme-modern    :straight t :defer t)
(use-package goose-theme           :straight t :defer t)
(use-package grandshell-theme      :straight t :defer t)
(use-package lab-themes            :straight t :defer t)
(use-package minimal-theme         :straight t :defer t)
(use-package naysayer-theme        :straight t :defer t)
(use-package nofrils-acme-theme    :straight t :defer t)
(use-package paper-theme           :straight t :defer t)
(use-package parchment-theme       :straight t :defer t)
(use-package plan9-theme           :straight t :defer t)
(use-package professional-theme    :straight t :defer t)
(use-package punpun-themes         :straight t :defer t)
(use-package sexy-monochrome-theme :straight t :defer t)
(use-package silkworm-theme        :straight t :defer t)
(use-package soft-morning-theme    :straight t :defer t)
(use-package soft-stone-theme      :straight t :defer t)
(use-package standard-themes       :straight t :defer t)
(use-package sunny-day-theme       :straight t :defer t)
(use-package timu-caribbean-theme  :straight t :defer t)
(use-package timu-rouge-theme      :straight t :defer t)
(use-package timu-spacegrey-theme  :straight t :defer t)
(use-package ubuntu-theme          :straight t :defer t)

(use-package modus-themes
  :straight t
  :defer t
  :config
  (setq modus-themes-bold-constructs nil
        modus-themes-hl-line (quote (accented))
        modus-themes-org-blocks nil
        modus-themes-region '(bg-only)
        modus-themes-tabs-accented t)

  (setq modus-themes-common-palette-overrides
        '((fringe unspecified)))

  (setq modus-themes-completions '((matches . (background minimal))
                                   (selection . (background minimal))
                                   (popup . (background minimal)))))
