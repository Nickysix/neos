;; * config-ibuffer.el settings


(use-package ibuffer
  :bind ("C-x C-b" . ibuffer)
  :config
  ;; Functions
  (defun ibuffer-group-buffers ()
    (ibuffer-switch-to-saved-filter-groups "Default"))

  ;; Hooks
  (add-hook 'ibuffer-mode-hook #'ibuffer-group-buffers)
  (add-hook 'ibuffer-mode-hook #'ibuffer-auto-mode)

  ;; Variables
  (setq-default ibuffer-saved-filter-groups
                '(("Default"
                   ("Dired" (mode . dired-mode))
                   ("Magit" (name . "\*magit.+*"))
                   ("Org" (mode . org-mode))
                   ("Grep" (name . "\*grep-.*"))
                   ("Temporary" (name . "\*.*\*"))))))


(provide 'config-ibuffer)
