

;; treemacs: a tree layout file explorer for Emacs
;; https://github.com/Alexander-Miller/treemacs


(use-package treemacs
  :config
  (progn
    (setq treemacs-follow-after-init t
          treemacs-width 35
          treemacs-indentation 1
          treemacs-follow-after-init t
          treemacs-recenter-after-file-follow nil
          treemacs-collapse-dirs (if (executable-find "python") 3 0)
          treemacs-silent-refresh t
          treemacs-silent-filewatch t
          treemacs-change-root-without-asking t
          treemacs-sorting 'alphabetic-desc
          treemacs-show-hidden-files t
          treemacs-never-persist nil
          treemacs-is-never-other-window t
          treemacs-indentation-string (propertize " ⫶ " 'face 'font-lock-comment-face))

    ;; don't show files in .gitignore
    (setq treemacs-python-executable (executable-find "python3"))
    (add-to-list 'treemacs-pre-file-insert-predicates #'treemacs-is-file-git-ignored?)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null (executable-find "python3"))))
      (`(t . t)
       (treemacs-git-mode 'extended))
      (`(t . _)
       (treemacs-git-mode 'simple))))

  :bind
  (:map global-map
        ([f8] . treemacs)
        ("C-c f" . treemacs-select-window)))

(use-package treemacs-projectile
  :after treemacs projectile
  :bind (:map global-map
              ("C-c o p" . treemacs-projectile)))

(provide 'config-treemacs-1)
