;; * OUTLINE-MAGIC


(use-package outline-magic
  :ensure t
  :config
  (add-hook 'outline-mode-hook
            (lambda ()
              (require 'outline-cycle)))

  (add-hook 'outline-minor-mode-hook
            (lambda ()
              (require 'outline-magic)
              (define-key outline-minor-mode-map [(f10)] 'outline-cycle))))
