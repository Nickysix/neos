(use-package elfeed-org
  :ensure t
  :config
  (progn
    (elfeed-org)
    (setq rmh-elfeed-org-files (list "~/org/website/blogroll.org"))))