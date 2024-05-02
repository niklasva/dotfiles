(defun niva/replace-tuples-in-string (str pairs &optional reverse)
  (mapc (lambda (pair)
          (setq str (replace-regexp-in-string
                     (if reverse
                         (regexp-quote (cadr pair))
                       (regexp-quote (car pair)))
                     (if reverse
                         (car pair)
                       (cadr pair))
                     str)))
        pairs)
  str)


(setq-default niva/pairs-to-obfuscate '(("a" "b") ("c" "d")))

(defun niva/obfuscate-region (begin end)
  (interactive "r")
  (let ((str (buffer-substring-no-properties begin end)))
    (setq str (niva/replace-tuples-in-string str niva/pairs-to-obfuscate nil))
    (save-excursion
      (goto-char end)
      (insert (concat "\nObfuscated:\n" str)))))


(defun niva/deobfuscate-region (begin end)
  (interactive "r")
  (let ((str (buffer-substring-no-properties begin end)))
    (setq str (niva/replace-tuples-in-string str niva/pairs-to-obfuscate t))
    (save-excursion
      (goto-char end)
      (insert (concat "\nDeobfuscated:\n" str)))))

(provide 'obfuscate)
