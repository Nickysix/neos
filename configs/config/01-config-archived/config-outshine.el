;; * OUTSHINE-MODE

(use-package outshine
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook 'outshine-mode)
  (add-hook 'prog-mode-hook 'outline-minor-mode))

