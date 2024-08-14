;;; niva-elfeed.el --- Extensions to elfeed -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(defun niva/fixed-length (input-string length)
  (let ((len (length input-string)))
    (if (>= len length)
        (substring input-string 0 length)
      (concat input-string (make-string (- length len) ? )))))

(defun elfeed-search--faces-1 (tags)
  (nconc (cl-loop for (tag . faces) in elfeed-search-face-alist-1
                  when (memq tag tags)
                  append faces)
         (list 'elfeed-search-title-face)))


(defun elfeed-search--faces-2 (tags)
  (nconc (cl-loop for (tag . faces) in elfeed-search-face-alist-2
                  when (memq tag tags)
                  append faces)
         (list 'elfeed-search-title-face)))


(defun elfeed-search--faces-3 (tags)
  (nconc (cl-loop for (tag . faces) in elfeed-search-face-alist-3
                  when (memq tag tags)
                  append faces)
         (list 'elfeed-search-title-face)))

(defun elfeed-search--faces-4 (tags)
  (nconc (cl-loop for (tag . faces) in elfeed-search-face-alist-4
                  when (memq tag tags)
                  append faces)
         (list 'elfeed-search-title-face)))

(setq elfeed-search-face-alist-1 '((unread elfeed-search-unread-title-face))
      elfeed-search-face-alist-2 '((unread elfeed-search-feed-face))
      elfeed-search-face-alist-3 '((unread elfeed-search-tag-face))
      elfeed-search-face-alist-4 '((unread elfeed-search-date-face)))

(defun niva/elfeed-search-print-entry (entry)
  (let* ((feed (elfeed-entry-feed entry))
         (feed-title (or (elfeed-meta feed :title)
                         (elfeed-feed-title feed)
                         ""))
         (tags (mapcar #'symbol-name (elfeed-entry-tags entry)))
         (star (if (member "star" tags) "s" " "))
         (tags (delete "star" (delete "unread" tags)))
         (date (format "%-12s " (relative-date (elfeed-entry-date entry))))
         (title (or (elfeed-meta entry :title)
                    (elfeed-entry-title entry)
                    ""))
         (formatted-date (propertize date 'face (elfeed-search--faces-4 (elfeed-entry-tags entry))))
         (formatted-tags (propertize (mapconcat 'identity tags " ") 'face (elfeed-search--faces-3 (elfeed-entry-tags entry))))
         (formatted-feed-title (propertize feed-title 'face (elfeed-search--faces-2 (elfeed-entry-tags entry))))
         (title-width-wide (- (window-width) (string-width formatted-date) (string-width formatted-tags) 25))
         (title-width (- (window-width) (string-width formatted-date)))
         (formatted-title-wide (propertize (elfeed-format-column title title-width-wide :left) 'face (elfeed-search--faces-1 (elfeed-entry-tags entry))))
         (formatted-title (propertize (elfeed-format-column title (- (window-width) 20) :left) 'face (elfeed-search--faces-1 (elfeed-entry-tags entry))))
         (end-of-window (format (format "%%%ds"
                                        (- (window-width)
                                           (string-width formatted-feed-title)
                                           (string-width formatted-tags)
                                           (string-width formatted-date)))
                                "")))

    (dolist (elem (list formatted-date
                      formatted-feed-title
                      end-of-window
                      formatted-tags
                        (propertize "             " 'face '(:underline (:color "#4c4e4e")))
                        (propertize formatted-title 'face (list :inherit (elfeed-search--faces-1 (elfeed-entry-tags entry)) :underline '(:color "#4c4e4e")))
                        (propertize "       " 'face '(:underline (:color "#4c4e4e")))))
      (insert elem)
      )))


(setq elfeed-search-print-entry-function #'niva/elfeed-search-print-entry)

(with-eval-after-load 'elfeed
  (when (or (eq niva/theme 'default) (eq niva/theme 'naysayer))
    (set-face-attribute 'elfeed-search-date-face         nil :foreground nil :bold nil :foreground (face-attribute 'org-agenda-date :foreground))
    (set-face-attribute 'elfeed-search-feed-face         nil :foreground nil :bold nil :foreground (face-attribute 'gnus-header-from :foreground))
    (set-face-attribute 'elfeed-search-tag-face          nil :foreground nil :bold nil :foreground (face-attribute 'gnus-header-newsgroups :foreground))
    (set-face-attribute 'elfeed-search-title-face        nil :foreground nil :bold nil :inherit 'shadow)
    (set-face-attribute 'elfeed-search-unread-title-face nil :foreground nil :bold nil :foreground (face-attribute 'gnus-header-subject :foreground))))

(provide 'niva-elfeed)
;;; niva-elfeed.el ends here
