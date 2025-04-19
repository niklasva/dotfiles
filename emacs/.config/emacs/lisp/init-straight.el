;; -*- lexical-binding: t; -*-
(setq-default straight-base-dir "~/.cache/emacs/straight")
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(use-package org :straight t)

(use-package no-littering
  :straight t
  :init
  (setq no-littering-etc-directory "~/.cache/emacs/etc")
  (setq no-littering-var-directory "~/.cache/emacs/var"))

(use-package diminish :straight t)
