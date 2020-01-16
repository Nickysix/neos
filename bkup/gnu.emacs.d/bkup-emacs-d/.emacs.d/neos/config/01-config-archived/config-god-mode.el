(use-package god-mode
  :ensure t
  :init
  (setq god-exempt-major-modes nil)
  (setq god-exempt-predicates nil)
  :config
  (global-set-key (kbd "<escape>") 'god-mode-all))

