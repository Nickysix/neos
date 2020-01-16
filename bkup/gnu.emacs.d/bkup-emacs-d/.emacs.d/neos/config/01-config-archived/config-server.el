

Make sure EDITOR and/or VISUAL is/are set to emacsclient.



(use-package server
  :config
  (unless (server-running-p) (server-start)))



(use-package server
  :ensure nil
  :hook (after-init . server-mode))
