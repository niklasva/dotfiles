;; Custom mode line with rss, git, irc statuses

(defun is-vc-file ()
  (let ((backend (vc-backend (buffer-file-name))))
    (if backend
        t
      nil)))

(defun niva/git-state-symbol ()
  (pcase (vc-git-state (buffer-file-name))
    ('ignored ".")
    ('unregistered ".")
    ('removed "-")
    ('edited "*")
    ('added "+")
    ('conflict "‼")
    (_ "")))

(defvar-local niva--git-mode-line "")
(make-variable-buffer-local 'niva--git-mode-line)
(defun niva/update-git-branch-name ()
  (interactive)
  (if vc-mode
      (setq niva--git-mode-line (format " |  %s" (substring vc-mode 5)))
    (setq niva--git-mode-line "")))

;; (setq my-git-branch-name-timer (run-with-timer 0 5 'niva/update-git-branch-name))

(defun niva/git-repository-name ()
  (let ((repository-name (vc-git-repository-url buffer-file-name)))
    (s-replace ".git" "" (s-replace "git@github.com:" "" repository-name))))

(defun niva/bottom-right-window-p ()
  (let* ((frame (selected-frame))
         (frame-width (frame-width frame))
         (frame-height (frame-height frame)))
    (eq (selected-window)
        (window-at (- frame-width 3) (- frame-height 3)))))

(defun niva/format-right-mode-line ()
  (propertize
   (format "%s %s %s %s "
           niva--irc-notification
           (if (= niva-elfeed-unread-count 0) ""
             (format "  %-2d" niva-elfeed-unread-count))
           (format-time-string "%R") " ")
   'face 'font-lock-string-face))

(setq-default mode-line-format
              `((:eval (if (and buffer-file-name (buffer-modified-p)) "*%b" " %b"))
                (:eval (if vc-mode niva--git-mode-line))
                " | %l:%c"
                (:eval (propertize " " 'display (list 'space :align-to (- (window-total-width) (length (niva/format-right-mode-line))))))
                (:eval (if (niva/bottom-right-window-p) (niva/format-right-mode-line)))))
