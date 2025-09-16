;;;;;;;;;;;;; new init ;;;;;;;;;;;
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))



(defvar import-file (expand-file-name "private/config.el" user-emacs-directory))
(when (file-readable-p import-file) (load import-file))

(setq-default show-trailing-whitespace t)

(fido-vertical-mode)
(recentf-mode)

(use-package gptel
  :diminish gptel-mode
  :defer t
  :ensure (gptel :host github :repo "karthink/gptel" branch "master")
  :config
  (setq gptel-default-mode #'org-mode
        gptel-prompt-prefix-alist '((org-mode . "> "))))

(use-package exec-path-from-shell :ensure t :init (exec-path-from-shell-initialize))
(use-package consult :ensure t :bind (("C-x b" . consult-buffer)))
(use-package orderless :ensure t)

(global-completion-preview-mode)
(setq completion-styles '(orderless basic)
      completion-auto-help 'visible ;; Display *Completions* upon first request
      completions-format 'one-column ;; Use only one column
      completions-sort 'historical ;; Order based on minibuffer history
      completions-max-height 20 ;; Limit completions to 15 (completions start at line 5)
      completion-category-defaults nil
      completion-category-overrides '((file (styles . (partial-completion)))))

(define-key minibuffer-local-completion-map (kbd "SPC") 'self-insert-command)
