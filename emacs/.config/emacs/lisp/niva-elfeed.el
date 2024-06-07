;;; niva-elfeed.el --- Extensions to elfeed -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(defun niva/fixed-length (input-string length)
  "Ensure that INPUT-STRING is exactly LENGTH characters long, padding with spaces if necessary."
  (let ((len (length input-string)))
    (if (>= len length)
        (substring input-string 0 length)
      (concat input-string (make-string (- length len) ? )))))

(defun elfeed-search--faces-1 (tags)
  "Return all the faces that apply to an entry with TAGS."
  (nconc (cl-loop for (tag . faces) in elfeed-search-face-alist-1
                  when (memq tag tags)
                  append faces)
         (list 'elfeed-search-title-face)))

(setq elfeed-search-face-alist-1
      '((unread elfeed-search-unread-title-face)))

(defun elfeed-search--faces-2 (tags)
  "Return all the faces that apply to an entry with TAGS."
  (nconc (cl-loop for (tag . faces) in elfeed-search-face-alist-2
                  when (memq tag tags)
                  append faces)
         (list 'elfeed-search-title-face)))

(setq elfeed-search-face-alist-2
      '((unread elfeed-search-feed-face)))

(defun elfeed-search--faces-3 (tags)
  "Return all the faces that apply to an entry with TAGS."
  (nconc (cl-loop for (tag . faces) in elfeed-search-face-alist-3
                  when (memq tag tags)
                  append faces)
         (list 'elfeed-search-title-face)))

(setq elfeed-search-face-alist-3
      '((unread elfeed-search-tag-face)))

(defun elfeed-search--faces-4 (tags)
  "Return all the faces that apply to an entry with TAGS."
  (nconc (cl-loop for (tag . faces) in elfeed-search-face-alist-4
                  when (memq tag tags)
                  append faces)
         (list 'elfeed-search-title-face)))

(setq elfeed-search-face-alist-4
      '((unread elfeed-search-date-face)))

(setq widest-feed-title 0)
(defun niva/elfeed-search-print-entry (entry)
  (let* ((feed (elfeed-entry-feed entry))
         (feed-title (when feed (or (elfeed-meta feed :title) (elfeed-feed-title feed))))
         (star (if (member "star" (mapcar #'symbol-name (elfeed-entry-tags entry))) "s" " "))
         (tags (delete "unread" (delete "star" (mapcar #'symbol-name (elfeed-entry-tags entry)))))
         (tags-str "%-12s ")
         (date (format "%-12s " (relative-date  (elfeed-entry-date entry))))
         (title (or (elfeed-meta entry :title) (elfeed-entry-title entry) ""))
         (title-faces      (elfeed-search--faces-1 (elfeed-entry-tags entry)))
         (feed-title-faces (elfeed-search--faces-2 (elfeed-entry-tags entry)))
         (feed-tag-faces   (elfeed-search--faces-3 (elfeed-entry-tags entry)))
         (feed-date-faces  (elfeed-search--faces-4 (elfeed-entry-tags entry)))
         (formatted-date (propertize (format "%s" date) 'face feed-date-faces))
         (formatted-tags (propertize (format tags-str (mapconcat 'identity tags " ")) 'face feed-tag-faces))
         (formatted-feed-title (propertize feed-title 'face feed-title-faces))
         (title-width-wide (- (window-width) (string-width formatted-date) (string-width formatted-tags) 25))
         (title-width (- (window-width) (string-width formatted-date)))
         (formatted-title-wide (propertize (elfeed-format-column title title-width-wide :left) 'face title-faces))
         (formatted-title (propertize (elfeed-format-column title title-width :left) 'face title-faces))
         (end-of-window (format (format "%%%ds" (- (window-width) (string-width formatted-feed-title) (string-width formatted-tags))) "")))

    (if (< widest-feed-title (string-width formatted-feed-title))
        (setq widest-feed-title (string-width formatted-feed-title)))
    (setq feed-padding (format "%%-%ds " widest-feed-title))

    (if (> (window-width) 100)
        (mapc #'insert (list
                        formatted-date
                        (niva/fixed-length formatted-feed-title 25)
                        formatted-tags
                        formatted-title-wide
                        " "
                        ))
      (mapc #'insert (list
                      formatted-date
                      formatted-feed-title
                      end-of-window
                      formatted-tags
                      formatted-title
                      " "
                      )))))


(setq elfeed-search-print-entry-function #'niva/elfeed-search-print-entry)

(with-eval-after-load 'elfeed
  (when (eq niva/theme 'default)
    (set-face-attribute 'elfeed-search-date-face         nil :foreground nil :bold nil :inherit 'org-agenda-date)
    (set-face-attribute 'elfeed-search-feed-face         nil :foreground nil :bold nil :inherit 'gnus-header-from)
    (set-face-attribute 'elfeed-search-tag-face          nil :foreground nil :bold nil :inherit 'gnus-header-newsgroups)
    (set-face-attribute 'elfeed-search-title-face        nil :foreground nil :bold nil :inherit 'shadow)
    (set-face-attribute 'elfeed-search-unread-title-face nil :foreground nil :bold nil :inherit 'gnus-header-subject)))

(provide 'niva-elfeed)
;;; niva-elfeed.el ends here
