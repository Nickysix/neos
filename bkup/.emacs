;; _*_ lexical-binding: t; _*_



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

;; * BOOTSTRAP-USE-PACKAGE

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  (package-install 'bind-key)
  (package-install 'diminish))

(require 'use-package)

(customize-set-variable 'use-package-always-ensure t)

(customize-set-variable 'use-package-always-defer t)

(customize-set-variable 'use-package-verbose nil)

(customize-set-variable 'use-package-always-demand t)

;; Make sure Org is installed
(unless (package-installed-p 'org)
  (package-refresh-contents)
  (package-install 'org))

;; Org plus contrib needs to be loaded before any org related functionality is called
(unless (package-installed-p 'org-plus-contrib)
  (package-refresh-contents)
  (package-install 'org-plus-contrib))








;; Break lines automatically in "text" buffers.
(add-hook 'text-mode-hook 'auto-fill-mode)


;; Highlight current line.
(global-hl-line-mode t)


;; Don't create backup~ files.
(setq make-backup-files nil)

;; Don't create #autosave# files.
(setq auto-save-default nil)

;; Don't lock files.
(setq create-lockfiles nil)

(fset 'yes-or-no-p 'y-or-n-p)

;; UTF8 stuff.
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(use-package evil)

(use-package general)

(use-package gruvbox-theme)

(load-theme 'gruvbox)

(use-package jazz)

(use-package suscolors-theme)

(use-package theme-looper
   :config
   (global-set-key (kbd "C-}") 'theme-looper-enable-next-theme)
(global-set-key (kbd "C-{") 'theme-looper-enable-previous-theme)
(global-set-key (kbd "C-\\") 'theme-looper-enable-random-theme)
(global-set-key (kbd "C-|") 'theme-looper-select-theme)
(global-set-key (kbd "C-M-|") 'theme-looper-select-theme-from-all))


(use-package async
  :ensure t
  :commands (async-start))

(use-package cl-lib
  :ensure t)

(use-package dash
  :ensure t)

(use-package s
  :ensure t)


(use-package restart-emacs
  :ensure t
  :bind* (("C-x M-c" . restart-emacs)))


(use-package cus-edit
  :custom
  (custom-file "~/.emacs.d/custom.el")
  :hook (after-init . (lambda ()
                        (unless (file-exists-p custom-file)
                          (write-region "" nil custom-file))
                        (load custom-file))))




(let ((path (expand-file-name "~/.emacs.d/lisp")))
  (if (file-accessible-directory-p path)
      (add-to-list 'load-path path t)))

(use-package flx-ido
  :ensure t
  :defer t)

(use-package ido
  :init
  (setq ido-everywhere t)
  (setq ido-enable-flex-matching t)
  (setq ido-enable-regexp nil)
  (setq ido-enable-prefix nil)
  (setq ido-all-frames nil)
  (setq ido-buffer-disable-smart-matches t)
  (setq ido-completion-buffer "*Ido Completions*")
  (setq ido-completion-buffer-all-completions nil)
  (setq ido-confirm-unique-completion nil)
  (setq ido-create-new-buffer 'prompt)
  (setq ido-default-buffer-method 'selected-window)
  (setq ido-default-file-method 'selected-window)
  (setq ido-enable-last-directory-history t)
  (setq ido-use-filename-at-point nil)
  (setq ido-use-url-at-point nil)
  (setq ido-use-virtual-buffers t)
  (setq ido-use-faces t)
  (setq ido-max-window-height 1)
  (setq ido-decorations
        '(" "
          "   "
          " | "
          " | …"
          "["
          "]"
          " [No match]"
          " [Matched]"
          " [Not readable]"
          " [Too big]"
          " [Confirm]"
          " "
          " "))
  (setq ido-auto-merge-work-directories-length -1)
  :config
  (ido-mode 1)
  :hook
  (minibuffer-setup . (lambda ()
                        (visual-line-mode 1)
                        (setq-local truncate-lines nil)
                        (setq-local resize-mini-windows nil)
                        (setq-local max-mini-window-height 1)))
  :bind (("s-f" . ido-find-file)
         ("s-F" . ido-find-file-other-window)
         ("s-d" . ido-dired)
         ("s-D" . ido-dired-other-window)
         ("s-b" . ido-switch-buffer)
         ("s-B" . ido-switch-buffer-other-window)
         :map ido-common-completion-map
         ("M-e" . ido-edit-input)
         ("M-r" . ido-toggle-regexp)))



(use-package ido-completing-read+
  :ensure t
  :after ido
  :config
  (ido-ubiquitous-mode 1))


(use-package amx
  :ensure t
  :after (ido ido-completing-read+)
  :init
  (setq amx-backend 'ido)
  (setq amx-save-file "~/.emacs.d/amx-items")
  (setq amx-history-length 10)
  (setq amx-show-key-bindings nil)
  :config
  (amx-mode 1))


(use-package icomplete
  :disabled
  :init
  (setq icomplete-show-matches-on-no-input t)
  (setq icomplete-prospects-height 1)
  :config
  (icomplete-mode 1))



(use-package dired
  :custom
  (dired-recursive-copies 'always)
  (dired-recursive-deletes 'always)
  (dired-isearch-filenames 'dwim)
  (delete-by-moving-to-trash t)
  (dired-listing-switches "-AFlv --group-directories-first")
  (dired-dwim-target t)
  :hook
  (dired-mode . dired-hide-details-mode)
  (dired-mode . hl-line-mode)
  :bind (("s-d" . dired)
         ("s-D" . dired-other-window)))

(use-package find-dired
  :after dired
  :custom
  (find-ls-option ;; applies to `find-name-dired'
   '("-ls" . "-AFlv --group-directories-first"))
  (find-name-arg "-iname"))

(use-package async
  :ensure t)

(use-package dired-async
  :after (dired async)
  :config
  (dired-async-mode 1))



(use-package dired-narrow
  :ensure t
  :after dired
  :custom
  (dired-narrow-exit-when-one-left t)
  (dired-narrow-enable-blinking t)
  (dired-narrow-blink-time 0.3)
  :bind (:map dired-mode-map
         ("M-s n" . dired-narrow)))(use-package wdired
  :after dired
  :init
  (setq wdired-allow-to-change-permissions t)
  (setq wdired-create-parent-directories t))



(use-package peep-dired
  :ensure t
  :after dired
  :bind (:map dired-mode-map
              ("P" . peep-dired))
  :custom
  (peep-dired-cleanup-on-disable t)
  (peep-dired-ignored-extensions
   '("mkv" "webm" "mp4" "mp3" "ogg" "iso")))

;; ;; use this for peep always on
;; (setq peep-dired-enable-on-directories t)



(use-package dired-subtree
  :ensure t
  :after dired
  :bind (:map dired-mode-map
              ("<tab>" . dired-subtree-toggle)
              ("<C-tab>" . dired-subtree-cycle)
              ("<S-iso-lefttab>" . dired-subtree-remove)))



(use-package dired-x
  :after dired
  :bind (("C-x C-j" . dired-jump)
         ("s-j" . dired-jump)
         ("C-x 4 C-j" . dired-jump-other-window)
         ("s-J" . dired-jump-other-window))
  :hook
  (dired-mode . (lambda ()
                  (setq dired-clean-confirm-killing-deleted-buffers t))))





(use-package dired-rsync
  :ensure t
  :bind (:map dired-mode-map
              ("r" . dired-rsync)))



(use-package dired-git-info
  :ensure t
  :after dired
  :custom
  (dgi-commit-message-format "%h\t%s\t%cr")
  :bind (:map dired-mode-map
              (")" . dired-git-info-mode)))



(use-package projectile
  :ensure t
  :delight '(:eval (concat " " (projectile-project-name)))
  :init
  (setq projectile-project-search-path '("~/Git/Projects/"))
  (setq projectile-indexing-method 'alien)
  (setq projectile-enable-caching t)
  (setq projectile-completion-system 'ido)
  :config
  (projectile-mode 1)
  :bind (("C-c p" . projectile-command-map)))



(use-package uniquify
  :custom
  (uniquify-buffer-name-style 'post-forward-angle-brackets)
  (uniquify-strip-common-suffix t)
  (uniquify-after-kill-buffer-p t))



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




(use-package window
  :bind (("s-n" . next-buffer)
         ("s-p" . previous-buffer)
         ("s-o" . other-window)
         ("s-2" . split-window-below)
         ("s-3" . split-window-right)
         ("s-0" . delete-window)
         ("s-1" . delete-other-windows)))




(use-package winner
  :hook (after-init . winner-mode)
  :bind (("<s-right>" . winner-redo)
         ("<s-left>" . winner-undo)))



(use-package shell
  :commands (shell shell-command)
  :bind ("<s-return>" . shell))


(use-package term
  :commands term
  :custom
  (term-buffer-maximum-size 9999)
  (term-completion-autolist t)
  (term-completion-recexact t)
  (term-scroll-to-bottom-on-output t))



(use-package proced
  :commands proced
  :custom
  (proced-toggle-auto-update t)
  (proced-auto-update-interval 1)
  (proced-descend t)
  (proced-filter 'user))



(use-package flyspell
  :init
  (setq ispell-program-name "hunspell")
  (setq ispell-local-dictionary "en_GB")
  (setq flyspell-issue-message-flag nil)
  (setq flyspell-issue-welcome-flag nil)
  (setq ispell-local-dictionary-alist
        '(("en_GB"
           "[[:alpha:]]"
           "[^[:alpha:]]"
           "[']"
           nil
           ("-d" "en_GB,el_GR")
           nil
           utf-8)))
  :config
  (define-key flyspell-mode-map (kbd "C-;") nil)
  :hook
  (text-mode . turn-on-flyspell)
  (prog-mode . turn-off-flyspell))


(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-mode))



(use-package dabbrev
  :custom
  (dabbrev-abbrev-char-regexp nil)
  (dabbrev-backward-only nil)
  (dabbrev-case-distinction nil)
  (dabbrev-case-fold-search t)
  (dabbrev-case-replace nil)
  (dabbrev-eliminate-newlines nil)
  (dabbrev-upcase-means-case-search t))

(use-package hippie-exp
  :after dabbrev
  :custom
  (hippie-expand-try-functions-list
   '(try-expand-dabbrev
     try-expand-dabbrev-visible
     try-expand-dabbrev-from-kill
     try-expand-dabbrev-all-buffers
     try-expand-list
     try-expand-list-all-buffers
     try-expand-line
     try-expand-line-all-buffers
     try-complete-file-name-partially
     try-complete-file-name
     try-expand-all-abbrevs))
  (hippie-expand-verbose t)
  :bind ("M-/" . hippie-expand))



(use-package yasnippet
  :disabled
  :ensure t
  
  :init
  (setq yas-snippet-dirs (append yas-snippet-dirs
                                 '("~/.emacs.d/snippets/")))
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :disabled
  :ensure t
  :after yasnippet)


(use-package company
  :disabled
  :ensure t
  :after yasnippet
  :delight
  :init
  (setq company-require-match nil)
  (setq company-tooltip-align-annotations t)
  (setq company-dabbrev-downcase nil)
  (setq company-show-numbers t)
  (setq company-selection-wrap-around t)
  (setq company-auto-complete nil)
  (setq company-minimum-prefix-length 3)
  (setq company-idle-delay 0.5)
  (setq company-tooltip-limit 10)
  (setq company-transformers
        '(company-sort-by-backend-importance
          company-sort-prefer-same-case-prefix
          company-sort-by-occurrence))
  :config
  (global-company-mode 1)
  (defun jcs--company-complete-selection--advice-around (fn)
    "Enable downcase only when completing the completion.  Advice
execute around `company-complete-selection' command."
    (let ((company-dabbrev-downcase t))
      (call-interactively fn)))
  (advice-add 'company-complete-selection :around #'jcs--company-complete-selection--advice-around)

  (defun contrib/company-backend-with-yas (backends)
    "Add :with company-yasnippet to company BACKENDS.
  Taken from https://github.com/syl20bnr/spacemacs/pull/179."
    (if (and (listp backends) (memq 'company-yasnippet backends))
        backends
      (append (if (consp backends)
                  backends
                (list backends))
              '(:with company-yasnippet))))
  ;; add yasnippet to all backends
  (setq company-backends
        (mapcar #'contrib/company-backend-with-yas company-backends))
  :bind (:map company-mode-map
              ("s-/" . company-manual-begin)
              :map company-active-map
              (("s-/" . company-other-backend)
               ("C-d" . company-show-doc-buffer)
               ("<tab>" . company-complete)
               ("<C-tab>" . company-complete-selection)
               ("C-n" . (lambda ()
                          (interactive)
                          (company-complete-common-or-cycle 1)))
               ("C-p" . (lambda ()
                          (interactive)
                          (company-complete-common-or-cycle -1))))))



(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


(use-package paren
  :init
  (setq show-paren-style 'mixed)
  (setq show-paren-when-point-in-periphery t)
  (setq show-paren-when-point-inside-paren nil)
  :config
  (show-paren-mode 1))


(use-package electric
  :init
  (setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)
  (setq electric-pair-pairs '((34 . 34)
                              (8216 . 8217)
                              (8220 . 8221)
                              (171 . 187)))
  (setq electric-pair-skip-self 'electric-pair-default-skip-self)
  (setq electric-quote-context-sensitive t)
  (setq electric-quote-paragraph t)
  (setq electric-quote-string nil)
  :config
  (electric-indent-mode 1)
  (electric-pair-mode 1)
  (electric-quote-mode -1))

;; Smartparens
(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)))




(use-package emacs
  :init
  (setq-default tab-always-indent 'complete)
  (setq-default tab-width 4)
  (setq-default indent-tabs-mode nil))




(use-package emacs
  :custom
  (cursor-type 'box)
  (cursor-in-non-selected-windows 'hollow)
  (x-stretch-cursor nil))



(use-package emacs
  :custom
  (fill-column 72)
  (sentence-end-double-space t)
  (sentence-end-without-period nil)
  (colon-double-space nil)
  :config
  (column-number-mode 1))



(use-package emacs
  :hook (before-save . delete-trailing-whitespace))



(use-package browse-kill-ring
  :ensure t
  :custom
  (browse-kill-ring-highlight-current-entry t)
  (browse-kill-ring-separator "——————")
  (browse-kill-ring-separator-face nil)
  :bind ("C-c y" . browse-kill-ring))




(use-package emacs
  :custom
  (scroll-preserve-screen-position t)
  (scroll-conservatively 1)
  (scroll-margin 0))



(use-package emacs
  :config
  (defun prot/toggle-line-numbers ()
    "Toggles the display of line numbers.  Applies to all buffers."
    (interactive)
    (if (bound-and-true-p display-line-numbers-mode)
        (display-line-numbers-mode -1)
      (display-line-numbers-mode)))

  (defun prot/toggle-invisibles ()
    "Toggles the display of indentation and space characters."
    (interactive)
    (if (bound-and-true-p whitespace-mode)
        (whitespace-mode -1)
      (whitespace-mode)))
  :bind (("C-c l" . prot/toggle-line-numbers)
         ("C-c i" . prot/toggle-invisibles)))




(use-package crux
  :ensure t
  :bind (("C-c w" . crux-duplicate-current-line-or-region)
         ("<C-f2>" . crux-rename-file-and-buffer)
         :map dired-mode-map
         ("<M-return>" . crux-open-with)))



















