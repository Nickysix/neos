(use-package aggressive-indent
  :ensure t
  :commands (aggressive-indent-mode)
  :config
  (add-hook 'emacs-lisp-mode-hook 'aggressive-indent-mode))
