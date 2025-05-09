;;; bing-bong-dark-theme.el --- My custom Bing-Bong dark theme
;;; Commentary:
;; Defines the `bing-bong-dark` theme and a toggle function.

;;; Code:

(deftheme bing-bong-dark "Bing Bong Dark.")

(custom-theme-set-faces
 'bing-bong-dark
 '(shr-link                              ((t (:inherit unspecified :foreground "red"))))
 '(font-lock-bracket-face                ((t (:foreground unspecified))))
 '(font-lock-builtin-face                ((t (:inherit font-lock-function-call-face))))
 '(font-lock-comment-delimiter-face      ((t (:inherit font-lock-comment-face))))
 '(font-lock-constant-face               ((t (:foreground "gray75" :inherit unspecified))))
 '(font-lock-escape-face                 ((t (:inherit font-lock-builtin-face))))
 '(font-lock-function-call-face          ((t (:foreground unspecified))))
 '(font-lock-function-name-face          ((t (:foreground unspecified))))
 '(font-lock-operator-face               ((t (:foreground unspecified))))
 '(font-lock-regexp-grouping-backslash   ((t (:inherit unspecified))))
 '(font-lock-type-face                   ((t (:inherit unspecified :foreground "gray75"))))
 '(font-lock-variable-name-face          ((t (:foreground unspecified))))
 '(font-lock-variable-use-face           ((t (:foreground unspecified))))
 '(org-block                             ((t (:inherit default))))
 '(vertico-mouse                         ((t (:inherit highlight))))
 '(eglot-inlay-hint-face                 ((t (:inherit font-lock-comment-face :height 1.0 :italic t))))
 '(eglot-highlight-symbol-face           ((t (:inherit unspecified :underline (:style wave)))))
 '(eglot-diagnostic-tag-unnecessary-face ((t (:strike-through t))))
 '(dired-directory                       ((t (:inherit link)))))

;;; Toggle function for Bing-Bong Dark
(defun niva/toggle-bing-bong-dark ()
  "Toggle the `bing-bong-dark' theme."
  (interactive)
  (if (member 'bing-bong-dark custom-enabled-themes)
      (disable-theme 'bing-bong-dark)
    (load-theme 'bing-bong-dark t)))

(provide 'bing-bong-dark-theme)
;;; bing-bong-dark-theme.el ends here
