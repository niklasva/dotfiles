;;; niva-irc.el --- IRC in emacs -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


(use-package circe
  :ensure t
  :defer t
  :config
  (setq lui-fill-column                     80
        lui-time-stamp-position             'right
        lui-time-stamp-only-when-changed-p  t
        lui-time-stamp-format               "[%H:%M]"
        lui-fill-type                       "                "
        circe-reduce-lurker-spam            t
        circe-server-buffer-name            "{network}"
        circe-server-max-reconnect-attempts 2
        circe-default-nick                  "niklas"
        circe-default-realname              "niklas"
        circe-format-server-topic           "{new-topic}"
        circe-format-say                    "{nick:-16s}{body}"
        circe-format-self-say               circe-format-say
        circe-default-part-message          nil
        circe-default-quit-message          nil
        circe-chat-buffer-name              " irc://{target}"
        circe-network-defaults              nil
        lui-logging-file-format             "{buffer}/%Y-%m-%d.txt")

  (enable-lui-logging-globally)
  (enable-lui-track)
  (niva/setup-irc-config)
  (enable-circe-color-nicks)

  (add-hook 'circe-channel-mode-hook 'read-only-mode)
  (circe-set-display-handler "353" 'circe-display-ignore)
  (circe-set-display-handler "366" 'circe-display-ignore)

  (setq lui-time-stamp-position 'right-margin
        lui-fill-type nil)

  (defun my-lui-setup ()
    (setq fringes-outside-margins t
          right-margin-width 7
          word-wrap t;
          wrap-prefix "              ")
    (setf (cdr (assoc 'continuation fringe-indicator-alist)) nil)
    (add-hook 'lui-mode-hook 'my-lui-setup)))

;;; IRC notifications
(with-eval-after-load 'circe
  (defvar niva--irc-notification "")

  (defun niva/irc-log-face (target)
    (setq-local niva--irc-log-face
                (if (string-prefix-p "#yos" target)
                    'font-lock-type-face
                  'font-lock-string-face)))

  (defvar niva--irc-busy nil)
  (defun niva/privmsg (nick userhost _command target text)
    (niva/log-to-buffer " irc://history" target nick text)
    (unless niva--irc-busy
      (setq niva--irc-busy t)
      (setq niva--irc-notification (substring (format "%s@%s: \"%s\"" nick target text) 0 20))
      (run-with-timer 3 nil (lambda ()
                              (setq niva--irc-notification "")
                              (force-mode-line-update t)
                              (setq niva--irc-busy nil)))))

  (advice-add 'circe-display-PRIVMSG :after #'niva/privmsg)

  (defun niva/remove-irc-notification-if-read (orig-func buffer-or-name &rest args)
    (let ((buf (get-buffer buffer-or-name)))
      (when (and buf (with-current-buffer buf (derived-mode-p 'circe-channel-mode)))
        (setq niva--irc-notification ""))
      (apply orig-func buffer-or-name args))))


;;; IRC log window
(defun niva/log-to-buffer (buffer nick target text)
  (setq my-buffer (get-buffer-create buffer))
  (with-current-buffer my-buffer
    (funcall 'niva/irc-log-mode)
    (setq buffer-read-only nil)
    (goto-char (point-max))
    (insert (format "%s %s %s %s\n"
                    (propertize (format-time-string "[%H:%M]") 'face 'font-lock-comment-face)
                    (propertize target 'face (niva/irc-log-face target))
                    (propertize (format "%s" nick) 'face 'circe-highlight-nick-face)
                    text))
    (goto-char (point-max)))
  (setq buffer-read-only t))

(define-derived-mode niva/irc-log-mode prog-mode ()
  (setq window-point-insertion-type t)
  (solaire-mode 1)
  (read-only-mode t))


;;; List IRC buffers
(defvar niva--switch-irc-buffers-times 0)
(defun niva/switch-irc-buffers ()
  (interactive)
  (let ((original-buffer (current-buffer)))
    (let ((irc-buffers (seq-filter (lambda (buf)
                                     (string-prefix-p " irc://" (buffer-name buf)))
                                   (buffer-list))))
      (if irc-buffers
          (switch-to-buffer (completing-read "Switch to buffer: " (mapcar 'buffer-name irc-buffers)))
        (progn
          (if (= 0 niva--switch-irc-buffers-times)
              (progn
                (setq niva--switch-irc-buffers-times 1)
                (message "Starting Circe...")
                (circe "znc")
                (switch-to-buffer original-buffer)
                (sit-for 3)
                (niva/switch-irc-buffers))
            (message "Circe timed out.")))))))

(provide 'niva-irc)
;;; niva-irc.el ends here
