;; -*- lexical-binding: t; -*-
(defvar my-last-timestamp nil
  "Variable to store the last timestamp.")

(defun print-time-since-last (prefix)
  "Print the time elapsed since the last call to this function with PREFIX."
  (let ((current-time (current-time)))
    (if my-last-timestamp
        (message "==== %s: %.1f seconds ====" prefix
                 (float-time (time-subtract current-time my-last-timestamp)))
      (setq my-last-timestamp current-time)
      (message "This is the first call."))))

(provide 'time-since)
