;;; niva-elfeed.el --- Extensions to elfeed -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(defun niva/elfeed-sort-by-tags-and-feed (a b)
  (let* ((a-title (format "%s" (elfeed-entry-feed a)))
         (b-title (format "%s" (elfeed-entry-feed b)))
         (a-tags (format "%s" (elfeed-entry-tags a)))
         (b-tags (format "%s" (elfeed-entry-tags b))))
    (if (and (string= a-tags b-tags) (string= a-title b-title))
        (< (elfeed-entry-date b) (elfeed-entry-date a))
      (if (string= a-tags b-tags)
          (string> a-title b-title)
        (string< a-tags b-tags)))))

(defvar elfeed-search-sort-function nil)

(defvar elfeed-search-face-alist-1 '((unread elfeed-search-unread-title-face)))
(defvar elfeed-search-face-alist-2 '((unread elfeed-search-feed-face)))
(defvar elfeed-search-face-alist-3 '((unread elfeed-search-tag-face)))
(defvar elfeed-search-face-alist-4 '((unread elfeed-search-date-face)))

(defun niva/fixed-length (input-string length)
  (let ((len (length input-string)))
    (if (>= len length)
        (substring input-string 0 length)
      (concat input-string (make-string (- length len) ? )))))

(defun elfeed-search--faces-1 (tags)
  (append
   (mapcan (lambda (entry)
             (when (memq (car entry) tags)
               (cdr entry)))
           elfeed-search-face-alist-1)
   (list 'elfeed-search-title-face)))


(defun elfeed-search--faces-2 (tags)
  (append
   (mapcan (lambda (entry)
             (when (memq (car entry) tags)
               (cdr entry)))
           elfeed-search-face-alist-2)
   (list 'elfeed-search-title-face)))

(defun elfeed-search--faces-3 (tags)
  (append
   (mapcan (lambda (entry)
             (when (memq (car entry) tags)
               (cdr entry)))
           elfeed-search-face-alist-3)
   (list 'elfeed-search-title-face)))

(defun elfeed-search--faces-4 (tags)
  (append
   (mapcan (lambda (entry)
             (when (memq (car entry) tags)
               (cdr entry)))
           elfeed-search-face-alist-4)
   (list 'elfeed-search-title-face)))

(defun niva/elfeed-search-print-entry--multi-line (entry)
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
         (formatted-title (propertize (elfeed-format-column title (- (window-width) 24) :left) 'face (elfeed-search--faces-1 (elfeed-entry-tags entry))))
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
                        (propertize "             " 'face '(:underline nil))
                        (propertize formatted-title 'face (list :inherit (elfeed-search--faces-1 (elfeed-entry-tags entry)) :underline nil))
                        (propertize "       " 'face '(:underline nil))))
      (insert elem))))


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
                        :left)))
    (insert (propertize date 'face 'elfeed-search-date-face) " "
            (propertize title-column 'face title-faces 'kbd-help title) " "
            (format "%-30s" (format "%s (%s)" (propertize feed-title 'face 'elfeed-search-feed-face) tags-str)))))

(defvar-local niva/elfeed-last-feed nil)
(defvar-local niva/elfeed-last-tags nil)

(defun niva/elfeed-search-print-entry--single-line-alt (entry)
  (let* ((date (format "%-13s " (relative-date (elfeed-entry-date entry))))
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
         (title-width (- (window-width) 25 elfeed-search-trailing-width))
         (title-column (elfeed-format-column
                        title (elfeed-clamp
                               elfeed-search-title-min-width
                               title-width
                               elfeed-search-title-max-width)
                        :left)))

    (unless (string= feed-title niva/elfeed-last-feed)
      (insert (propertize "b" 'display `(space :align-to 0 :height 1.8))))
    (setq niva/elfeed-last-feed feed-title)

    (insert (propertize date 'face 'elfeed-search-date-face) " "
            (format "%-20s " (format "%s" (propertize feed-title 'face 'elfeed-search-feed-face) tags-str))
            (propertize title 'face title-faces 'kbd-help title) " "
            (format " (%s) " tags-str))))

;; (defmacro with-overline-inserts (&rest body)
;;   "Run BODY, then add :overline to everything inserted by it."
;;   (declare (indent 0))
;;   `(let ((beg (point)))
;;      (prog1 (progn ,@body)
;;        ;; compose with existing faces rather than clobber
;;        (add-face-text-property beg (point) '(:overline "gray20") 'append))))


(defun niva/elfeed-search-print-entry--single-line-alt-mixed (entry)
  (let* ((date (format "%-12s " (relative-date (elfeed-entry-date entry))))
         (title (or (elfeed-meta entry :title) (elfeed-entry-title entry) ""))
         (feed (elfeed-entry-feed entry))
         (feed-title (when feed (or (elfeed-meta feed :title)
                                    (elfeed-feed-title feed))))
         (tags-raw (mapcar #'symbol-name (elfeed-entry-tags entry)))
         (tags-raw (delete "star" (delete "unread" tags-raw)))
         (tags-key (mapconcat #'identity tags-raw ","))
         (read-p (not (memq 'unread (elfeed-entry-tags entry)))))

    ;; read previous line's keys at its true bol
    (let* ((prev-tags-key (save-excursion
                            (beginning-of-line)
                            (unless (bobp)
                              (forward-line -1)
                              (get-text-property (line-beginning-position)
                                                 'niva/elfeed-tags-key))))
           (prev-feed-key (save-excursion
                            (beginning-of-line)
                            (unless (bobp)
                              (forward-line -1)
                              (get-text-property (line-beginning-position)
                                                 'niva/elfeed-feed-key))))
           (same-feed (and feed-title (string= feed-title (or prev-feed-key ""))))
           (same-tags (string= tags-key (or prev-tags-key "")))
           (beg (point)))
      (insert (propertize date 'face 'elfeed-search-date-face)
              " "
              (format "%s" (propertize (or feed-title "") 'face 'elfeed-search-feed-face))
              " "
              (propertize title 'face 'elfeed-search-unread-title-face) " ")

      (unless same-tags
        (insert (propertize (format "%s" tags-raw) 'face 'elfeed-search-tag-face)))

      (unless same-tags
        (add-face-text-property beg (point)
                                `(:overline ,(face-foreground 'shadow nil t))
                                nil))

      (when read-p
        (let ((gray (or (face-foreground 'shadow nil t) "gray55")))
          (add-face-text-property beg (point) (list :foreground gray) nil)))

      ;; ensure props cover the WHOLE line, esp. the line-beg
      (let ((line-beg (save-excursion (beginning-of-line) (point)))
            (line-end (save-excursion (end-of-line) (point))))
        (put-text-property line-beg line-end 'niva/elfeed-tags-key tags-key)
        (put-text-property line-beg line-end 'niva/elfeed-feed-key (or feed-title ""))))))

;; optional: define once if you prefer a face symbol
(defface niva/elfeed-read-dim
  '((t :inherit default :foreground "gray55"))
  "Dim face for read Elfeed rows.")

(setq elfeed-search-print-entry-function #'niva/elfeed-search-print-entry--single-line-alt-mixed)

(setq elfeed-search-sort-function
      (lambda (a b)
        (let ((feed-a (elfeed-feed-title (elfeed-entry-feed a)))
              (feed-b (elfeed-feed-title (elfeed-entry-feed b))))
          (if (string= feed-a feed-b)
              (> (elfeed-entry-date a) (elfeed-entry-date b)) ; newest first
            (string-lessp feed-a feed-b)))))

(defun my/elfeed-entry-sort-by-tag-name-date (a b)
  "Sort Elfeed entries by tag, then feed name, then newest first."
  (let* ((a-tags (sort (mapcar #'symbol-name (elfeed-entry-tags a)) #'string<))
         (b-tags (sort (mapcar #'symbol-name (elfeed-entry-tags b)) #'string<))
         (a-tag (car a-tags))
         (b-tag (car b-tags))
         (a-feed (elfeed-entry-feed a))
         (b-feed (elfeed-entry-feed b))
         (a-title (or (elfeed-feed-title a-feed) ""))
         (b-title (or (elfeed-feed-title b-feed) ""))
         (a-date (elfeed-entry-date a))
         (b-date (elfeed-entry-date b)))
    (cond
     ;; by tag (alphabetically)
     ((and a-tag b-tag (not (string= a-tag b-tag)))
      (string< a-tag b-tag))
     ;; by feed name (alphabetically)
     ((not (string= a-title b-title))
      (string< a-title b-title))
     ;; finally by date (newest first)
     (t (> a-date b-date)))))

(setq elfeed-search-sort-function #'my/elfeed-entry-sort-by-tag-name-date)

(with-eval-after-load 'elfeed

  (defun niva/elfeed-switch (buff)
    ;; (popper--bury-all)
    (with-current-buffer buff
      (setq-local evil-respect-visual-line-mode nil)
      (setq-local visual-fill-column-center-text nil
                  visual-fill-column-fringes-outside-margins t
                  visual-fill-column-extra-text-width '(-4 . 0)
                  visual-fill-column-width 120
                  visual-fill-column-center-text nil)
      (adaptive-wrap-prefix-mode 1)
      (visual-fill-column-mode))
    (switch-to-buffer buff))

  (setq elfeed-show-entry-switch 'niva/elfeed-switch)
  (setq elfeed-search-remain-on-entry t)

  ;; (advice-add 'elfeed-show-next :override
  ;;             (defun niva/elfeed-show-next ()
  ;;               (interactive)
  ;;               (if (get-buffer-window "*elfeed-search*")
  ;;                   (pop-to-buffer (elfeed-search-buffer)))
  ;;               (with-current-buffer (elfeed-search-buffer)
  ;;                 (when elfeed-search-remain-on-entry (forward-line 1))
  ;;                 (call-interactively #'elfeed-search-show-entry))))

  ;; (advice-add 'elfeed-show-prev :override
  ;;             (defun niva/elfeed-show-prev ()
  ;;               (interactive)
  ;;               (if (get-buffer-window "*elfeed-search*")
  ;;                   (pop-to-buffer (elfeed-search-buffer)))
  ;;               (with-current-buffer (elfeed-search-buffer)
  ;;                 (when elfeed-search-remain-on-entry (forward-line 1))
  ;;                 (forward-line -2)
  ;;                 (call-interactively #'elfeed-search-show-entry))))

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


(provide 'niva-elfeed)

(defun niva/clear-elfeed ()
  "Clear elfeed database"
  (interactive)
  (setq elfeed-db-directory (expand-file-name "~/.elfeed"))
  (delete-directory elfeed-db-directory t)
  (message "Elfeed database cleared. Restart Elfeed to initialize a new database."))
(niva/clear-elfeed)

(with-eval-after-load 'elfeed
  (setq-default niva-elfeed-unread-count 0)
  (defun niva/elfeed-update-unread-count ()
    (interactive)
    (setq niva-elfeed-unread-count
          (cl-loop for entry in elfeed-search-entries
                   count (memq 'unread (elfeed-entry-tags entry))))))

;; (add-hook 'elfeed-db-update-hook 'niva/elfeed-update-unread-count)
;; (add-hook 'elfeed-search-update-hook 'niva/elfeed-update-unread-count)

(defvar my/elfeed-sort-reversed nil
  "Non-nil means Elfeed entries are sorted in reverse order.")

(defun my/elfeed-sort-by-date (a b)
  "Return non-nil if entry A is newer than entry B."
  (> (elfeed-entry-date a) (elfeed-entry-date b)))

(defun my/elfeed-toggle-sort-order ()
  "Toggle Elfeed sort order between newest-first and oldest-first,
then refresh and update the feed list."
  (interactive)
  (setq my/elfeed-sort-reversed (not my/elfeed-sort-reversed))
  (setq elfeed-search-sort-function
        (if my/elfeed-sort-reversed
            (lambda (a b) (not (my/elfeed-sort-by-date a b)))
          #'my/elfeed-sort-by-date))
  (message "Elfeed sort order: %s"
           (if my/elfeed-sort-reversed "Oldest first" "Newest first"))
  (when (get-buffer "*elfeed-search*")
    (with-current-buffer "*elfeed-search*"
      (elfeed-search-update :force))))

;;; niva-elfeed.el ends here
