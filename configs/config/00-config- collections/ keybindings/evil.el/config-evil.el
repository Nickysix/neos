;; * EVIL-MODE

;; (use-package evil-escape
;;   :ensure t
;;   :init
;;   (setq-default evil-escape-delay 0.2)
;;   (setq-default evil-escape-key-sequence "jj")
;;   :config
;;   (evil-escape-mode -1))

;; (use-package evil-leader
;;   :ensure t
;;   :config
;;   (global-evil-leader-mode nil)
;;   ;; more config goes here
;;   )

;; (evil-leader/set-key
;;   "e" 'find-file
;;   "b" 'switch-to-buffer
;;   "k" 'kill-buffer)

(use-package evil
  :ensure t
  :init
  (progn
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil))
  :config
  (evil-mode -1))

;; (use-package evil-collection
;;   :load-path "~/.emacs.d/neos/local/evil-collection/"
;;   :after evil
;;   :config
;;   (evil-collection-init))

;; (use-package evil-collection
;;   :custom (evil-collection-ivy-setu t)g
;;   :init (evil-collection-init))

;; (use-package evil-collection
;;   :custom (evil-collection-company-setup t)
;;   :init (evil-collection-init))

;; (use-package evil-collection
;;   :custom (evil-collection-outline-setup t)
;;   :init (evil-collection-init))

(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package evil-vimish-fold
  :ensure t
  :config
  (evil-vimish-fold-mode -1))
