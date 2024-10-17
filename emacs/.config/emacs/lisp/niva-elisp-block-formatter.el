(defun niva/format-all-elisp-code-blocks ()
  "Format all elisp blocks in current buffer"
  (interactive)
  (setq-local indent-tabs-mode nil)
  (save-excursion
    (let ((message-log-max nil)
          (inhibit-message t)
          (inhibit-redisplay t))

      (org-element-map (org-element-parse-buffer) 'src-block
        (lambda (src-block)
          (when (string= "emacs-lisp" (org-element-property :language src-block))
            (let* ((begin (org-element-property :begin src-block))
                   (end (org-element-property :end src-block)))
              (indent-region begin end nil)
              (untabify begin end)
              (replace-regexp-in-region "\n\n*#\\+end_src" "\n#+end_src" begin end)
              (replace-regexp-in-region "#\\+begin_src emacs-lisp\n\n*" "#+begin_src emacs-lisp\n" begin end)
              (replace-regexp-in-region "\n *#\\+end_src"   "\n#+end_src" begin end)
              (replace-regexp-in-region "\n *#\\+begin_src" "\n#+begin_src" begin end)))))))
  (font-lock-fontify-block))

(provide 'niva-elisp-block-formatter)
