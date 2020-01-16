(use-package smart-mode-line)

(use-package smart-mode-line-powerline-theme
  :after (smart-mode-line)
  :config
  (setq sml/theme 'powerline)
  (sml/setup))
