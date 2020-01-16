;;; all dired packages in use


(use-package diredfl
  :ensure t)


(use-package dired-hacks-utils
  :ensure t)


(use-package all-the-icons-dired
  :ensure t)


(use-package dired-icon
  :ensure t)


(use-package treemacs-icons-dired
  :ensure t)


(use-package dired-imenu
  :ensure t)


(use-package dired-atool
  :ensure t)


(use-package dired-efap
  :ensure t)


(use-package dired-filter
  :ensure t)


(use-package dired-toggle
  :ensure t)


(use-package dired-rsync
  :ensure t)


(use-package dired-subtree
  :ensure t)


(use-package peep-dired
  :ensure t)




(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix "__")
  (setq dired-sidebar-theme 'vscode)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))




(provide 'config-dired)
