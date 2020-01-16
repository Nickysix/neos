(ac-config-default)



(use-package auto-complete
  :diminish auto-complete-mode
  :init
  (setq ac-modes (remove 'org-mode ac-modes))
  (ac-config-default))



(use-package auto-complete-config
    :defer 2
    :bind (:map ac-mode-map
                ("M-<tab>" . auto-complete))
    :init
    (setq ac-auto-start nil
          ac-quick-help-delay 0.5)
    :config
    (global-auto-complete-mode t))



(use-package auto-complete-config
  :ensure auto-complete
  :bind ("M-<tab>" . my--auto-complete)
  :init
  (defun my--auto-complete ()
    (interactive)
    (unless (boundp 'auto-complete-mode)
      (global-auto-complete-mode 1))
    (auto-complete))
  )



(use-package auto-complete
:ensure t
:init
(progn
(ac-config-default)
(global-auto-complete-mode t)
))



(require-package 'auto-complete)
(require 'auto-complete-config)
    (setq ac-auto-show-menu t
          ac-auto-start t
          ac-quick-help-delay 0.3
          ac-quick-help-height 30
          ac-show-menu-immediately-on-auto-complete t)
    (ac-config-default)

    (after 'yasnippet
      (add-hook 'yas-before-expand-snippet-hook (lambda () (auto-complete-mode -1)))
      (add-hook 'yas-after-exit-snippet-hook (lambda () (auto-complete-mode t)))
      (defadvice ac-expand (before advice-for-ac-expand activate)
        (when (yas-expand)
          (ac-stop))))

(provide 'init-autocomplete)
