;;; theme-packages.el --- Theme-related configuration
;;; Commentary:
;;; Code:

;;; General settings
(setq custom-safe-themes t)
(add-to-list 'custom-theme-load-path (concat user-emacs-directory "themes"))

;; Bing Bong
(use-package bing-bong-dark-theme  :commands (niva/toggle-bing-bong-dark)  :load-path "themes")
(use-package bing-bong-light-theme :commands (niva/toggle-bing-bong-light) :load-path "themes")

;;; Kaolin Themes
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

;;; Doom Themes
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

;;; Other theme packages
(use-package acme-theme
  :straight t
  :defer t
  :config
  (setq-default acme-theme-black-fg t))

(use-package ef-themes
  :straight (:host github :repo "protesilaos/ef-themes")
  :defer t)

(use-package os1-theme
  :straight (:type git :host github :repo "sashimacs/os1-theme")
  :defer t)

(use-package colorless-themes
  :straight (:host github :repo "lthms/colorless-themes.el" :files ("colorless-themes.el" "*.el")))

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

;;; Modus Themes
(use-package modus-themes
  :straight t
  :defer t
  :config
  (setq modus-themes-bold-constructs nil
        modus-themes-hl-line '(accented)
        modus-themes-org-blocks nil
        modus-themes-region '(bg-only)
        modus-themes-tabs-accented t)

  (setq modus-themes-common-palette-overrides
        '((fringe unspecified)))

  (setq modus-themes-completions '((matches . (background minimal))
                                   (selection . (background minimal))
                                   (popup . (background minimal)))))

;;; Helpers
(defun niva/theme-is-active (theme-name)
  "Return non-nil if THEME-NAME is currently enabled."
  (cl-some (lambda (theme)
             (string-match-p theme-name (symbol-name theme)))
           custom-enabled-themes))

;;; Custom face updates per theme
(defun niva/update-theme-faces ()
  "Adjust certain face settings depending on the active theme."
  (interactive)
  (ignore-errors
    (when (null custom-enabled-themes)
      (custom-set-faces '(org-block            ((t (:inherit 'default))))
                        '(org-block-begin-line ((t (:inherit 'org-block :extend t :overline t   :underline nil))))
                        '(org-block-end-line   ((t (:inherit 'org-block :extend t :overline nil :underline t))))))

    (when (niva/theme-is-active "ryerson")
      (custom-set-faces '(font-lock-comment-face ((t (:inherit 'unspecified :foreground "lightblue"))))
                        '(org-block              ((t (:inherit 'default :foreground 'unspecified))))))

    (when (niva/theme-is-active "less")
      (custom-set-faces '(elfeed-search-unread-title-face ((t :inherit 'default :foreground 'unspecified)))
                        '(elfeed-search-title-face        ((t (:inherit 'shadow :foreground "darkgray"))))
                        '(elfeed-search-feed-face         ((t (:inherit 'shadow :foreground "darkgray"))))
                        '(elfeed-search-tag-face          ((t (:inherit 'shadow :foreground "darkgray"))))))

    (when (niva/theme-is-active "naysayer")
      (custom-set-faces '(mode-line-inactive   ((t (:box t))))
                        '(mode-line            ((t (:box t))))
                        '(default              ((t (:foreground "#DACAAE"))))
                        '(header-line          ((t (:foreground unspecified :background unspecified :inherit 'mode-line-inactive :box t))))
                        '(flymake-error-echo   ((t (:background "black" :box t :inverse-video nil :bold t))))
                        '(flymake-warning-echo ((t (:background "black" :box t :inverse-video nil :bold t))))
                        '(flymake-note-echo    ((t (:background "black" :box t :inverse-video nil :bold t))))
                        '(link                 ((t (:inherit 'font-lock-comment-face))))))

    (when (niva/theme-is-active "sitaramv-solaris")
      (custom-set-faces '(org-block                       ((t (:inherit 'default :background "black"))))
                        '(org-block-begin-line            ((t (:background "black"))))
                        '(font-lock-comment-face          ((t (:inherit 'font-lock-builtin-face :slant unspecified :foreground unspecified))))
                        '(font-lock-string-face           ((t (:foreground "cyan"))))
                        '(font-lock-function-name-face    ((t (:foreground "yellow"))))
                        '(elfeed-search-title-face        ((t (:foreground "darkgray"))))
                        '(elfeed-search-unread-title-face ((t (:foreground "white"))))
                        '(font-lock-preprocessor-face     ((t (:foreground "green"))))))

    (when (niva/theme-is-active "doom-tomorrow-night")
      (custom-set-faces '(font-lock-number-face       ((t (:foreground unspecified :inherit 'font-lock-builtin-face))))
                        '(font-lock-variable-use-face ((t (:foreground unspecified :inherit 'default))))
                        '(font-lock-constant-face     ((t (:foreground unspecified :inherit 'font-lock-number-face))))
                        '(warning                     ((t (:foreground unspecified :inherit 'font-lock-builtin-face))))
                        '(font-lock-type-face         ((t (:foreground unspecified :inherit 'font-lock-builtin-face))))))

    (when (or (niva/theme-is-active "nofrils-acme") (niva/theme-is-active "acme"))
      (custom-set-faces '(org-block            ((t (:background "#FFFFDC")))))
      '(org-block-begin-line ((t (:extend t :overline t :underline nil :background "#FFFFDC"))))
      '(org-block-end-line   ((t (:extend t :overline nil :underline t :background "#FFFFDC")))))

    (when (or (niva/theme-is-active "wombat") (niva/theme-is-active "naysayer"))
      (custom-set-faces '(org-block            ((t (:background "#182C32"))))
                        '(org-block-begin-line ((t (:inherit 'default :extend t :overline t :underline nil :background "#182C32"))))
                        '(org-block-end-line   ((t (:inherit 'default :extend t :overline nil :underline t :background "#182C32"))))))

    (niva/diff-hl-fix))
  (custom-set-faces '(help-key-binding nil :box nil :background 'unspecified :foreground (face-attribute 'default :foreground))))
;;; theme-packages.el ends here
