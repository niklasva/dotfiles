;;; ansi-default-dark-theme.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;; Defines the `ansi-default-dark' theme.

;;; Code:

(deftheme ansi-default-dark "ANSI Default Dark.")

(custom-theme-set-faces
 'ansi-default-dark
 '(ansi-color-black ((t (:foreground "#181818"))))
 '(ansi-color-red ((t (:foreground "#ab4642"))))
 '(ansi-color-green ((t (:foreground "#a1b56c"))))
 '(ansi-color-yellow ((t (:foreground "#f7ca88"))))
 '(ansi-color-blue ((t (:foreground "#7cafc2"))))
 '(ansi-color-magenta ((t (:foreground "#ba8baf"))))
 '(ansi-color-cyan ((t (:foreground "#86c1b9"))))
 '(ansi-color-white ((t (:foreground "#d8d8d8"))))
 '(ansi-color-bright-black ((t (:foreground "#585858"))))
 '(ansi-color-bright-red ((t (:foreground "#dc9656"))))
 '(ansi-color-bright-green ((t (:foreground "#a1b56c"))))
 '(ansi-color-bright-yellow ((t (:foreground "#f7ca88"))))
 '(ansi-color-bright-blue ((t (:foreground "#7cafc2"))))
 '(ansi-color-bright-magenta ((t (:foreground "#ba8baf"))))
 '(ansi-color-bright-cyan ((t (:foreground "#86c1b9"))))
 '(ansi-color-bright-white ((t (:foreground "#f8f8f8")))))

(provide-theme 'ansi-default-dark)
(provide 'ansi-default-dark-theme)
;;; ansi-default-dark-theme.el ends here
