(use-package abbrev
  :defer 1
  :ensure nil
  :custom
  (abbrev-file-name (expand-file-name ".abbrev_defs" user-emacs-directory))
  (abbrev-mode 1)
  :config
  (if (file-exists-p abbrev-file-name)
      (quietly-read-abbrev-file)))
