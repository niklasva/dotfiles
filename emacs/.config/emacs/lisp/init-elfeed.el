;;; init-elfeed.el --- Elfeed setup -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(setq niva-inhibit-elfeed-images t)

(global-set-key (kbd "C-c elf") 'elfeed)

(use-package elfeed
  :ensure t
  :defer t
  ;; :hook (elfeed-search-mode . elfeed-update)
  :config
  (setq elfeed-search-title-max-width 120)
  (setq elfeed-search-filter "+unread")
  (setq elfeed-show-truncate-long-urls nil)
  (setq shr-inhibit-images niva-inhibit-elfeed-images)
  (require 'elfeed-custom))

(defun niva/elfeed-search-hook ()
  (elfeed-update)
  ;; (set-window-dedicated-p (selected-window) t)
  (visual-line-mode 0)
  (setf (cdr (assq 'truncation   fringe-indicator-alist)) '(nil nil)
        (cdr (assq 'continuation fringe-indicator-alist)) '(nil nil))
  (setq-local truncate-lines t))

(add-hook 'elfeed-search-mode-hook #'niva/elfeed-search-hook)
(add-hook 'elfeed-show-mode-hook (lambda ()
                                   (blink-cursor-mode 0)))

(use-package elfeed-summary
  :ensure t
  :defer t
  :after elfeed
  :config
  (setopt elfeed-summary-settings
          '((group
             (:title . "Tags")
             (:elements
              (search (:title . "alt/games")   (:filter . "+alt/games"))
              (search (:title . "jp/lang")     (:filter . "+jp/lang"))
              (search (:title . "mail/gnu")    (:filter . "+mail/gnu"))
              (search (:title . "alt/music")   (:filter . "+alt/music"))
              (search (:title . "news/bummer") (:filter . "+news/bummer"))
              (search (:title . "tech/news")   (:filter . "+tech/news"))
              (search (:title . "tech/blogs")  (:filter . "+tech/blogs"))
              (search (:title . "tech/sec")    (:filter . "+tech/sec"))
              (search (:title . "")            (:filter . "+none"))
              (search (:title . "stallman")    (:filter . "RMS"))
              (search (:title . "slashdot")    (:filter . "Slashdot"))
              (search (:title . "pluralistic") (:filter . "pluralistic"))
              (search (:title . "unread")      (:filter . "+unread")))))))

(use-package elfeed-protocol
  :ensure t
  :after elfeed
  :config
  (require 'elfeed-protocol-custom)
  (setq elfeed-use-curl t
        elfeed-sort-order 'descending
        elfeed-protocol-enabled-protocols '(fever)
        elfeed-protocol-fever-update-unread-only nil
        elfeed-protocol-fever-maxsize 120
        elfeed-protocol-fever-fetch-category-as-tag t
        elfeed-protocol-feeds (list (list niva/elfeed-fever-url
                                          :api-url niva/elfeed-api-url
                                          :password (niva/lookup-password :host "fever"))))

  (unless niva-enable-evil-mode
    (define-key elfeed-search-mode-map (kbd "x") #'(lambda () (interactive) (elfeed-search-untag-all-unread) (next-line)))
    (define-key elfeed-search-mode-map (kbd "X") #'(lambda () (interactive) (elfeed-search-untag-all-unread) (previous-line))))

  (define-key elfeed-search-mode-map              (kbd "I") #'niva/elfeed-toggle-images)
  (with-eval-after-load 'evil-maps
    (evil-define-key 'normal elfeed-show-mode-map "I" #'niva/elfeed-toggle-images)
    (evil-define-key 'normal elfeed-search-mode-map (kbd "C-p") #'evil-previous-line)
    (evil-define-key 'normal elfeed-search-mode-map (kbd "C-n") #'evil-next-line)
    (evil-define-key 'normal elfeed-search-mode-map (kbd "k") #'evil-previous-line)
    (evil-define-key 'normal elfeed-search-mode-map (kbd "j") #'evil-next-line)
    (evil-define-key 'normal elfeed-search-mode-map (kbd "x") #'(lambda () (interactive) (elfeed-search-untag-all-unread) (next-line)))
    (evil-define-key 'normal elfeed-search-mode-map (kbd "X") #'(lambda () (interactive) (elfeed-search-untag-all-unread) (previous-line)))
    (evil-define-key 'normal elfeed-show-mode-map   (kbd "'") #'niva/elfeed--move-paragraph-up)
    (evil-define-key 'normal elfeed-show-mode-map   (kbd ";") #'niva/elfeed--move-paragraph-down)
    (evil-define-key 'normal elfeed-search-mode-map "r" 'elfeed-update)

    (defun niva/eww--move-paragraph-up ()
      (interactive)
      (if (derived-mode-p 'eww-mode)
          (condition-case nil
              (progn
                (evil-backward-paragraph 2)
                (forward-line 1)
                (evil-scroll-line-to-center nil)))))

    (defun niva/eww--move-paragraph-down ()
      (interactive)
      (if (derived-mode-p 'eww-mode)
          (condition-case nil
              (progn
                (evil-forward-paragraph)
                (evil-scroll-line-to-center nil)
                (forward-line 1)))))

    (evil-define-key 'normal eww-mode-map   (kbd "'") #'niva/eww--move-paragraph-up)
    (evil-define-key 'normal eww-mode-map   (kbd ";") #'niva/eww--move-paragraph-down))

  (elfeed-protocol-enable))

(provide 'init-elfeed)
;;; init-elfeed.el ends here
