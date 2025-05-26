;;; bing-bong-light-theme.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;; Defines the `bing-bong-light` theme and a toggle function.

;;; Code:

(deftheme bing-bong-light "Bing Bong Light.")

(custom-theme-set-faces
 'bing-bong-light
 '(shr-link                              ((t (:inherit unspecified :foreground "red"))))
 '(font-lock-bracket-face                ((t (:foreground unspecified))))
 '(font-lock-builtin-face                ((t (:inherit font-lock-function-call-face))))
 '(font-lock-comment-delimiter-face      ((t (:inherit font-lock-comment-face))))
 '(font-lock-constant-face               ((t (:foreground "gray40" :inherit unspecified))))
 '(font-lock-escape-face                 ((t (:inherit font-lock-builtin-face))))
 '(font-lock-function-call-face          ((t (:foreground unspecified))))
 '(font-lock-function-name-face          ((t (:foreground unspecified))))
 '(font-lock-operator-face               ((t (:foreground unspecified))))
 '(font-lock-regexp-grouping-backslash   ((t (:inherit unspecified))))
 '(font-lock-type-face                   ((t (:inherit unspecified :foreground "gray25"))))
 '(font-lock-variable-name-face          ((t (:foreground unspecified))))
 '(font-lock-variable-use-face           ((t (:foreground unspecified))))
 '(org-block                             ((t (:inherit default))))
 '(vertico-mouse                         ((t (:inherit highlight))))
 '(eglot-inlay-hint-face                 ((t (:inherit font-lock-comment-face :height 1.0 :italic t))))
 '(eglot-highlight-symbol-face           ((t (:inherit unspecified :underline (:style wave)))))
 '(eglot-diagnostic-tag-unnecessary-face ((t (:strike-through t)))))

;;; Toggle function for Bing-Bong Light
(defun niva/toggle-bing-bong-light ()
  "Toggle the `bing-bong-light' theme."
  (interactive)
  (if (member 'bing-bong-light custom-enabled-themes)
      (disable-theme 'bing-bong-light)
    (load-theme 'bing-bong-light t)))

(provide 'bing-bong-light-theme)
;;; bing-bong-light-theme.el ends here
