;; === Which-key ===
;; Use which-key to see available keybindings
(use-package emacs
  :config
  (which-key-mode 1)
  :custom
  (which-key-idle-delay 0.1)
  (which-key-idle-secondary-delay 0))

;; === Helpful (better help buffer) ===
;; https://github.com/Wilfred/helpful/issues/314
;; (use-package helpful)
;; 	:custom
;; 	(counsel-describe-function-function #'helpful-callable)
;; 	(counsel-describe-variable-function #'helpful-variable)
;; 	:bind
;; 	([remap describe-function] . counsel-describe-function)
;; 	([remap describe-command] . helpful-command)
;; 	([remap describe-variable] . counsel-describe-variable)
;; 	([remap describe-key] . helpful-key))

(provide 'config-help)