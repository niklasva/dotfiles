;;; ansi-default-light-theme.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;; Defines the `ansi-default-light' theme.

;;; Code:

(deftheme ansi-default-light "ANSI Default Light.")

(custom-theme-set-faces
 'ansi-default-light
 '(ansi-color-black ((t (:foreground "#fcfcfc"))))
 '(ansi-color-red ((t (:foreground "#a80000"))))
 '(ansi-color-green ((t (:foreground "#00a800"))))
 '(ansi-color-yellow ((t (:foreground "#a85400"))))
 '(ansi-color-blue ((t (:foreground "#0000a8"))))
 '(ansi-color-magenta ((t (:foreground "#a800a8"))))
 '(ansi-color-cyan ((t (:foreground "#00a8a8"))))
 '(ansi-color-white ((t (:foreground "#545454"))))
 '(ansi-color-bright-black ((t (:foreground "#a8a8a8"))))
 '(ansi-color-bright-red ((t (:foreground "#a80000"))))
 '(ansi-color-bright-green ((t (:foreground "#54fc54"))))
 '(ansi-color-bright-yellow ((t (:foreground "#fcfc54"))))
 '(ansi-color-bright-blue ((t (:foreground "#0000a8"))))
 '(ansi-color-bright-magenta ((t (:foreground "#a800a8"))))
 '(ansi-color-bright-cyan ((t (:foreground "#00a8a8"))))
 '(ansi-color-bright-white ((t (:foreground "#000000")))))

(provide-theme 'ansi-default-light)
(provide 'ansi-default-light-theme)
;;; ansi-default-light-theme.el ends here
