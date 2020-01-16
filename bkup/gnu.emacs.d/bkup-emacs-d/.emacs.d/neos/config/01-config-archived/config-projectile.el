
;; * PROJECTILE-MODE

(use-package projectile
  :ensure t
  :init
  (setq projectile-enable-caching t)
  (setq projectile-completion-system 'ivy)
  :config
  (projectile-global-mode))

;;; * COUNSEL-PROJECTILE

(use-package counsel-projectile
    :ensure t
    :config
    (add-hook 'after-init-hook 'counsel-projectile-mode))



(use-package projectile
  :ensure t
  :hook (after-init . projectile-global-mode)
  :init
  (setq-default
   projectile-cache-file (expand-file-name ".projectile-cache" user-emacs-directory)
   projectile-known-projects-file (expand-file-name ".projectile-bookmarks" user-emacs-directory))
  :config
  (setq-default
   projectile-completion-system 'ido
   projectile-enable-caching t))



(provide 'config-projectile)
