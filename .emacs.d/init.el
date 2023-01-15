(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(setq visible-bell t)

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                          ("org" . "https://orgmode.org/elpa/")
			  ("elpa" . "https://elpa.gnu.org/packages")))

(add-to-list 'package-archives
    (cons "gnu-devel" "https://elpa.gnu.org/devel/")
    t)

(add-to-list 'package-archives
             '("melpa-milk" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)
(unless package-archive-contents
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
      (package-install 'use-package))      
(setq use-package-always-ensure t)

;; Save backupsq
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)

(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;; Using garbage magic hack.
 (use-package gcmh
   :config
   (gcmh-mode 1))
;; Setting garbage collection threshold
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)

;; Profile emacs startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;; Silence compiler warnings as they can be pretty disruptive (setq comp-async-report-warnings-errors nil)
;; Silence compiler warnings as they can be pretty disruptive
(if (boundp 'comp-deferred-compilation)
    (setq comp-deferred-compilation nil)
    (setq native-comp-deferred-compilation nil))
;; In noninteractive sessions, prioritize non-byte-compiled source files to
;; prevent the use of stale byte-code. Otherwise, it saves us a little IO time
;; to skip the mtime checks on every *.elc file.
(setq load-prefer-newer noninteractive)

(set-face-attribute `default nil :font "Iosevka Nerd Font" :height 120)
(use-package all-the-icons)


(use-package doom-themes
  :ensure t
  :config
    (setq doom-themes-enable-bold t
    doom-theemes-enable-italic t)
  (load-theme 'gruber-darker t)
 (doom-themes-neotree-config)
 (setq doom-themes-treemacs-theme "doom-atom")
 (doom-themes-treemacs-config)
 (doom-themes-org-config))

(use-package tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(global-set-key (kbd "<escape>") 'keyboard-escape-quite)

(global-display-line-numbers-mode t)

(setq display-line-numbers-type 'relative)

(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
(use-package command-log-mode)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package command-log-mode)
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

; (global-set-key (kbd "C-M-j") 'counsel-switch-buffer)

(require 'ivy)
(require 'counsel)
(counsel-mode)
(ivy-mode)

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 20)))

(use-package general
  :config
  (general-create-definer rune/leader-keys
    ;;:keymaps '(normal insert visual emacs)
    ;;:prefix "SPC"
    :prefix "C-SPC"))

(use-package evil
   :init
   (setq evil-want-integration t)
   (setq evil-want-keybinding nil)
   (setq evil-want-C-u-scroll t)
   (setq evil-want-C-i-jump nil)
   :config
   (evil-mode 1)
   (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
   (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

   (evil-global-set-key 'motion "j" 'evil-next-visual-line)
   (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

   (evil-set-initial-state 'messages-buffer-mode 'normal)
   (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Projects/")
    (setq projectile-project-search-path '("~/Projects/")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package forge)

(use-package org)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

;; Configuration dashboard
(setq dashboard-banner-logo-title "Welcome to Emacs")
;; Set the banner
(setq dashboard-startup-banner 'logo)

;; content is not centered by default. To center, set
(setq dashboard-center-content t)


(setq dashboard-show-shortcuts nil)

(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5)))

(defun dashboard-insert-custom (list-size)
  (insert "Custom text"))
(add-to-list 'dashboard-item-generators  '(custom . dashboard-insert-custom))
(add-to-list 'dashboard-items '(custom) t)

(setq dashboard-item-names '(("Recent Files:" . "Recently opened files:")
                             ("Agenda for today:" . "Today's agenda:")
                             ("Agenda for the coming week:" . "Agenda:")))

(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)

(use-package vterm
  :load-path "~/emacs-libvterm/")

(use-package org-roam
  :ensure t)

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/Projects/notes/"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

;; Install websocket from the file if you have some error
;; Install it! from M+x package install 
;; (require 'org-roam-ui)

(electric-pair-mode 1)

(require 'elcord)
(elcord-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("2f8eadc12bf60b581674a41ddc319a40ed373dd4a7c577933acaff15d2bf7cc6" "60ada0ff6b91687f1a04cc17ad04119e59a7542644c7c59fc135909499400ab8" "b99e334a4019a2caa71e1d6445fc346c6f074a05fcbb989800ecbe54474ae1b0" "631c52620e2953e744f2b56d102eae503017047fb43d65ce028e88ef5846ea3b" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "636b135e4b7c86ac41375da39ade929e2bd6439de8901f53f88fde7dd5ac3561" "bddf21b7face8adffc42c32a8223c3cc83b5c1bbd4ce49a5743ce528ca4da2b6" default))
 '(elcord-client-id "1063980267234140180")
 '(elcord-icon-base
   "https://raw.githubusercontent.com/regalk13/dotfiles/main/.emacs.d/icons/")
 '(elcord-mode-icon-alist
   '((agda-mode . "agda-mode_icon")
     (assembly-mode . "assembly-mode_icon")
     (c-mode . "c-mode_icon")
     (c++-mode . "cpp-mode_icon")
     (clojure-mode . "clojure-mode_icon")
     (csharp-mode . "csharp-mode_icon")
     (comint-mode . "comint-mode_icon")
     (cperl-mode . "cperl-mode_icon")
     (elixir-mode . "elixir-mode_icon")
     (emacs-lisp-mode elcord--editor-icon)
     (enh-ruby-mode . "ruby-mode_icon")
     (erc-mode . "irc-mode_icon")
     (erlang-mode . "erlang-mode_icon")
     (forth-mode . "forth-mode_icon")
     (fsharp-mode . "fsharp-mode_icon")
     (gdscript-mode . "gdscript-mode_icon")
     (haskell-mode . "haskell-mode_icon")
     (haskell-interactive-mode . "haskell-mode_icon")
     (hy-mode . "hy-mode_icon")
     (java-mode . "java-mode_icon")
     (julia-mode . "julia-mode_icon")
     (js-mode . "javascript-mode_icon")
     (kotlin-mode . "kotlin-mode_icon")
     (go-mode . "go-mode_icon")
     (latex-mode . "latex-mode_icon")
     (lisp-mode . "lisp-mode_icon")
     (magit-mode . "magit-mode_icon")
     (markdown-mode . "markdown-mode_icon")
     (meson-mode . "meson-mode_icon")
     (nim-mode . "nim-mode_icon")
     (nix-mode . "nix-mode_icon")
     (ocaml-mode . "ocaml-mode_icon")
     (org-mode . "org-mode_icon")
     (pascal-mode . "pascal-mode_icon")
     (php-mode . "php-mode_icon")
     (puml-mode . "puml-mode_icon")
     (puppet-mode . "puppet-mode_icon")
     (python-mode . "python-mode_icon")
     (racket-mode . "racket-mode_icon")
     (ruby-mode . "ruby-mode_icon")
     (rust-mode . "rust-mode_icon")
     (rustic-mode . "rust-mode_icon")
     (solidity-mode . "solidity-mode_icon")
     (sh-mode . "comint-mode_icon")
     (terraform-mode . "terraform-mode_icon")
     (typescript-mode . "typescript-mode_icon")
     (zig-mode . "zig-mode_icon")
     ("^slime-.*" . "lisp-mode_icon")
     ("^sly-.*$" . "lisp-mode_icon")))
 '(elcord-use-major-mode-as-main-icon nil)
 '(package-selected-packages
   '(elcord gcmh websocket org-roam-ui org-roam rust-mode tree-sitter-langs tree-sitter gruber-darker-theme yasnippet which-key vterm use-package rainbow-delimiters ivy-rich helm-xref helm-lsp general forge flycheck evil-collection doom-themes doom-modeline dashboard dap-mode counsel-projectile company command-log-mode all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

