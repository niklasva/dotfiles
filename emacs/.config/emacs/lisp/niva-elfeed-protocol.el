;;; niva-elfeed-protocol.el --- Extensions to elfeed-protocol -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(advice-add 'elfeed-protocol-fever--parse-entries :override
            (defun niva/elfeed-protocol-fever--parse-entries (host-url items &optional mark-state update-action callback)
              "Parse the entries JSON buffer and fill results to elfeed db.
HOST-URL is the host name of Fever server.  ITEMS is the result JSON items by
http request.  If MARK-STATE is nil, then just not update :last-entry-id or
:first-entry-id values.  UPDATE-ACTION could be update, update-older or
update-star.  If CALLBACK is not nil, will call it with the result entries as
argument.  Return parsed entries."
              (if (> (hash-table-count elfeed-protocol-fever-feeds) 0)
                  (let* ((proto-id (elfeed-protocol-fever-id host-url))
                         (entry-mark (elfeed-protocol-fever-get-update-mark proto-id update-action))
                         (min-entry-id -1)
                         (max-entry-id -1)
                         (first-entry-id -1)
                         (unread-num 0)
                         (starred-num 0)
                         (begin-time (time-to-seconds))
                         entries)
                    (elfeed-log 'debug "elfeed-protocol-fever: %s, parsing entries, entry-mark: %d" update-action entry-mark)
                    (setq entries
                          (cl-loop for item across items collect
                                   (pcase-let* (((map id ('url entry-url) title
                                                      author ('created_on_time pub-date) ('html body)
                                                      ('feed_id feed-id))
                                                 item)

                                                ;;; Custom code
                                                (pub-date (if (string-equal author "Richard Stallman")
                                                              (- pub-date 21600)
                                                            pub-date))
                                                ;;;

                                                (id (if (stringp id) (string-to-number id) id))
                                                (feed-id (if (stringp feed-id) (string-to-number feed-id) feed-id))
                                                (guid-hash (elfeed-generate-id (format "%s%s%s%s" title entry-url pub-date body)))
                                                (feed-url
                                                 (if (null feed-id)
                                                     ""
                                                   (elfeed-protocol-fever--get-subfeed-url host-url feed-id)))
                                                (unread (eq (map-elt item 'is_read) 0))
                                                (starred (eq (map-elt item 'is_saved) 1))

                                                (namespace (elfeed-url-to-namespace feed-url))
                                                (full-id (cons namespace (elfeed-cleanup guid-hash)))
                                                (original (elfeed-db-get-entry full-id))
                                                (original-date (and original
                                                                    (elfeed-entry-date original)))
                                                (category-name (when elfeed-protocol-fever-fetch-category-as-tag
                                                                 (elfeed-protocol-fever--get-category-name
                                                                  host-url
                                                                  (elfeed-protocol-fever--get-subfeed-category-id host-url feed-id))))
                                                (autotags (elfeed-protocol-feed-autotags proto-id feed-url))
                                                (fixtags (elfeed-normalize-tags
                                                          autotags elfeed-initial-tags))
                                                (tags (progn
                                                        (unless unread
                                                          (setq fixtags (delete 'unread fixtags)))
                                                        (when starred
                                                          (push elfeed-protocol-fever-star-tag fixtags))
                                                        (when category-name
                                                          (push (intern category-name) fixtags))
                                                        fixtags))
                                                (db-entry (elfeed-entry--create
                                                           :title (elfeed-cleanup title)
                                                           :id full-id
                                                           :feed-id (elfeed-protocol-format-subfeed-id
                                                                     proto-id feed-url)
                                                           :link (elfeed-cleanup entry-url)
                                                           :tags tags
                                                           :date (elfeed-new-date-for-entry
                                                                  original-date pub-date)
                                                           :content body
                                                           :content-type 'html
                                                           :meta `(,@(elfeed-protocol-build-meta-author author)
                                                                   ,@(list :protocol-id proto-id
                                                                           :id id
                                                                           :guid-hash guid-hash
                                                                           :feed-id feed-id)))))
                                     (when unread (setq unread-num (1+ unread-num)))
                                     (when starred (setq starred-num (1+ starred-num)))

                                     ;; force override unread and star tags without repeat sync operation
                                     (when original
                                       (if unread (elfeed-tag-1 original 'unread)
                                         (elfeed-untag-1 original 'unread))
                                       (if starred (elfeed-tag-1 original elfeed-protocol-fever-star-tag)
                                         (elfeed-untag-1 original elfeed-protocol-fever-star-tag)))

                                     (when (> id max-entry-id)
                                       (setq max-entry-id id))
                                     (if (< min-entry-id 0)
                                         (setq min-entry-id id)
                                       (when (< id min-entry-id)
                                         (setq min-entry-id id)))

                                     (dolist (hook elfeed-new-entry-parse-hook)
                                       (run-hook-with-args hook :fever item db-entry))
                                     db-entry)))
                    (elfeed-db-add entries)
                    (when callback (funcall callback entries))

                    ;; update last entry skip count
                    (when mark-state
                      (if (>= entry-mark 0)
                          ;; update entry mark
                          (cond
                           ((eq update-action 'update)
                            (elfeed-protocol-fever-set-update-mark
                             proto-id update-action (max entry-mark max-entry-id)))
                           ((eq update-action 'update-older)
                            (let* ((id (max 1 (- entry-mark elfeed-protocol-fever-maxsize))))
                              (elfeed-protocol-fever-set-update-mark
                               proto-id update-action id))))
                        ;; init entry mark
                        (setq first-entry-id (max 1 max-entry-id))
                        (cond
                         ((eq update-action 'update)
                          (elfeed-protocol-fever-set-update-mark proto-id update-action first-entry-id)
                          ;; set :first-entry-id same with :last-entry-id
                          (elfeed-protocol-fever-set-update-mark proto-id 'update-older first-entry-id))
                         ((eq update-action 'update-older)
                          (elfeed-protocol-fever-set-update-mark proto-id update-action first-entry-id)))))

                    (elfeed-log 'debug "elfeed-protocol-fever: %s, parsed %d entries(%d unread, %d starred, min-entry-id %d, max-entry-id %d) with %fs, entry-mark: %d"
                                update-action (length entries) unread-num starred-num min-entry-id max-entry-id
                                (- (time-to-seconds) begin-time)
                                (elfeed-protocol-fever-get-update-mark proto-id update-action))
                    entries)
                (progn
                  (elfeed-log 'error "elfeed-protocol-fever: elfeed-protocol-fever-feeds is nil, please call elfeed-protocol-fever--update-feed-list first")
                  nil)))
            )

(provide 'niva-elfeed-protocol)
;;; niva-elfeed-protocol.el ends here
