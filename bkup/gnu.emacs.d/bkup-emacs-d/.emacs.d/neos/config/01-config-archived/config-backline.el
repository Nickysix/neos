;; * CONFIG-BACKLINE


(use-package backline
    :after outline
    :config (advice-add 'outline-flag-region :after 'backline-update))




(provide 'config-backline)
