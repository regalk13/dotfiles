(use-package org-roam
  :config
  (setq org-roam-directory (file-truename "~/notes/org"))
  ;; (setq find-file-visit-truename t) ;; Resolve symlinks
  (org-roam-db-autosync-mode)
)

(use-package org-roam-ui
  :config
  (setq org-roam-ui-sync-theme t)
  (setq org-roam-ui-follow t)
  (setq org-roam-ui-update-on-save t)
  (setq org-roam-ui-open-on-start t)
)

(provide 'config-org-roam)