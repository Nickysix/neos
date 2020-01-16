;; -*- lexical-binding: t -*-


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
(push "~/neos/local/git/sunrise-commander" load-path)
(push "~/neos/configs/config" load-path)
(push "~/neos/configs/cfg" load-path)

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

;; * USE-PACKAGE

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)
(setq use-package-expand-minimally t)

(unless (package-installed-p 'hyperbole)
        (package-refresh-contents)
        (package-install 'hyperbole))
      (require 'hyperbole)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (require 'package)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.org/packages/"))
  (package-refresh-contents)
  (package-initialize)
  (package-install 'el-get)
  (require 'el-get))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

;; Start server
(use-package server
  :ensure nil
  :hook (after-init . server-mode))

;; * REQUIRE-PACKAGES

(require 'cfg-org)

(require 'menu-bar+)

(require 'lacarte)

(require 'cfg-neotree)
(require 'cfg-treemacs)
;;(require 'cfg-sidebar)

(require 'cfg-variables)
(require 'cfg-keybindings)
(require 'cfg-company)

;;(require 'cfg-ido)
(require 'cfg-ivy)
(require 'cfg-dired)

;; * MAIN-PACKAGES

(use-package cl-libify
  :ensure t)

(use-package diminish
  :ensure t
  :defer t)

(use-package bind-key
  :ensure t
  :defer t)

(use-package async
  :ensure t
  :commands (async-start))

(use-package dash
  :ensure t)

(use-package s
  :ensure t)

(use-package f
  :ensure t)

(use-package fzf
  :ensure t)

(use-package direx
  :ensure t
  :defer t)

(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

(use-package dumb-jump
  :ensure t
  :config (dumb-jump-mode))

(use-package ag
  :ensure t)

(use-package whitespace-cleanup-mode
  :ensure t
  :config
  (global-whitespace-cleanup-mode))

(use-package format-all
  :ensure t)

(use-package drag-stuff
  :ensure t
  :config
  (drag-stuff-global-mode 1)) 

(use-package move-text
  :ensure t
  :config
  (move-text-default-bindings)) ;; M-up M-down M-left M-right

(use-package jazz-theme
  :ensure t)

(use-package zenburn-theme
  :disabled
  :ensure t
  :config
  (load-theme 'zenburn t))

(use-package all-the-icons
   :ensure t)

(use-package mode-icons
  :ensure t
  :config
  (mode-icons-mode))

(use-package minions
  :ensure t
  :config (minions-mode 1))

(use-package smart-mode-line
  :disabled
  :ensure t
  :config (sml/setup))

(use-package mood-line
  :disabled
  :ensure t
  :config
  (mood-line-mode))

(use-package hydra
  :config
  (use-package hydra-posframe
    :load-path "~/neos/local/git/hydra-posframe"
    :custom
    (hydra-posframe-parameters
      '((left-fringe . 5)
        (right-fringe . 5)))
    :custom-face
    (hydra-posframe-border-face ((t (:background "#6272a4"))))
    :hook (after-init . hydra-posframe-enable)))

(use-package aweshell
  :load-path "~/neos/local/git/aweshell"
  :config
  (require 'eshell-did-you-mean)
  (require 'eshell-prompt-extras)
  (require 'eshell-up)
  (require 'exec-path-from-shell))

(use-package awesome-tab
  :disabled
  :load-path "~/neos/local/git/awesome-tab"
  :config
  (awesome-tab-mode t))

(use-package centaur-tabs
  :load-path "~/.emacs.d/tabs/centaur-tabs"
  :config
  (centaur-tabs-mode t)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))

(use-package hl-line
  :ensure nil
  :hook
  (after-init . global-hl-line-mode))

(use-package highlight-indent-guides
  :ensure t
  :init
  (setq highlight-indent-guides-method 'character)
  :config
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))

(use-package popwin)

(use-package pandoc-mode)

(use-package imenu-anywhere)

(use-package imenu-list)

(use-package outshine
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook 'outshine-mode)
  (add-hook 'prog-mode-hook 'outline-minor-mode))

(use-package outline-toc
  :ensure t)

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

(use-package highlight-parentheses
  :ensure t
  :diminish highlight-parentheses-mode
  :config
  (add-hook 'emacs-lisp-mode-hook
            (lambda()
              (highlight-parentheses-mode)
              )))

 

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

;; * PKG: RESTART-EMACS

(use-package restart-emacs
  :ensure t
  :bind* (("C-x M-c" . restart-emacs)))

;; * PKG: UNDO-TREE

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

(general-define-key
 [(shift f12)] 'dot-emacs)

(defun org-refile ()
  "dot-emacs you can call via M-x."
  (interactive)
  (find-file "~/neos/org/refile.org"))

;;(global-set-key [(shift f5)] 'org-refile)

(general-define-key
 [(shift f10)] 'org-refile)

(defun cfg-org ()
  "org configuration file."
  (interactive)
  (find-file "~/neos/configs/cfg/cfg-org.el"))

(general-define-key
 [(shift f11)] 'cfg-org)

(defun cfg-keybindings ()
  "keybindings configuration file."
  (interactive)
  (find-file "~/neos/configs/cfg/cfg-keybindings.el"))

(general-define-key
 [(shift f9)] 'cfg-keybindings)

(defun indent-defun ()
  "Indent the current defun."
  (interactive)
  (save-restriction
    (widen)
    (narrow-to-defun)
    (indent-buffer)))



(defun indent-current-sexp ()
"Indent current sexp."
(interactive)
(save-excursion
(end-of-defun)
(let ((end (point)))
(beginning-of-defun)
;; indent sexp
(indent-sexp nil)
;; loop through every line checking for eol comments
(while (< (point) end)
(goto-char (point-at-eol))
;; if comment exists, indent it
(when (eq (get-text-property (point) 'face) 'font-lock-comment-face)
(comment-indent))
(forward-line 1)))))


(defun er-indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indented selected region."))
      (progn
        (er-indent-buffer)
        (message "Indented buffer.")))))


;;(global-set-key (kbd "C-M-\\") #'er-indent-region-or-buffer)

(general-define-key
 "C-M-\\" #'er-indent-region-or-buffer)


;;
;; Window &amp; Frame Switching with WindMove and FrameMove
;;
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
 
;; Remap windmove keys to home keys
(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-j") 'windmove-down)
(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-l") 'windmove-right)
 
(require 'framemove)
    (windmove-default-keybindings)
    (setq framemove-hook-into-windmove t) ;;Hook framemove into windmove keys
;; Common lisp stuff to fix windmove/framemove 
(require 'cl) ;;used to Fix error if theres an error with above code
;;
;; End of Windmove &amp; Framemove setup
;;


(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)
(global-set-key (kbd "<s-return>") 'ansi-term)


(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 10)))
  (setq dashboard-banner-logo-title "Hello Kuba!"))



(use-package dmenu
  :ensure t
  :bind
  ("s-SPC" . 'dmenu))










;; * END-OF-CONFIGURATION * 










