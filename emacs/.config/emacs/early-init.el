;;; early-init.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; (require 'server)
;;
;; (defun my/redirect-to-running-server ()
;;   (when (and (not (daemonp))
;;              (server-running-p))
;;     (let ((args (append '("-c") command-line-args-left)))
;;       (apply #'call-process "/opt/homebrew/bin/emacsclient" nil 0 nil args))
;;     (kill-emacs)))
;;
;; (my/redirect-to-running-server)
;;
;; (unless (server-running-p)
;;   (server-start))

(defun add-to-exec-path! (dir &optional append)
  "Add DIR to `exec-path` and sync $PATH. APPEND puts it at the end."
  (let ((x (expand-file-name dir)))
    (when (file-directory-p x)
      (setq exec-path (if append
                          (append exec-path (list x))
                        (cons x (delete x exec-path))))
      (setq exec-path (delete-dups exec-path))
      (setenv "PATH" (mapconcat #'identity exec-path path-separator)))))

(mapc #'add-to-exec-path!
      '("/Users/niklas/.pyenv/shims"
        "/Users/niklas/.pyenv/bin"
        "/Users/niklas/scripts"
        "/Users/niklas/.local/bin"
        "/Users/niklas/.cargo/bin"
        "/Users/niklas/.go/bin"
        "/Users/niklas/.bin/mipsel-none-elf/bin"
        "/Users/niklas/.bin"
        "/opt/homebrew/opt/gnu-sed/libexec/gnubin"
        "/opt/homebrew/opt/coreutils/libexec/gnubin"
        "/Applications/ARM/bin"
        "/opt/homebrew/bin"
        "/opt/homebrew/sbin"
        "/Applications/Xcode.app/Contents/Developer/usr/bin"))

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      package-enable-at-startup nil
      package-quickstart nil
      frame-inhibit-implied-resize t
      site-run-file nil
      inhibit-startup-screen t
      inhibit-startup-message t
      use-file-dialog nil
      use-dialog-box nil
      auto-mode-case-fold nil)

(setq inhibit-redisplay t
      inhibit-message t)
(add-hook 'window-setup-hook
          (lambda ()
            (setq inhibit-redisplay nil
                  inhibit-message nil)
            (redisplay)))

(defvar my--file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq file-name-handler-alist my--file-name-handler-alist)
            (makunbound 'my--file-name-handler-alist)))
(tool-bar-mode -1)
(tooltip-mode -1)
(unless (eq system-type 'darwin)
  (menu-bar-mode -1))
(set-fringe-mode 1)

(add-to-list 'default-frame-alist '(min-height . 1))
(add-to-list 'default-frame-alist '(height . 45))
(add-to-list 'default-frame-alist '(min-width . 1))
(add-to-list 'default-frame-alist '(width . 115))
(add-to-list 'default-frame-alist '(internal-border-width . 5))
(add-to-list 'default-frame-alist '(vertical-scroll-bars . nil))
(add-to-list 'default-frame-alist '(tool-bar-lines . 0))
(add-to-list 'default-frame-alist '(left-fringe . 1))
(add-to-list 'default-frame-alist '(right-fringe . 1))
(add-to-list 'default-frame-alist '(undecorated . nil))

(when (featurep 'ns)
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . nil))
  (add-to-list 'default-frame-alist '(ns-appearance . dark))
  (setq ns-antialias-text t
        ns-use-native-fullscreen t
        ns-use-proxy-icon nil
        ns-use-thin-smoothing nil))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(setq vc-follow-symlinks t)

(setq-default header-line-format nil)

(when (boundp 'native-comp-speed)
  (setq native-comp-speed 2))
(setq native-comp-async-report-warnings-errors 'silent)

(setq gnus-init-inhibit t)
