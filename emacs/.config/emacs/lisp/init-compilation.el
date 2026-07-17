;;; init-compilation.el --- Compilation setup -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(setq compilation-scroll-output 'next-error
      process-adaptive-read-buffering nil)

(setq display-buffer-alist
      '(("\\*compilation\\*" . (display-buffer-reuse-window))))

(use-package xterm-color
  :ensure t
  :config
  (defun from-face (face)
    (face-attribute face :foreground))
  (setq xterm-color-names
        `[,(from-face 'default)
          ,(from-face 'ansi-color-red)
          ,(from-face 'ansi-color-green)
          ,(from-face 'ansi-color-yellow)
          ,(from-face 'ansi-color-blue)
          ,(from-face 'ansi-color-magenta)
          ,(from-face 'ansi-color-cyan)
          ,(from-face 'ansi-color-white)
          ]))

(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)
(require 'rx)

(defconst niva/compilation-xml-regexp
  (rx line-start (* (any "\t "))
      "<"
      (or (seq "?xml")
          (seq (? "/")
               (or "testsuites" "testsuite" "testcase" "failure" "failures"
                   "errors" "error" "skipped"))))
  "Regexp matching gtest XML output in compilation buffers.")

(defconst niva/compilation-info-regexp
  (rx line-start (* (any digit ":" "." space)) "[" "INFO" "]")
  "Regexp matching INFO log lines in compilation buffers.")

(defun niva/compilation--hide-line (label)
  (let* ((bol (line-beginning-position))
         (eol (min (1+ (line-end-position)) (point-max)))
         (tooltip (concat label " (niva)")))
    (add-text-properties bol eol `(invisible niva-compilation-hidden
                                             font-lock-face shadow
                                             help-echo ,tooltip
                                             niva-compilation-hidden t))))

(defun niva/compilation--apply-region (start end)
  (when (< start end)
    (save-excursion
      (goto-char start)
      (while (re-search-forward niva/compilation-xml-regexp end t)
        (niva/compilation--hide-line "Hidden XML"))
      (goto-char start)
      (while (re-search-forward niva/compilation-info-regexp end t)
        (niva/compilation--hide-line "Hidden INFO log")))))

