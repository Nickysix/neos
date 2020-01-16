(use-package color-theme-modern
  :ensure t)

(use-package nimbus-theme
  :ensure t)

;; (use-package kaolin-themes
;;   :ensure t
;;   :config
;;   (load-theme 'kaolin-dark t)
;;   (kaolin-treemacs-theme))

;; (use-package solarized-theme
;;   :ensure t)

;; (use-package color-theme-sanityinc-solarized
;;   :ensure t)

;; (use-package color-theme-sanityinc-tomorrow
;;   :ensure t)

;;(use-package powerline
;; :ensure t
;; :config (powerline-center-evil-theme))

;; (use-package jazz-theme
;;   :ensure t
;;   :config
;;   (load-theme 'jazz t))

;; (use-package gruvbox-theme
;;   :ensure t
;;   :config
;;   (load-theme 'gruvbox t))

;; (use-package doom-themes
;;   :ensure t
;;   :config
;;   (load-theme 'doom-Iosvkem t)
;;   (doom-themes-neotree-config)
;;   (doom-themes-org-config))

;;(use-package doom-neotree
;;  :ensure t
;;  :config
;;  (setq doom-neotree-enable-file-icons t))


(use-package doom-modeline
  :ensure t
  :init
  (progn
    (setq doom-modeline-height 25)
    (setq doom-modeline-bar-width 3)
    (setq doom-modeline-buffer-file-name-style 'truncate-upto-project)
    (setq doom-modeline-icon t)
    (setq doom-modeline-major-mode-icon t)
    (setq doom-modeline-major-mode-color-icon t)
    (setq doom-modeline-minor-modes t)
    (setq doom-modeline-enable-word-count t)
    (setq doom-modeline-checker-simple-format t)
    (setq doom-modeline-persp-name t)
    (setq doom-modeline-lsp t)
    (setq doom-modeline-env-version t))
  :config (doom-modeline-mode 1))

;; (use-package spaceline-config
;;  :ensure spaceline
;;  :pin melpa-stable
;;  :config
;;  (spaceline-emacs-theme))
