(use-package yatemplate
  :ensure t
  :after yasnippet
  :config

  ;; Define template directory
  (setq yatemplate-dir (concat config-basedir "/third_parties/templates"))

  ;; Coupling with auto-insert
  (setq auto-insert-alist nil)
  (yatemplate-fill-alist)
  ;; (add-hook 'find-file-hook 'auto-insert)
  )
