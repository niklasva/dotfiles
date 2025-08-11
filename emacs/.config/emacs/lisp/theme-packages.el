;;; theme-packages.el --- Theme-related configuration  -*- lexical-binding: t; -*-
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

(use-package ef-themes          :straight (:host github :repo "protesilaos/ef-themes")                :defer t)
(use-package orangey-bits-theme :straight (:host github :repo "emacsfodder/emacs-theme-orangey-bits") :defer t)
(use-package cyanometric-theme  :straight (:host github :repo "emacsfodder/emacs-theme-cyanometric")  :defer t)
(use-package vegetative-theme   :straight (:host github :repo "emacsfodder/emacs-theme-vegetative")   :defer t)
(use-package dark-krystal-theme :straight (:host github :repo "emacsfodder/emacs-dark-krystal-theme") :defer t)
(use-package doric-themes       :straight (:host github :repo "protesilaos/doric-themes")             :defer t)
(use-package os1-theme          :straight (:host github :repo "sashimacs/os1-theme")                  :defer t)
(use-package south              :straight (:host github :repo "sophiebosio/south")                    :defer t)
(use-package mruber-darker      :straight (:host github :repo "monteiroliveira/mruber-darker-theme")  :defer t)
(use-package colorless-themes   :straight (:host github :repo "lthms/colorless-themes.el"             :files ("colorless-themes.el" "*.el")))

(use-package alect-themes          :straight t :defer t)
(use-package almost-mono-themes    :straight t :defer t)
(use-package basic-theme           :straight t :defer t)
(use-package chocolate-theme       :straight t :defer t)
(use-package color-theme-modern    :straight t :defer t)
(use-package goose-theme           :straight t :defer t)
(use-package moe-theme             :straight t :defer t)
(use-package naysayer-theme        :straight t :defer t)
(use-package paper-theme           :straight t :defer t)
(use-package parchment-theme       :straight t :defer t)
(use-package professional-theme    :straight t :defer t)
(use-package standard-themes       :straight t :defer t)
(use-package tomorrow-night-deepblue-theme :straight t :defer t)

(use-package solarized-theme
  :straight t
  :defer t
  :custom
  (solarized-scale-org-headlines nil)
  (solarized-scale-outline-headlines nil)
  (solarized-scale-markdown-headlines nil)
  (solarized-use-less-bold t)
  (solarized-highlight-numbers t)
  (solarized-high-contrast-mode-line nil))

