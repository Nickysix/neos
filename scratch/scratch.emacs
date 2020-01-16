;;; _*_ lexical-binding: t; _*_


;; * STARTUP-OPTIMIZATIONS

;;;; Set garbage collection threshold

;; From https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/

(setq gc-cons-threshold-original gc-cons-threshold)
(setq gc-cons-threshold (* 1024 1024 100))

;;;;;; Set file-name-handler-alist

;; Also from https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/

(setq file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Don’t compact font caches during GC.
(setq inhibit-compacting-font-caches t)


(defun my-minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun my-minibuffer-exit-hook ()
  (setq gc-cons-threshold 800000))

(add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)


;;;;;; Set deferred timer to reset them

(run-with-idle-timer
 5 nil
 (lambda ()
   (setq gc-cons-threshold gc-cons-threshold-original)
   (setq file-name-handler-alist file-name-handler-alist-original)
   (makunbound 'gc-cons-threshold-original)
   (makunbound 'file-name-handler-alist-original)
   (message "gc-cons-threshold and file-name-handler-alist restored")))

;; ;;; Bootstrap
;; ;; Speed up startup
;; (setq gc-cons-threshold 402653184
;;       gc-cons-percentage 0.6)
;; (add-hook 'after-init-hook
;;           `(lambda ()
;;              (setq gc-cons-threshold 800000
;;                    gc-cons-percentage 0.1)
;;              (garbage-collect)) t)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;;(setq inhibit-startup-message t)
;;(setq initial-scratch-message "")

;; * LOAD-PATH 

(push "~/neos/local" load-path)
(push "~/neos/local/sunrise-commander" load-path)
(push "~/neos/config" load-path)
(push "~/neos/cfg" load-path)


;; * PACKAGE-MANAGEMENT

 (require 'package)

 (setq package-enable-at-startup nil)

 (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
 (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
 (add-to-list 'package-archives '("SC"  . "http://joseito.republika.pl/sunrise-commander/") t)
 (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
 (add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/") t)
 (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
 (add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(setq package-check-signature nil)

 (package-initialize)

(package-refresh-contents)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)
(setq use-package-expand-minimally t)


;; * REQUIRE-PACKAGES

(require 'cfg-org)

(require 'cfg-variables)
(require 'cfg-keybindings)
(require 'cfg-company)

;;(require 'cfg-ido)
(require 'cfg-ivy)

(require 'sunrise)
(require 'sunrise-tree)

;; * MAIN-PACKAGES

(use-package diminish
  :ensure t
  :defer t)

(use-package bind-key
  :ensure t
  :defer t)

(use-package jazz-theme
   :ensure t)

(use-package all-the-icons
   :ensure t)

(use-package mode-icons
  :ensure t
  :config
  (mode-icons-mode))

(use-package minions
  :ensure t
  :config (minions-mode 1))

(use-package hydra
  :config
  (use-package hydra-posframe
    :load-path "~/neos/local/hydra-posframe"
    :custom
    (hydra-posframe-parameters
      '((left-fringe . 5)
        (right-fringe . 5)))
    :custom-face
    (hydra-posframe-border-face ((t (:background "#6272a4"))))
    :hook (after-init . hydra-posframe-enable)))

(use-package imenu-anywhere)

(use-package hl-line
  :ensure nil
  :hook
  (after-init . global-hl-line-mode))

(use-package popwin)

(use-package neotree  
  :ensure t
  :bind (("<f8>" . neotree-toggle))
  :init
  (setq neo-window-width 40)
  ;; slow rendering
  (setq inhibit-compacting-font-caches t)

  ;; set icons theme
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))

  ;; Every time when the neotree window is opened, let it find current file and jump to node
  (setq neo-smart-open t)

  ;; When running ‘projectile-switch-project’ (C-c p p), ‘neotree’ will change root automatically
  (setq projectile-switch-project-action 'neotree-projectile-action)

  ;; show hidden files
  (setq-default neo-show-hidden-files t)
  
  :config
  
  (add-hook 'neo-after-create-hook
            (lambda (&rest _)
              (display-line-numbers-mode -1)))

  ;; (add-hook 'neotree-mode-hook
  ;;           (lambda ()
  ;;             (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
  ;;             (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-quick-look)
  ;;             (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
  ;;             (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
  ;;             (define-key evil-normal-state-local-map (kbd "g") 'neotree-refresh)
  ;;             (define-key evil-normal-state-local-map (kbd "n") 'neotree-next-line)
  ;;             (define-key evil-normal-state-local-map (kbd "p") 'neotree-previous-line)
  ;;             (define-key evil-normal-state-local-map (kbd "A") 'neotree-stretch-toggle)
  ;;             (define-key evil-normal-state-local-map (kbd "H") 'neotree-hidden-file-toggle)))

  (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
  (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
  (evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
  (evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
  (evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
  (evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)


  )            


(use-package outshine
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook 'outshine-mode)
  (add-hook 'prog-mode-hook 'outline-minor-mode))


(use-package rainbow-mode
    :ensure t
    :config
    (setq rainbow-x-colors nil)
    (add-hook 'prog-mode-hook 'rainbow-mode))


(use-package rainbow-delimiters
    :ensure t
    :config
    (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))


(use-package smartparens
  :hook
  (after-init . smartparens-global-mode)
  :config
  (require 'smartparens-config)
  (sp-pair "=" "=" :actions '(wrap))
  (sp-pair "+" "+" :actions '(wrap))
  (sp-pair "<" ">" :actions '(wrap))
  (sp-pair "$" "$" :actions '(wrap)))

(use-package projectile
  :ensure t
  :init
  (setq projectile-enable-caching t)
  (setq projectile-completion-system 'ivy)
  :config
  (projectile-global-mode))

(use-package counsel-projectile
    :ensure t
    :config
    (add-hook 'after-init-hook 'counsel-projectile-mode))

(use-package ibuffer
  :custom
  (ibuffer-expert t)
  (ibuffer-display-summary nil)
  (ibuffer-use-other-window nil)
  (ibuffer-deletion-face 'dired-flagged)
  (ibuffer-marked-face 'dired-marked)
  :bind ("C-x C-b" . ibuffer))

(use-package ibuffer-projectile
  :ensure t
  :after (ibuffer projectile)
  :hook
  (ibuffer . (lambda ()
               (ibuffer-projectile-set-filter-groups)
               (unless (eq ibuffer-sorting-mode 'recency)
                 (ibuffer-do-sort-by-recency)))))

(use-package helpful
  :ensure t
  :config
  (global-set-key (kbd "C-h f") #'helpful-callable)
  (global-set-key (kbd "C-h v") #'helpful-variable)
  (global-set-key (kbd "C-h k") #'helpful-key)
  (global-set-key (kbd "C-c C-d") #'helpful-at-point)
  (global-set-key (kbd "C-h F") #'helpful-function)
  (global-set-key (kbd "C-h C") #'helpful-command))

(use-package elmacro
  :ensure t
  :config
  (elmacro-mode))

(use-package restart-emacs
  :ensure t
  :bind* (("C-x M-c" . restart-emacs)))

(use-package undo-tree
  :bind
  ("M-/" . undo-tree-redo)
  :config
  (global-undo-tree-mode))


;; * INTERACTIVE-FUNCTIONS

(defun dot-emacs ()
  "dot-emacs you can call via M-x."
  (interactive)
  (find-file "~/.emacs"))

;;(global-set-key [(shift f12)] 'dot-emacs)

(defun org-refile ()
  "dot-emacs you can call via M-x."
  (interactive)
  (find-file "~/neos/org/refile.org"))

;;(global-set-key [(shift f5)] 'org-refile)



;; * END-OF-CONFIGURATION * 










