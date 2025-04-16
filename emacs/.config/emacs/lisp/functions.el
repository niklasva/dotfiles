(defun niva/copy-file-path-to-kill-ring ()
  "Add the current buffer's file path to the kill ring."
  (interactive)
  (if-let ((filename (buffer-file-name)))
      (progn
        (kill-new filename)
        (message "Copied file path: %s" filename))
    (message "Current buffer is not visiting a file!")))

(defun dk-mac-keyboard-layout-indicator ()
  (interactive)
  (defvar dk-current-layout "")
  (defun dk-fetch-current-layout ()
    (replace-regexp-in-string
     "\n\\'" ""
     (shell-command-to-string
      "defaults read com.apple.HIToolbox AppleSelectedInputSources \
       | grep -i 'KeyboardLayout Name' \
       | sed -E 's/.*\"([^\"]+)\".*/\\1/'")))
  (setq dk-current-layout (dk-fetch-current-layout))
  (if (string-match "U\\.S\\." dk-current-layout)
      (setq dk-current-layout "US"))
  (if (string-match "Swe" dk-current-layout)
      (setq dk-current-layout "SE"))
  (setq global-mode-string dk-current-layout))

;; (dk-mac-keyboard-layout-indicator)
;; (run-with-idle-timer 60 t 'dk-mac-keyboard-layout-indicator)
