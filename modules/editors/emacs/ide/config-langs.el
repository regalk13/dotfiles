;; Typescript
(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

;; Nix
(use-package nix-mode
  :mode "\\.nix\\'"
  :hook (nix-mode . lsp-deferred))

;; Markdown
(use-package math-preview)

(use-package markdown-mode
  :mode "\\.md\\'"
  :hook (markdown-mode . variable-pitch-mode)
  :config
  (markdown-toggle-fontify-code-blocks-natively 1) ;; Enable code block syntax highlight
  ;; https://emacs.stackexchange.com/questions/14740/how-to-configure-markdown-mode-to-render-headings-like-org-mode
  (custom-set-faces
    '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.8))))
    '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.4))))
    '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.2))))))

(use-package rust-mode
  :mode "\\.rs\\'"
  :hook ((rust-mode . lsp-deferred)
         (rust-mode . rust-enable-format-on-save))
  :config
  (setq rust-format-on-save t))


(defun rust-enable-format-on-save ()
  "Enable formatting on save for rust-mode."
  (add-hook 'before-save-hook #'lsp-format-buffer nil t))

;; Optionally install lsp-mode, lsp-ui and rust-analyzer if not done yet:
(use-package lsp-mode
  :commands lsp
  :config
  (setq lsp-rust-server 'rust-analyzer))

(use-package lsp-ui
  :commands lsp-ui-mode)

;; Optional: `cargo` integration for project commands
(use-package cargo
  :hook (rust-mode . cargo-minor-mode))

;; Optional: better syntax highlighting and expansion
(use-package rustic
  :defer t)

(provide 'config-langs)
