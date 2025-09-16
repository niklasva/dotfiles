;; ;;; Log coloring
;; ;; (defun niva/font-lock-comment-annotations ()
;; ;;   "Colorize keywords in eshell buffers"
;; ;;   (interactive)
;; ;;   (font-lock-add-keywords
;; ;;    nil
;; ;;    '(("\\<\\(.*ERR.*\\)"                                            1 'compilation-error   t)
;; ;;      ("\\<\\(.*INFO.*\\)"                                           1 'compilation-info    t)
;; ;;      ("\\<\\(.*DEBUG.*\\)"                                          1 'compilation-info    t)
;; ;;      ("\\<\\(.*WARN.*\\)"                                           1 'compilation-warning t)
;; ;;      ("\\<\\(.*DEBUG: --- CMD: POLL(60) REPLY: ISTATR(49) ---.*\\)" 1 'completions-common-part t)
;; ;;      ("\\<\\(.*DEBUG: --- CMD: OUT(68) REPLY: ACK(40) ---.*\\)"     1 'completions-common-part t))))
;; ;;
;; ;; (add-hook 'eshell-mode-hook 'niva/font-lock-comment-annotations)

;;;; Mastodon ------------------------------------------------------------------
;; ;; #+begin_src disabled
;; ;; (use-package mastodon
;; ;;   :ensure (:host codeberg :repo "martianh/mastodon.el")
;; ;;   :defer t
;; ;;   :config
;; ;;   (setq mastodon-active-user "@niklasva"
;; ;;         mastodon-instance-url "https://social.tchncs.de"
;; ;;         mastodon-tl--show-avatars t
;; ;;         mastodon-tl--horiz-bar ""
;; ;;         mastodon-tl--after-update-marker t
;; ;;         mastodon-tl--display-media-p t
;; ;;         mastodon-tl--no-fill-on-render t
;; ;;         mastodon-tl--show-stats nil
;; ;;         mastodon-tl--expand-content-warnings t
;; ;;         mastodon-tl--timeline-posts-count "40")
;; ;;   (custom-set-faces '(mastodon-display-name-face ((t (:inherit 'org-level-1)))))
;; ;;
;; ;;
;; ;;   (defun my-mastodon-more () (interactive) (mastodon-tl--more))
;; ;;   (add-hook 'mastodon-mode-hook (lambda ()
;; ;;                                   (setq-local visual-fill-column-center-text nil
;; ;;                                               visual-fill-column-fringes-outside-margins t
;; ;;                                               visual-fill-column-extra-text-width '(-2 . 0)
;; ;;                                               fill-column 9999
;; ;;                                               visual-fill-column-width 60)
;; ;;                                   (visual-fill-column-mode)))
;; ;;   (define-key mastodon-mode-map (kbd "m")   'my-mastodon-more))
;; ;;
;; ;; (use-package mastodon-alt
;; ;;   :after mastodon
;; ;;   :defer t
;; ;;   :ensure (:host github :repo "rougier/mastodon-alt")
;; ;;   :config
;; ;;   (mastodon-alt-tl-activate)
;; ;;   (setq mastodon-alt-tl-box-width 50
;; ;;         mastodon-media--preview-max-height 150
;; ;;         mastodon-tl--enable-relative-timestamps t
;; ;;         mastodon-tl--enable-relative-timestamps nil)
;; ;;   (defun mastodon-alt-tl--toot-status (toot))
;; ;;   (advice-add 'mastodon-tl--byline :filter-return (lambda (ret) (string-remove-suffix "\n" ret)))
;; ;;   (advice-remove 'mastodon-tl--byline #'mastodon-alt-tl--byline)
;; ;;   (advice-remove 'mastodon-media--process-image-response #'mastodon-alt-media--process-image-response))
;; ;; #+end_src

;;; My packages ----------------------------------------------------------------
;; (use-package iscroll
;;   :ensure t
;;   :diminish iscroll-mode
;;   :hook ((text-mode elfeed-show-mode eww-mode shr-mode) . iscroll-mode))
;;   ;; :config
;;   ;; (evil-define-key 'normal iscroll-mode-map (kbd "k") 'iscroll-previous-line)
;;   ;; (evil-define-key 'normal iscroll-mode-map (kbd "j") 'iscroll-next-line))
