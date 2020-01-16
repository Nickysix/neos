;; * OUTLINE-MINOR-FACES

(use-package outline-minor-faces
  :ensure t
  :after outline
  :config (add-hook 'outline-minor-mode-hook
                    'outline-minor-faces-add-font-lock-keywords))

