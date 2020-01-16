;;; _*_ lexical-binding: t; _*_


;; * DEFAULT-SETTINGS

(set-frame-parameter nil 'unsplittable t)

(toggle-frame-maximized)

(tool-bar-mode -1)

(scroll-bar-mode -1)

(show-paren-mode 1)

(electric-pair-mode -1)

(global-visual-line-mode t)

(global-font-lock-mode 1)

(global-linum-mode -1)

(global-display-line-numbers-mode)

(global-hl-line-mode 1)

;; * SETQ-VARIABLES

(setq speedbar-directory-unshown-regexp "^\(\.\.*$\)\'")

(setq speedbar-show-unknown-files t)

(setq make-backup-files nil) ;; stop creating those backup~ files

(setq auto-save-default nil)  ;; stop creating those #auto-save# files

(setq linum-format "  %2d  ")

(setq pop-up-swindows nil)

(setq default-major-mode 'text-mode)

;; * SETQ-DEFAULT

(setq-default vc-display-status nil)

(setq-default x-underline-at-descent-line t)

(setq-default enable-recursive-minibuffers t)

(setq-default cursor-type '(bar . 1))

(setq-default word-wrap t)

(setq-default fill-column 200)

(setq-default apropos-do-all t)

(setq-default avy-style 'at-full)

(setq-default blink-matching-delay 0.5)

(setq-default blink-matching-paren 'jump-offscreen)

(setq-default echo-keystrokes 0.1)

(setq-default sentence-end-double-space nil)

(setq-default coding-system-for-read 'utf-8 )

(setq-default coding-system-for-write 'utf-8 )

(setq-default indent-tabs-mode nil)

(setq-default browse-url-browser-function 'browse-url-generic)

(setq-default browse-url-generic-program "google-chrome-stable")

(setq-default auto-fill-function 'do-auto-fill)

(defalias 'yes-or-no-p 'y-or-n-p)


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

 (package-initialize)

 (package-refresh-contents)


  






(global-eldoc-mode 1)



;; * LOAD-PATH-SETTINGS

(push "~/.emacs.d/neos/local" load-path)
(push "~/.emacs.d/neos/config" load-path)
(push "~/.emacs.d/neos/local/eaf" load-path)

;; * BOOTSTRAP-USE-PACKAGE

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  (package-install 'bind-key)
  (package-install 'diminish))

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

;; * CALLS-TO-REQUIRE

(require 'font-lock+)
(require 'lacarte)
(require 'sr-speedbar)
(require 'cl-lib)

(require 'config-diminish)

;;(require 'config-ladicle-isc)
;;(require 'config-isc2)
;;(require 'config-isc1)
(require 'config-ivy-swiper-counsel)

;;(require 'config-ido)
(require 'config-ibuffer)
;;(require 'config-general)
(require 'config-w3m)
(require 'config-treemacs)
(require 'config-dired)

(use-package magit
  :custom
  (magit-auto-revert-mode nil)
  :bind
  ("M-g s" . magit-status))

(use-package hl-line
  :ensure nil
  :hook
  (after-init . global-hl-line-mode))

;; * IMENU-ANYWHERE

(use-package imenu-anywhere)

;; * IMENU-LIST

(use-package imenu-list)

;; * AVY-MODE

(use-package avy)


;; * ACE-LINK

(use-package ace-link)

;; * HYDRA-MODE

(use-package hydra)

;; * EVIL-MODE

(use-package evil
  :demand t
  :init
  (setq evil-want-integration nil)
  :config
  (evil-mode -1))
     
;; * GENERAL

 (use-package general
  :ensure t
  :config
  (general-define-key
  :prefix "C-c"
  ;; bind "C-c a" to 'org-agenda
  "a" 'org-agenda
  "b" 'counsel-bookmark
  "c" 'outshine-cycle-buffer
  "l" 'outline-next-visible-heading
  "k" 'outline-previous-visible-heading))

(general-define-key
 [(shift f12)] 'dot-emacs
 [(shift f5)] 'org-refile
 [f6] 'goto-line
 [f9] 'split-window-vertically
 [(shift f9)] 'split-window-horizontally
 [f10] 'delete-other-windows
 "C-o" 'other-window
 "s-s" 'sr-speedbar-toggle
 "C-x C-i" 'ido-imenu-anywhere)

;; * WHICH-KEY MODE

(use-package which-key
  :defer 2
  :diminish which-key-mode
  :config
  (which-key-mode)
  (which-key-setup-side-window-bottom)
  ;; simple then alphabetic order.
  (setq which-key-sort-order 'which-key-prefix-then-key-order)
  (setq which-key-popup-type 'side-window
        which-key-side-window-max-height 0.5
        which-key-side-window-max-width 0.33
        ;;which-key-idle-delay 0.5
        which-key-min-display-lines 7)) 

;; * KEY-SEQ MODE

(use-package key-seq
  :ensure t
  :after key-chord
  :config
  (key-seq-define-global "ay" #'ivy-switch-buffer)
  (key-seq-define-global "as" #'save-buffer)
  (key-seq-define-global "ap" #'hydra-projectile/body)
  (key-seq-define-global "aj" 'outline-next-visible-heading)
  (key-seq-define-global "ak" 'outline-previous-visible-heading))

;; * KEY-CHORD MODE

(use-package key-chord
  :ensure t
  :init
  (setq key-chord-two-keys-delay 0.2)
  (setq key-chord-one-key-delay 0.3)
  :config
  (key-chord-mode 1))

;; * USE-PACKAGE-CHORDS

(use-package use-package-chords
    :ensure t
    :config
    (key-chord-mode 1))

;; * USEFULL-LIBRARIES

(use-package ag
  :ensure t)

(use-package whitespace-cleanup-mode
  :ensure t
  :config
  (global-whitespace-cleanup-mode))

(use-package format-all
  :ensure t)

(use-package async
  :ensure t
  :commands (async-start))

(use-package cl-lib
  :ensure t)

(use-package dash
  :ensure t)

(use-package s
  :ensure t)

(use-package f
  :ensure t)

(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

(use-package dumb-jump
  :ensure t
  :config (dumb-jump-mode))

(use-package sly
  :ensure t)

(use-package fzf
  :ensure t)

;; * ORG-MODE * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package org

  :ensure org-plus-contrib

  :init
  
  (setq org-use-speed-commands t
        org-return-follows-link t
        org-hide-emphasis-markers t
        org-completion-use-ido t
        org-outline-path-complete-in-steps nil
        org-src-fontify-natively t   ;; Pretty code blocks
        org-src-tab-acts-natively t
        org-confirm-babel-evaluate nil

        org-log-done t
        org-fast-tag-selection-single-key t
        org-use-fast-todo-selection t
        org-startup-truncated nil
        org-enable-priority-commands nil
        org-reverse-note-order t
        
        org-todo-keywords '((sequence "IDEA(i)" "TODO(t)" "STARTED(s)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)")
                            (sequence "|" "CANCELED(c)" "DELEGATED(l)" "SOMEDAY(f)"))
        
        org-todo-keyword-faces '(("IDEA" . (:foreground "GoldenRod" :weight bold))
                                 ("NEXT" . (:foreground "IndianRed1" :weight bold))   
                                 ("STARTED" . (:foreground "OrangeRed" :weight bold))
                                 ("WAITING" . (:foreground "coral" :weight bold)) 
                                 ("CANCELED" . (:foreground "LimeGreen" :weight bold))
                                 ("DELEGATED" . (:foreground "LimeGreen" :weight bold))
                                 ("SOMEDAY" . (:foreground "LimeGreen" :weight bold)))
        
        org-tag-persistent-alist '((:startgroup . nil)
                                   ("HOME" . ?h) 
                                   ("RESEARCH" . ?r)
                                   ("TEACHING" . ?t)
                                   (:endgroup . nil)
                                   (:startgroup . nil)
                                   ("OS" . ?o) 
                                   ("DEV" . ?d)
                                   ("WWW" . ?w)
                                   (:endgroup . nil)
                                   (:startgroup . nil)
                                   ("EASY" . ?e)
                                   ("MEDIUM" . ?m)
                                   ("HARD" . ?a)
                                   (:endgroup . nil)
                                   ("URGENT" . ?u)
                                   ("KEY" . ?k)
                                   ("BONUS" . ?b)
                                   ("noexport" . ?x))
        
        org-tag-faces '(("HOME" . (:foreground "GoldenRod" :weight bold))
                        ("RESEARCH" . (:foreground "GoldenRod" :weight bold))
                        ("TEACHING" . (:foreground "GoldenRod" :weight bold))
                        ("OS" . (:foreground "IndianRed1" :weight bold))   
                        ("DEV" . (:foreground "IndianRed1" :weight bold))   
                        ("WWW" . (:foreground "IndianRed1" :weight bold))
                        ("URGENT" . (:foreground "Red" :weight bold))  
                        ("KEY" . (:foreground "Red" :weight bold))  
                        ("EASY" . (:foreground "OrangeRed" :weight bold))  
                        ("MEDIUM" . (:foreground "OrangeRed" :weight bold))  
                        ("HARD" . (:foreground "OrangeRed" :weight bold))  
                        ("BONUS" . (:foreground "GoldenRod" :weight bold))
                        ("noexport" . (:foreground "LimeGreen" :weight bold)))
        
         org-list-demote-modify-bullet '(("+" . "-")
                                         ("*" . "-")
                                         ("1." . "-")
                                         ("1)" . "a)")))

  :hook ((org-mode . toc-org-enable))

  :config
  
  (setq org-directory "~/.emacs.d/neos/org")

  
  (setq org-agenda-files '("~/.emacs.d/neos/org/refile.org"
                           "~/gtd/gtd.org"
                           "~/gtd/tickler.org"))

  (setq org-capture-templates '(("t" "Todo" entry (file+headline "~/.emacs.d/neos/org/refile.org" "Tasks")
                                 "* TODO %?\nAdded: %U\n" :prepend t :kill-buffer t)
                                ("w" "Web" entry (file+headline "~/www/org/index.org" "Tasks")
                                 "* TODO %?\nAdded: %U\n" :prepend t :kill-buffer t)
                                ("r" "Prog. R" entry (file+headline "~/www/org/teaching/introR.org" "Tasks")
                                 "* TODO %?\nAdded: %U\n" :prepend t :kill-buffer t)
                                ("i" "Idea" entry (file+headline "~/org/mygtd.org" "Someday/Maybe")
                                 "* IDEA %?\nAdded: %U\n" :prepend t :kill-buffer t)
                                ("h" "Home" entry (file+headline "~/org/mygtd.org" "Home")
                                 "* TODO %?\nAdded: %U\n" :prepend t :kill-buffer t)))

  (setq org-refile-targets '(("~/gtd/gtd.org" :maxlevel . 3)
                             ("~/gtd/someday.org" :level . 1)
                             ("~/gtd/tickler.org" :maxlevel . 2)))


  (add-hook 'org-mode-hook
            (lambda ()
              (local-set-key "\M-n" 'outline-next-visible-heading)
              (local-set-key "\M-p" 'outline-previous-visible-heading)
              ;; table
              (local-set-key "\C-\M-w" 'org-table-copy-region)
              (local-set-key "\C-\M-y" 'org-table-paste-rectangle)
              (local-set-key "\C-\M-l" 'org-table-sort-lines)
              ;; display images
              (local-set-key "\M-I" 'org-toggle-iimage-in-org)
              ;; fix tab
              (local-set-key "\C-y" 'yank)))

  ) 


;; end of orgmode configuration ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(use-package simple-httpd
  :ensure t)

(use-package web-server
  :ensure t)

(use-package org-ehtml
  :ensure t)

(use-package org-download
  :ensure t)

(use-package toc-org
  :ensure t)

(use-package outline-toc)

(use-package org-outline-numbering)

(use-package org-bullets
    :ensure t
    :config
    (setq org-bullets-bullet-list '("∙"))
    (add-hook 'org-mode-hook 'org-bullets-mode))

(use-package deft
  :ensure t
  :init
  (setq deft-directory "~/.emacs.d/neos/org")
  (setq deft-recursive t)
  (setq deft-use-filename-as-title t)
  (setq deft-default-extension "org")
  (setq deft-extensions '("org"))
  (setq deft-use-filter-string-for-filename t)
  (setq deft-file-naming-rules '((noslash . "-")
                                 (nospace . "-")
                                 (case-fn . downcase)))
  (setq deft-text-mode 'org-mode)
  (setq deft-org-mode-title-prefix t))

;; * COMPANY-MODE

(use-package company
:ensure t
:init
(setq company-minimum-prefix-length 3)
(setq company-auto-complete nil)
(setq company-idle-delay 0)
(setq company-require-match 'never)
(setq company-frontends
  '(company-pseudo-tooltip-unless-just-one-frontend
    company-preview-frontend
    company-echo-metadata-frontend))
(setq tab-always-indent 'complete)
(defvar completion-at-point-functions-saved nil)
:config
(global-company-mode 1)
(define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
(define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
(define-key company-active-map (kbd "S-TAB") 'company-select-previous)
(define-key company-active-map (kbd "<backtab>") 'company-select-previous)
(define-key company-mode-map [remap indent-for-tab-command] 'company-indent-for-tab-command)
(defun company-indent-for-tab-command (&optional arg)
  (interactive "P")
  (let ((completion-at-point-functions-saved completion-at-point-functions)
        (completion-at-point-functions '(company-complete-common-wrapper)))
        (indent-for-tab-command arg)))

(defun company-complete-common-wrapper ()
        (let ((completion-at-point-functions completion-at-point-functions-saved))
        (company-complete-common))))

(use-package company-lsp
:ensure t
:init
(push 'company-lsp company-backends))

;; * OUTLINE-MINOR-FACES

(use-package outline-minor-faces
  :after outline
  :config (add-hook 'outline-minor-mode-hook
                    'outline-minor-faces-add-font-lock-keywords))



(use-package prog-mode
  :config
  (add-hook 'prog-mode-hook 'outline-minor-mode)
  (add-hook 'prog-mode-hook 'hs-minor-mode))


;; * OUTSHINE-MODE


(use-package outshine
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook 'outshine-mode)
  (add-hook 'prog-mode-hook 'outline-minor-mode))


;; * THEME-SETTINGS


(use-package all-the-icons
  :ensure t)

(use-package mode-icons
  :ensure t
  :config
  (mode-icons-mode))

;; (use-package cycle-themes
;;   :ensure t
;;   :init (setq cycle-themes-theme-list
;;           '(leuven monokai solarized-dark))
;;   :config (cycle-themes-mode))

;; (use-package jazz-theme
;;   :ensure t)

;; (use-package gruvbox-theme
;;   :ensure t)

;; (use-package suscolors-theme
;;   :ensure t)

;; (use-package kaolin-themes
;;   :ensure t)

 (use-package doom-themes
   :ensure t
   :init
   (setq doom-themes-enable-bold t
         doom-themes-enable-italic t)
   :config
   (doom-themes-neotree-config)
   (doom-themes-org-config)
   (load-theme 'doom-one t))

;; (use-package doom-neotree
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

;; (use-package fancy-battery
;;   :after doom-modeline
;;   :hook (after-init . fancy-battery-mode))

;; (use-package solaire-mode
  
;;   :custom (solaire-mode-remap-fringe t)
  
;;   :init
  
;;   ;; brighten buffers (that represent real files)
;;   (add-hook 'after-change-major-mode-hook #'turn-on-solaire-mode)

;;   ;; ...if you use auto-revert-mode:
;;   (add-hook 'after-revert-hook #'turn-on-solaire-mode)

;;   ;; You can do similar with the minibuffer when it is activated:
;;   (add-hook 'minibuffer-setup-hook #'solaire-mode-in-minibuffer)

;;   ;; To enable solaire-mode unconditionally for certain modes:
;;   (add-hook 'ediff-prepare-buffer-hook #'solaire-mode)

;;   :config

;;   (solaire-mode-swap-bg)
;;   (solaire-global-mode +1))



;; * RAINBOW-MODE

(use-package rainbow-mode
    :ensure t
    :config
    (setq rainbow-x-colors nil)
    (add-hook 'prog-mode-hook 'rainbow-mode))


;; * RAINBOW-DELIMITERS

(use-package rainbow-delimiters
    :ensure t
    :config
    (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))


;; * SMARTPARENS-MODE

(use-package smartparens
    :ensure t
    :diminish smartparens-mode
    :diminish smartparens-strict-mode
    :config
    (require 'smartparens-config)
    (smartparens-global-mode)
    (smartparens-global-strict-mode)
    (show-smartparens-global-mode))


;; * RESTART-EMACS


(use-package restart-emacs
  :ensure t
  :bind* (("C-x M-c" . restart-emacs)))


;; * INTERACTIVE-FUNCTIONS


(defun dot-emacs ()
  "dot-emacs you can call via M-x."
  (interactive)
  (find-file "~/.emacs"))

(defun org-refile ()
  "dot-emacs you can call via M-x."
  (interactive)
  (find-file "~/.emacs.d/neos/org/refile.org"))

;;(global-set-key [(shift f5)] 'org-refile)


;; * NEOTREE-MODE


(use-package neotree
  :ensure t
  :bind (("<f8>" . neotree-toggle))
  :init
  (setq neo-window-width 60)
  (setq neo-show-hidden-files t)
  (setq neo-theme 'arrow))


;; * UNDO-TREE


(use-package undo-tree
    :ensure t
    :chords (("uu" . undo-tree-visualize))
    :diminish undo-tree-mode:
    :config
    (global-undo-tree-mode 1))


;; * PROJECTILE-MODE


(use-package projectile
  
  :ensure t
  
  :init
  
  (setq projectile-enable-caching t)
  (setq projectile-completion-system 'ido)
  (setq projectile-keymap-prefix (kbd "C-x p"))
  
  :config
    
  (projectile-global-mode))


;;; ;; * COUNSEL-PROJECTILE


;; (use-package counsel-projectile
;;     :ensure t
;;     :config
;;     (add-hook 'after-init-hook 'counsel-projectile-mode))


;; * YASNIPPET-MODE


(use-package yasnippet
      :ensure t
      :diminish yas-minor-mode
      :config
      (add-to-list 'yas-snippet-dirs "~/.emacs.d/yasnippet-snippets")
      (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
      (yas-global-mode)
      (global-set-key (kbd "M-/") 'company-yasnippet))


;; * CONFIG-HELPFUL


(use-package helpful
  :ensure t
  :config
  (global-set-key (kbd "C-h f") #'helpful-callable)
  (global-set-key (kbd "C-h v") #'helpful-variable)
  (global-set-key (kbd "C-h k") #'helpful-key)
  (global-set-key (kbd "C-c C-d") #'helpful-at-point)
  (global-set-key (kbd "C-h F") #'helpful-function)
  (global-set-key (kbd "C-h C") #'helpful-command))


;; * CONFIG-ELMACRO

(use-package elmacro
  :ensure t
  :config
  (elmacro-mode))


;; * CUSTOM-SET-VARIABLES

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NOTHING-BELOW-THIS-POINT ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ivy-count-format "(%d/%d) ")
 '(ivy-use-virtual-buffers t)
 '(magit-auto-revert-mode nil)
 '(package-selected-packages
   (quote
    (fzf all-the-icons-ivy ivy-rich ido-hacks simple-httpd doom-neotree prog-mode ztree zenburn-theme yasnippet wordnut whitespace-cleanup-mode which-key w3m use-package-chords typescript-mode toc-org tern synosaurus suscolors-theme spinner solaire-mode smex smartparens sly restart-emacs rainbow-mode rainbow-delimiters racket-mode quickref quick-preview pdf-tools outshine outline-toc outline-magic org-plus-contrib org-outline-numbering org-download org-bullets olivetti nyan-mode neotree mode-icons markdown-mode+ lsp-ui key-seq kaolin-themes js2-mode jazz-theme ivy-hydra imenu-list imenu-anywhere ido-vertical-mode ido-grid-mode ido-completing-read+ hyperbole ht helpful gruvbox-theme general format-all flx-ido fancy-battery expand-region evil-vimish-fold evil-org elmacro dumb-jump doom-themes doom-modeline discover-my-major diredfl dired-sidebar dired-ranger dired-rainbow dired-narrow dired-imenu dired-icon dired-filter dired-filetype-face diminish deft darktooth-theme cycle-themes counsel-projectile company-lsp color-theme-modern bicycle backline auto-package-update all-the-icons-dired ag ace-link))))
 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
