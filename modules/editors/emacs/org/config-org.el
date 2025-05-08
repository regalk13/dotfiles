;; Different font sizes for headings
(defun os/org-mode-font-setup ()
    (dolist (face '((org-level-1 . 1.2)
                    (org-level-2 . 1.1)
                    (org-level-3 . 1.05)
                    (org-level-4 . 1.0)
                    (org-level-5 . 1.1)
                    (org-level-6 . 1.1)
                    (org-level-7 . 1.1)
                    (org-level-8 . 1.1)))
        (set-face-attribute (car face) nil :font "DejaVu Sans" :weight 'regular :height (cdr face)))

    (set-face-attribute 'org-block nil :inherit 'fixed-pitch)
    (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))


;; Move different things to set into its own function
(defun os/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent nil))


(use-package org
  :hook (org-mode . os/org-mode-setup)
  :config
  (setq org-ellipsis " \u25be")
  (os/org-mode-font-setup)

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-return-follows-link t)
  (setq org-hide-emphasis-markers t)
  (setq org-agenda-files '("~/notes/org"))

  ;; Increase LaTeX preview size (C-c C-x C-l)
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))

  ;; Capture templates
  (setq org-capture-templates
    '(
      ("t" "General To-Do"
        entry (file+headline "~/notes/org/todo.org" "General Tasks")
        "* TODO [#B] %?\n:Created: %T\n "
        :empty-lines 0)
    )
  )

  ;; To-Do states
  (setq org-todo-keywords
    '((sequence "TODO(t)" "PLANNING(p)" "IN-PROGRESS(i@/!)" "VERIFYING(v!)" "BLOCKED(b@)" "|" "DONE(d!)" "OBE(o@!)" "Wont-DO(w@/!)"))
  )

  ;; org-babel
  (org-babel-do-load-languages
     'org-babel-load-languages
     '((emacs-lisp . t)
       (python . t)))

  (setq org-confirm-babel-evaluate nil)
  (setq org-babel-python-command "python3") ;; Fix the python executable name
  (push '("conf-unix" . conf-unix) org-src-lang-modes)

  ;; Set key bindings
  ;; Old keybinds, currently looking at https://github.com/james-stoup/emacs-org-mode-tutorial before making new ones
  ;; (os/leader-keys
  ;;   "o" '(:ignore t :which-key "Org mode")
  ;;   ;; "ol" '(org-agenda-list :which-key "Agenda list")
  ;;   "oa" '(org-agenda :which-key "Agenda")
  ;;   "oo" '(org-capture :which-key "Capture")
  ;;   "os" '(org-schedule :which-key "Add SCHEDULE")
  ;;   "od" '(org-deadline :which-key "Add DEADLINE")
  ;;   "ot" '(org-todo :which-key "Toggle state")
  ;;   "oT" '(org-time-stamp :which-key "Time stamp")
  ;;   "og" '(counsel-org-tag :which-key "Tag (counsel)")
  ;;   "oS" '(org-set-tags-command :which-key "Set tags")
  ;;   "oe" '(org-set-effort :which-key "Set effort")
  ;;   "op" '(org-set-property :which-key "Set property")
  ;;   "or" '(org-refile :which-key "Refile")
  ;;   "oO" '(org-open-at-point :which-key "Open link")
  ;; )

  (os/leader-keys
    "f" '(:ignore t :which-key "Fonts")
    "fm" '(variable-pitch-mode :which-key "Variable pitch")
   )

  :bind (:map org-mode-map
    ("C-c <up>" . org-priority-up)
    ("C-c <down>" . org-priority-down)
    ("C-c C-g C-r" . org-shiftmetaright)
  )
  :bind
  ("C-c l" . org-store-link)
  ("C-c a" . org-agenda)
  ("C-c c" . org-capture)
)

;; Center the editor
(defun os/org-mode-visual-fill ()
  (setq visual-fill-column-width 150
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))
(use-package visual-fill-column
  :after org
  :defer t
  :hook (org-mode . os/org-mode-visual-fill))

;; Org-babel structure templates
;; You can use for example =<el TAB= to insert en elisp code block
(use-package org-tempo
  :config
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("cf" . "src conf-unix"))
)

(provide 'config-org)