



(use-package treemacs
  :ensure t
  :after hl-line-mode
  :config
  (setq treemacs-follow-after-init          t
        treemacs-width                      35
        treemacs-indentation                2
        treemacs-git-integration            t
        treemacs-collapse-dirs              3
        treemacs-silent-refresh             nil
        treemacs-change-root-without-asking nil
        treemacs-sorting                    'alphabetic-desc
        treemacs-show-hidden-files          t
        treemacs-never-persist              nil
        treemacs-is-never-other-window      nil
        treemacs-goto-tag-strategy          'refetch-index)

  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  :bind
  (:map global-map
        ([f8]        . treemacs-toggle)))

(use-package treemacs-projectile
  :ensure t
  :after treemacs
  :config
  (setq treemacs-header-function #'treemacs-projectile-create-header))
