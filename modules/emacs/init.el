;; https://jwiegley.github.io/use-package/keywords/
;; The files can now be "loaded" with (require 'file-name)
;; TODO: restructure the file structure to make more sense than this
(dolist (path '("config" "ide" "org"))
  (add-to-list 'load-path (locate-user-emacs-file path)))

(require 'config-essential)
(require 'config-ui)
(require 'config-completion)
(require 'config-help)
(require 'config-bindings)

(require 'config-lsp)
(require 'config-langs)

(require 'config-org)
(require 'config-org-roam)