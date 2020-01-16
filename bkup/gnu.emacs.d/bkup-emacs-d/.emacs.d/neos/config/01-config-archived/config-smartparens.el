;; * SMARTPARENS-MODE

(use-package smartparens-config
  :ensure smartparens 
  :config (progn (smartparens-global-mode 1)))

(add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)




(use-package smartparens
  :hook
  (after-init . smartparens-global-mode)
  :config
  (require 'smartparens-config)
  (sp-pair "=" "=" :actions '(wrap))
  (sp-pair "+" "+" :actions '(wrap))
  (sp-pair "<" ">" :actions '(wrap))
  (sp-pair "$" "$" :actions '(wrap)))


(use-package smartparens
    :ensure t
    :diminish smartparens-mode
    :config
    (add-hook 'prog-mode-hook 'smartparens-mode))