(defun niva/compilation-hide-noise ()
  "Hide XML/INFO noise in compilation buffers according to preference."
  (when (and (derived-mode-p 'compilation-mode)
             (boundp 'compilation-filter-start))
    (let ((start (max (point-min) compilation-filter-start))
          (end (point))
          (inhibit-read-only t))
      (if niva/compilation-hide-info
          (progn
            (add-to-invisibility-spec 'niva-compilation-hidden)
            (niva/compilation--apply-region start end))
        (remove-from-invisibility-spec 'niva-compilation-hidden)
        (remove-text-properties start end
                                '(invisible nil
                                            niva-compilation-hidden nil
                                            font-lock-face nil
                                            help-echo nil))))))

(defun niva/compilation--apply-hide-info (buffer)
  (with-current-buffer buffer
    (when (derived-mode-p 'compilation-mode)
      (let ((inhibit-read-only t))
        (if niva/compilation-hide-info
            (progn
              (add-to-invisibility-spec 'niva-compilation-hidden)
              (niva/compilation--apply-region (point-min) (point-max)))
          (remove-from-invisibility-spec 'niva-compilation-hidden)
          (remove-text-properties (point-min) (point-max)
                                  '(invisible nil
                                              niva-compilation-hidden nil
                                              font-lock-face nil
                                              help-echo nil)))))))

(defun niva/compilation-mode-setup ()
  (niva/compilation--apply-hide-info (current-buffer)))

(defun niva/compilation--set-hide-info (symbol value)
  (set-default symbol value)
  (dolist (buffer (buffer-list))
    (niva/compilation--apply-hide-info buffer)))

(defcustom niva/compilation-hide-info t
  "When non-nil, hide XML and INFO lines in compilation buffers."
  :type 'boolean
  :group 'compile
  :set #'niva/compilation--set-hide-info)

;; (add-hook 'compilation-filter-hook #'niva/compilation-hide-noise)
;; (add-hook 'compilation-mode-hook #'niva/compilation-mode-setup)

(defun niva/advice-compilation-filter (f proc string)
  (funcall f proc (xterm-color-filter string)))

(use-package compile
  :ensure nil
  :config
  (setq compilation-error-regexp-alist (delete 'gnu compilation-error-regexp-alist))

  (add-to-list 'compilation-error-regexp-alist-alist
               '(niva--compile-warning
                 "\\[Warning\\] \\(.*?\\):\\([0-9]+\\)"
                 1 2 3
                 0 1))

  (add-to-list 'compilation-error-regexp-alist-alist
               '(niva--compile-error
                 "\\[Error\\] \\(.*?\\):\\([0-9]+\\):?\\([0-9]+\\)?"
                 1 2 3
                 1 1))

  (add-to-list 'compilation-error-regexp-alist-alist
               '(niva--compile-mbed-error
                 "\\[mbed\\] ERROR: \"\\(.*?\\)\""
                 1 nil nil
                 1 1))

  (add-to-list 'compilation-error-regexp-alist-alist
               '(niva--compile-include
                 "^\\(?:In file included \\|                 \\|\t\\)from \ \\([0-9]*[^0-9\n]\\(?:[^\n :]\\| [^-/\n]\\|:[^ \n]\\)*?\\):\ \\([0-9]+\\)\\(?::\\([0-9]+\\)\\)?\\(?:\\([:,]\\|$\\)\\)?"
                 1 2 3
                 (0 . 0) 1))

  (add-to-list 'compilation-error-regexp-alist-alist
               '(niva--compile-include2
                 "\\[ERROR\\] In file included from \\(.*?\\):\\([0-9]+\\),"
                 1 2 nil
                 1 1))

  (add-to-list 'compilation-error-regexp-alist-alist
               '(niva--compile-gcc-warning
                 "^\\(\\.\\/.*?\\|\\/.*?\\):\\([0-9]+\\)?:?\\([0-9]+\\)?: warning:"
                 1 2 3
                 1 1))

  (add-to-list 'compilation-error-regexp-alist-alist
               '(niva--compile-gcc-required
                 "^\\(\\.\\/.*?\\|\\/.*?\\):\\([0-9]+\\)?:?\\([0-9]+\\)?: +required"
                 1 2 3
                 1 1))


  (add-to-list 'compilation-error-regexp-alist-alist
               '(niva--compile-gcc-note
                 "^\\(\\.\\/.*?\\|\\/.*?\\):\\([0-9]+\\)?:?\\([0-9]+\\)?: note:" 1 2 3
                 0 1))

  (add-to-list 'compilation-error-regexp-alist-alist
               '(niva--compile-gcc-error
                 "^\\(\\.\\/.*?\\|\\/.*?\\):\\([0-9]+\\)?:?\\([0-9]+\\)?: error:"
                 1 2 3
                 nil 1))

  (add-to-list 'compilation-mode-font-lock-keywords
               '("^\\[\\s-*PASSED\\s-*\\].*$" 0 'compilation-info))
  (add-to-list 'compilation-mode-font-lock-keywords
               '("^\\[\\s-*FAILED\\s-*\\].*$" 0 'compilation-error))

  (add-to-list 'compilation-error-regexp-alist-alist
               '(niva--compile-gtest-failure
                 "^\\(.+\\):\\([0-9]+\\): Failure"
                 1 2 nil
                 2 1))

  (add-to-list 'compilation-mode-font-lock-keywords
               '("\\ \\ \\ \\ \\ \\ \\ OK\\ " 0 'compilation-info))

  (add-to-list 'compilation-error-regexp-alist-alist
               '(niva--compile-gtest-summary
                 "^[\\t ]+\\(\\(?:\\./\\|\\.\\./\\|~/\\|/\\)[^:[:space:]]*\\):\\([0-9]+\\)\\(?:[: ]\\|$\\)"
                 1 2 nil
                 2 1))


  (setq compilation-error-regexp-alist nil)
  (add-to-list 'compilation-error-regexp-alist 'niva--compile-warning)
  (add-to-list 'compilation-error-regexp-alist 'niva--compile-error)
  (add-to-list 'compilation-error-regexp-alist 'niva--compile-mbed-error)
  (add-to-list 'compilation-error-regexp-alist 'niva--compile-gtest-failure)
  (add-to-list 'compilation-error-regexp-alist 'niva--compile-gtest-summary)
  (add-to-list 'compilation-error-regexp-alist 'niva--compile-include)
  (add-to-list 'compilation-error-regexp-alist 'niva--compile-include2)
  (add-to-list 'compilation-error-regexp-alist 'niva--compile-gcc-required)
  (add-to-list 'compilation-error-regexp-alist 'niva--compile-gcc-warning)
  (add-to-list 'compilation-error-regexp-alist 'niva--compile-gcc-note)
  (add-to-list 'compilation-error-regexp-alist 'niva--compile-gcc-error)

  (advice-add 'compilation-filter :around #'niva/advice-compilation-filter))

(provide 'init-compilation)
;;; init-compilation.el ends here
