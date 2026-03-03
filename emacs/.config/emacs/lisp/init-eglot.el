;;; init-eglot.el --- Eglot setup -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;;;;; Eglot --------------------------------------------------------------------
(run-with-idle-timer 10 nil (lambda () (require 'eglot)))
(use-package eglot
  :ensure t
  :defer t
  :hook ((c-mode          . eglot-ensure)
         (c++-mode        . eglot-ensure)
         (c-ts-mode       . eglot-ensure)
         (c++-ts-mode     . eglot-ensure)
         (python-mode     . eglot-ensure)
         (python-ts-mode  . eglot-ensure)
         (cmake-ts-mode   . eglot-ensure)
         (yaml-ts-mode    . eglot-ensure))
  :bind (:map eglot-mode-map
              ("C-c C-e C-a" . eglot-code-actions)
              ("C-c C-e C-d" . xref-find-definitions)
              ("C-c C-e C-r" . xref-find-references)
              ("C-c C-e C-b" . xref-go-back)
              ("C-c C-e C-f" . xref-go-forward)
              ("C-c C-e C-s" . xref-find-apropos))
  :custom
  (eglot-autoshutdown t)
  (eglot-sync-connect nil)
  ;; (eglot-events-buffer-size 0)
  ;; (eglot-extend-to-xref t)
  ;; (eglot-report-progress 'messages)
  (eglot-code-action-indications '(eldoc-hint))
  (eglot-code-action-indicator "?")
  ;; (setq-default eglot-send-changes-idle-time 5.0)
  :config
  (setq-default eglot-workspace-configuration
                '((:basedpyright . (:typeCheckingMode "basic"))))

  (add-to-list 'eglot-server-programs '((c-mode c++-mode c++-ts-mode) .
                                        ("/opt/homebrew/bin/clangd"
                                         "--pretty"
                                         "--query-driver=/opt/arm-gnu-toolchain-14.3.rel1-arm-none-eabi/bin/arm-none-eabi-g++"
                                         "--clang-tidy"
                                         ;; "--completion-style=detailed"
                                         "--completion-style=bundled"
                                         ;; "--pch-storage=memory"
                                         "--pch-storage=disk"
                                         "--header-insertion=never"
                                         ;; "--background-index-priority=background"
                                         "-j=8")))

  (add-to-list 'eglot-server-programs '((python-mode python-ts-mode)
                                        "basedpyright-langserver" "--stdio"))

  (add-to-list 'eglot-server-programs '((cmake-mode cmake-ts-mode)
                                        "neocmakelsp" "--stdio")))

(advice-add 'eglot--mode-line-format :override (lambda () ""))

(with-eval-after-load 'eglot
  ;; basedpyright can request watcher registrations that Eglot may fail to
  ;; install; replying with JSON-RPC error makes basedpyright exit.
  (cl-defmethod eglot-client-capabilities :around ((_server eglot-lsp-server))
    (let* ((caps (cl-call-next-method))
           (workspace (plist-get caps :workspace))
           (watchers (plist-get workspace :didChangeWatchedFiles)))
      (when watchers
        (setf (plist-get watchers :relativePatternSupport) :json-false))
      caps))

  (cl-defmethod eglot-register-capability :around
    (_server (method (eql workspace/didChangeWatchedFiles)) _id
             &rest _params &key &allow-other-keys)
    (condition-case err
        (cl-call-next-method)
      (error
       (message "[eglot] ignoring didChangeWatchedFiles registration failure: %s"
                (error-message-string err))
       (list t "ignored watcher registration failure"))))

  (add-hook 'eglot-managed-mode-hook (lambda () (eglot-inlay-hints-mode -1)))
  (set-face-attribute 'eglot-mode-line nil :inherit 'unspecified)

  (defun eglot--format-markup (markup)
    "Format MARKUP according to LSP's spec."
    (pcase-let ((`(,string ,mode)
                 (if (stringp markup) (list markup 'gfm-view-mode)
                   (list (plist-get markup :value)
                         (pcase (plist-get markup :kind)
                           ("markdown" 'gfm-view-mode)
                           ("plaintext" 'text-mode)
                           (_ major-mode))))))
      (with-temp-buffer
        (setq-local markdown-fontify-code-blocks-natively t)
        ;; >>> start of change >>>
        (setq string (replace-regexp-in-string "\n---" "  " string))
        ;; <<< end of change <<<
        (insert string)
        (let ((inhibit-message t)
              (message-log-max nil)
              match)
          (ignore-errors (delay-mode-hooks (funcall mode)))
          (font-lock-ensure)
          (goto-char (point-min))
          (let ((inhibit-read-only t))
            (when (fboundp 'text-property-search-forward)
              (while (setq match (text-property-search-forward 'invisible))
                (delete-region (prop-match-beginning match)
                               (prop-match-end match)))))
          (string-trim (buffer-string)))))))

(use-package eglot-booster
  :ensure
  (eglot-booster :type git :host github :repo "jdtsmith/eglot-booster")
  :defer t
  :config (eglot-booster-mode))

(use-package eglot-inactive-regions
  :ensure t
  :demand t
  :after eglot
  :custom
  (eglot-inactive-regions-opacity 0.4)
  :config
  (eglot-inactive-regions-mode 1))

;;;; jsonrpc -------------------------------------------------------------------
(use-package jsonrpc :ensure t :defer t)

(with-eval-after-load 'jsonrpc
  ;; Compatibility for older jsonrpc builds that don't accept
  ;; :cancel-on-quit (used by newer eglot).
  (unless (string-match-p ":cancel-on-quit"
                          (or (documentation #'jsonrpc-request) ""))
    (defun niva/jsonrpc-request-compat-cancel-on-quit
        (orig-fun connection method params &rest args)
      "Call ORIG-FUN dropping unsupported :cancel-on-quit from ARGS."
      (let (filtered)
        (while args
          (let ((key (pop args))
                (val (pop args)))
            (unless (eq key :cancel-on-quit)
              (setq filtered (append filtered (list key val))))))
        (apply orig-fun connection method params filtered)))
    (advice-add 'jsonrpc-request :around
                #'niva/jsonrpc-request-compat-cancel-on-quit)))

(provide 'init-eglot)
;;; init-eglot.el ends here
