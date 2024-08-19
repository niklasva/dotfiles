;;; niva-guards.el --- A simple package for inserting guard macros  -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(defvar niva--insert-guards-base-path nil)
(defun niva-guards ()
  "Insert guard macros based on the current buffer file name."
  (interactive)
  (let ((guard (upcase (replace-regexp-in-string "[/|.]" "_"
                                                 (file-relative-name (buffer-file-name) niva--insert-guards-base-path)))))
    (insert (format "#ifndef %s__\n#define %s__\n" guard guard))))

(provide 'niva-guards)
;;; niva-guards.el ends here
