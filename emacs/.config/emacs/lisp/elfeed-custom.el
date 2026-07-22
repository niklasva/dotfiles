;;; elfeed-custom.el --- Extensions to elfeed -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(defun niva/elfeed-search-print-entry--single-line (entry)
  (let* ((date (format "%-12s " (relative-date (elfeed-entry-date entry))))
         (title (or (elfeed-meta entry :title) (elfeed-entry-title entry) ""))
         (title-faces (elfeed-search--faces (elfeed-entry-tags entry)))
         (feed (elfeed-entry-feed entry))
         (feed-title
          (when feed
            (or (elfeed-meta feed :title) (elfeed-feed-title feed))))
         (tags (mapcar #'symbol-name (elfeed-entry-tags entry)))
         (tags (delete "star" (delete "unread" tags)))
         (tags-str (mapconcat
                    (lambda (s) (propertize s 'face 'elfeed-search-tag-face))
                    tags ","))
         (title-width (- (window-width) 20 elfeed-search-trailing-width))
         (title-column (elfeed-format-column
                        title (elfeed-clamp
                               elfeed-search-title-min-width
                               title-width
                               elfeed-search-title-max-width)
                        :left))
         (read-p (not (memq 'unread (elfeed-entry-tags entry))))
         (beg (point)))
    (insert (propertize date 'face 'elfeed-search-date-face) " "
            (propertize title-column 'face title-faces 'kbd-help title) " "
            (format "%-30s" (format "%s (%s)" (propertize feed-title 'face 'elfeed-search-feed-face) tags-str)))
    (when read-p
      (add-face-text-property beg (point)
                              (list :foreground (or (face-foreground 'shadow nil t) "gray55"))
                              nil))))

(setq elfeed-search-print-entry-function #'niva/elfeed-search-print-entry--single-line)

(with-eval-after-load 'elfeed

  (defun niva/elfeed-switch (buff)
    (with-current-buffer buff
      (setq-local evil-respect-visual-line-mode nil)
      (setq-local visual-fill-column-center-text nil
                  visual-fill-column-fringes-outside-margins t
                  visual-fill-column-extra-text-width '(-4 . 0)
                  visual-fill-column-width 90
                  visual-fill-column-center-text nil)
      (visual-line-mode 1)
      (visual-fill-column-mode 1))
    (switch-to-buffer buff))

  (setq elfeed-show-entry-switch 'niva/elfeed-switch)
  (setq elfeed-search-remain-on-entry t)

  (add-hook 'elfeed-search-update-hook (lambda () (setq word-wrap nil))))

(defun niva/elfeed-toggle-images ()
  (interactive)
  (setq shr-inhibit-images (not shr-inhibit-images))
  (elfeed-show-refresh))

(defun niva/elfeed--move-paragraph-up ()
  (interactive)
  (if (derived-mode-p 'elfeed-show-mode)
      (condition-case nil
          (progn
            (evil-backward-paragraph 2)
            (forward-line 1)
            (evil-scroll-line-to-center nil)))))

(defun niva/elfeed--move-paragraph-down ()
  (interactive)
  (if (derived-mode-p 'elfeed-show-mode)
      (condition-case nil
          (progn
            (evil-forward-paragraph)
            (evil-scroll-line-to-center nil)
            (forward-line 1)))))


(provide 'elfeed-custom)

(defun niva/clear-elfeed ()
  "Clear elfeed database"
  (interactive)
  (setq elfeed-db-directory (expand-file-name "~/.elfeed"))
  (delete-directory elfeed-db-directory t)
  (message "Elfeed database cleared. Restart Elfeed to initialize a new database."))
(niva/clear-elfeed)

;; SINCE ELFEED 4.0.0
(setq elfeed-search-sort-function #'elfeed-search-group-by-feed)

;;; elfeed-custom.el ends here
