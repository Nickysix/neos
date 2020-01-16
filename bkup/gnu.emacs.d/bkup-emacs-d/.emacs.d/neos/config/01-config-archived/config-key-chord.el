;; * config-key-chord

(use-package key-chord
  :ensure t
  :init
  (setq key-chord-two-keys-delay 0.2)
  :config
  (key-chord-mode 1))

(provide 'config-key-chord)