(use-package lambda-themes
  :straight (:host github :repo "lambda-emacs/lambda-themes")
  :defer t
  :config
  (setq-default lambda-themes-set-italic-comments t)
  (setq-default lambda-themes-set-italic-keywords t)
  (setq-default lambda-themes-set-variable-pitch t))

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
    (when (or (null custom-enabled-themes) (niva/theme-is-active "bing-bong-light"))
      (custom-set-faces
       '(default                   ((t (:foreground "#000"))))
       '(org-block                   ((t (:inherit 'default))))
       '(org-block-begin-line        ((t (:inherit 'org-block :extend t :overline t   :underline nil))))
       '(org-block-end-line          ((t (:inherit 'org-block :extend t :overline nil :underline t))))
       '(eglot-highlight-symbol-face ((t (:underline nil :bold t))))))

    (when (niva/theme-is-active "doric")
      (custom-set-faces '(font-lock-type-face          ((t :inherit unspecified :bold t)))
                        '(font-lock-builtin-face       ((t (:inherit unspecified :bold t))))
                        '(font-lock-variable-name-face ((t (:inherit unspecified))))))

    (when (niva/theme-is-active "doom-tomorrow-day")
      (custom-set-faces '(font-lock-number-face ((t (:foreground unspecified :inherit 'font-lock-builtin-face))))))

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

    (when (niva/theme-is-active "acme")
      (custom-set-faces '(font-lock-variable-name-face ((t (:weight unspecified)))))
      (custom-set-faces '(font-lock-function-name-face ((t (:weight unspecified)))))
      (custom-set-faces '(font-lock-constant-face ((t (:weight unspecified)))))
      (custom-set-faces '(font-lock-type-face ((t (:weight unspecified)))))
      (custom-set-faces '(font-lock-keyword-face ((t (:weight unspecified)))))
      (custom-set-faces '(org-block ((t (:background "#FFFFDC"))))
                        '(org-block-begin-line ((t (:extend t :overline t :underline nil :background "#FFFFDC"))))
                        '(org-block-end-line   ((t (:extend t :overline nil :underline t :background "#FFFFDC"))))
                        '(highlight   ((t (:inherit region :bold t :underline nil))))
                        ))

    (when (niva/theme-is-active "ryerson")
      (custom-set-faces '(font-lock-comment-face ((t (:inherit 'unspecified :foreground "lightblue"))))
                        '(org-block              ((t (:inherit 'default :foreground 'unspecified))))))

    (when (niva/theme-is-active "sitaramv-solaris")
      (custom-set-faces '(org-block                       ((t (:inherit 'default :background "black"))))
                        '(org-block-begin-line            ((t (:background "black"))))
                        '(font-lock-comment-face          ((t (:inherit 'font-lock-builtin-face :slant unspecified :foreground unspecified))))
                        '(font-lock-string-face           ((t (:foreground "cyan"))))
                        '(font-lock-function-name-face    ((t (:foreground "yellow"))))
                        '(elfeed-search-title-face        ((t (:foreground "darkgray"))))
                        '(elfeed-search-unread-title-face ((t (:foreground "white"))))
                        '(font-lock-preprocessor-face     ((t (:foreground "green"))))))

    (when (niva/theme-is-active "solarized")
      (custom-set-faces '(font-lock-variable-name-face ((t (:weight unspecified)))))
      (custom-set-faces '(font-lock-function-name-face ((t (:weight unspecified)))))
      (custom-set-faces '(font-lock-constant-face      ((t (:weight unspecified)))))
      (custom-set-faces '(font-lock-type-face          ((t (:weight unspecified)))))
      (custom-set-faces '(font-lock-keyword-face       ((t (:weight unspecified))))))

    (when (or (niva/theme-is-active "wombat") (niva/theme-is-active "naysayer"))
      (custom-set-faces '(org-block            ((t (:background "#182C32"))))
                        '(org-block-begin-line ((t (:inherit 'default :extend t :overline t :underline nil :background "#182C32"))))
                        '(org-block-end-line   ((t (:inherit 'default :extend t :overline nil :underline t :background "#182C32"))))))

    (when (or (niva/theme-is-active "nano"))
      (custom-set-faces '(mode-line-inactive         ((t (:inherit mode-line))))
                        '(mode-line-active           ((t (:inherit mode-line))))
                        '(compilation-mode-line-exit ((t (:inherit unspecified))))
                        '(compilation-mode-line-run  ((t (:inherit unspecified))))
                        '(font-lock-string-face      ((t (:inherit nano-subtle :slant unspecified))))
                        '(org-block-begin-line       ((t (:inherit 'org-block :extend t :overline t   :underline nil))))
                        '(org-block-end-line         ((t (:inherit 'org-block :extend t :overline nil :underline t))))))

    (when (niva/theme-is-active "south")
      (custom-set-faces
       ;; '(elfeed-search-feed-face         ((t (:inherit 'fixed-pitch :bold nil :foreground unspecified))))
       ;; '(elfeed-search-date-face         ((t (:inherit 'fixed-pitch))))
       '(org-block                   ((t (:background nil))))
       '(org-block-begin-line        ((t (:background nil :inherit 'org-block :extend t :overline t   :underline nil))))
       '(org-block-end-line          ((t (:background nil :inherit 'org-block :extend t :overline nil :underline t))))))

    ;; (when (niva/theme-is-active "orangey-bits")
    ;;   (set-face-foreground 'default "#FFB240"))

    ;; (when (niva/theme-is-active "vegetative")
    ;;   (set-face-foreground 'default "#58B22C"))

    (custom-set-faces '(help-key-binding nil :box nil :background 'unspecified :foreground (face-attribute 'default :foreground)))
    (custom-set-faces '(elfeed-search-unread-title-face ((t :inherit 'default :underline nil :bold nil :foreground unspecified)))
                      '(elfeed-search-title-face        ((t (:inherit 'shadow :underline nil :foreground unspecified))))
                      '(elfeed-search-feed-face         ((t (:inherit 'default :underline nil :foreground unspecified))))
                      '(elfeed-search-tag-face          ((t (:inherit 'shadow :underline nil :foreground unspecified))))
                      '(elfeed-search-date-face         ((t (:inherit 'org-agenda-date :underline nil :foreground unspecified)))))
    (niva/diff-hl-fix)))

(use-package nano-theme
  :straight t
  :defer t
  :config
  (setq nano-fonts-use nil
        nano-window-divider-show t))

(custom-set-faces '(font-lock-comment-delimiter-face ((t (:inherit font-lock-comment-face)))))

(with-eval-after-load 'eglot
  (custom-set-faces
   `(eglot-inlay-hint-face
     ((t :inherit 'default
         ;; :font "Arial"
         :height 0.8
         :italic nil
         :inherit 'org-block-begin-line)))
   '(eglot-highlight-symbol-face
     ((t :underline nil
         :bold t)))))

(with-eval-after-load 'dired
  (custom-set-faces '(dired-directory ((t (:inherit link :underline nil))))))

;;; theme-packages.el ends here
