(use-package evil-collection
  :demand t
  :after evil
  :config
  ;; Make term buffers switch between char and line mode automatically.
  (setq evil-collection-term-sync-state-and-mode-p t)
  (evil-collection-init))
