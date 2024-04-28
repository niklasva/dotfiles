(setq custom-safe-themes t)

 (use-package kaolin-themes
   :straight t
   :config
   (setq kaolin-themes-bold nil
         kaolin-themes-comments-style 'contrast
         kaolin-themes-italic t
         kaolin-themes-underline t
         kaolin-themes-modeline-border nil))

(use-package doom-themes
  :straight t
  :custom
  (doom-themes-org-config)
  :config
  (setq doom-themes-enable-bold                t
        doom-themes-enable-italic              t
        doom-miramare-brighter-comments        t
        doom-tomorrow-night-brighter-comments  t
        doom-tokyo-night-brighter-comments     t
        doom-city-lights-brighter-comments     t
        doom-monokai-machine-brighter-comments t))

(use-package acme-theme
  :straight t
  :config
  (setq-default acme-theme-black-fg t))

(use-package ef-themes :straight (:host github :repo "protesilaos/ef-themes"))
(use-package almost-mono-themes       :straight t)
(use-package basic-theme              :straight t)
(use-package brutalist-theme          :straight t)
(use-package chyla-theme              :straight t)
(use-package cloud-theme              :straight t)
(use-package color-theme-modern       :straight t)
(use-package colorless-themes         :straight t)
(use-package github-theme             :straight t)
(use-package goose-theme              :straight t)
(use-package grandshell-theme         :straight t)
(use-package hemisu-theme             :straight t)
(use-package modus-themes             :straight t)
(use-package naysayer-theme           :straight t)
(use-package nofrils-acme-theme       :straight t)
(use-package paper-theme              :straight t)
(use-package parchment-theme          :straight t)
(use-package plan9-theme              :straight t)
(use-package professional-theme       :straight t)
(use-package punpun-themes            :straight t)
(use-package sexy-monochrome-theme    :straight t)
(use-package silkworm-theme           :straight t)
(use-package soft-morning-theme       :straight t)
(use-package soft-stone-theme         :straight t)
(use-package standard-themes          :straight t)
(use-package sunny-day-theme          :straight t)
(use-package timu-caribbean-theme     :straight t)
(use-package timu-rouge-theme         :straight t)
(use-package timu-spacegrey-theme     :straight t)

(setq modus-themes-bold-constructs nil
      modus-themes-hl-line (quote (accented))
      modus-themes-org-blocks nil
      modus-themes-region '(bg-only)
      modus-themes-tabs-accented t)

(setq modus-themes-common-palette-overrides
      '((fringe unspecified)
        (border-mode-line-active unspecified)
        (border-mode-line-inactive unspecified)))

(setq modus-themes-completions '((matches . (background minimal))
                                 (selection . (background minimal))
                                 (popup . (background minimal))))


(add-hook 'modus-themes-after-load-theme-hook
          (lambda ()
            (set-face-attribute 'solaire-default-face nil
                                :inherit 'default
                                :background (car (cdr (assoc 'bg-dim modus-operandi-palette)))
                                :foreground (car (cdr (assoc 'fg-dim modus-operandi-palette))))
            (set-face-attribute 'solaire-line-number-face nil
                                :inherit 'solaire-default-face
                                :foreground (car (cdr (assoc 'fg-unfocused modus-operandi-palette))))
            (set-face-attribute 'solaire-hl-line-face nil
                                :background (car (cdr (assoc 'bg-active modus-operandi-palette))))
            (set-face-attribute 'solaire-org-hide-face nil
                                :background (car (cdr (assoc 'bg-dim modus-operandi-palette)))
                                :foreground (car (cdr (assoc 'bg-dim modus-operandi-palette))))))
