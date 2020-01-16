(use-package eldoc
  :diminish eldoc-mode
  :init
  (add-hook 'emacs-lisp-mode-hook #'eldoc-mode)
  (add-hook 'ielm-mode-hook #'eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook #'eldoc-mode)
  :config
  (setq eldoc-idle-delay 0.1))

(use-package eldoc
  :ensure nil
  :hook ((emacs-lisp-mode . eldoc-mode)
         (eval-expression-minibuffer-setup . eldoc-mode)
         (lisp-mode-interactive-mode . eldoc-mode)
         (typescript-mode . eldoc-mode)
         (haskell-mode . eldoc-mode)
         (python-mode . eldoc-mode)
         (eshell-mode . eldoc-mode)
         (org-mode . eldoc-mode)))

