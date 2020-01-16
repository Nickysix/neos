(use-package rainbow-mode
  :hook prog-mode
  :config (setq-default rainbow-x-colors-major-mode-list '()))


(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package rainbow-mode
    :ensure t
    :config
    (setq rainbow-x-colors nil)
    (add-hook 'prog-mode-hook 'rainbow-mode))
