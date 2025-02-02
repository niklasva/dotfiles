(setq custom-safe-themes t)
(add-to-list 'custom-theme-load-path (concat user-emacs-directory "themes"))

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

(use-package acme-theme       :straight t :defer t :config (setq-default acme-theme-black-fg t))
(use-package ef-themes        :straight (:host github :repo "protesilaos/ef-themes") :defer t)
(use-package os1-theme        :straight (:type git :host github :repo "sashimacs/os1-theme") :defer t)
(use-package colorless-themes :straight (:host github :repo "lthms/colorless-themes.el" :files ("colorless-themes.el" "*.el")))

(use-package almost-mono-themes    :straight t :defer t)
(use-package basic-theme           :straight t :defer t)
(use-package chocolate-theme       :straight t :defer t)
(use-package color-theme-modern    :straight t :defer t)
(use-package goose-theme           :straight t :defer t)
(use-package naysayer-theme        :straight t :defer t)
(use-package paper-theme           :straight t :defer t)
(use-package parchment-theme       :straight t :defer t)
(use-package professional-theme    :straight t :defer t)
(use-package standard-themes       :straight t :defer t)

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


(defun niva/toggle-bing-bong-dark ()
  (interactive)
  (if (member 'bing-bong-dark custom-enabled-themes)
      (progn
        (disable-theme 'bing-bong-dark))
    (progn
      (load-theme 'bing-bong-dark t))))

(defun niva/toggle-bing-bong-light ()
  (interactive)
  (if (member 'bing-bong-light custom-enabled-themes)
      (progn
        (disable-theme 'bing-bong-light))
    (progn
      (load-theme 'bing-bong-light t))))
