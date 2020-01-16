;;; _*_ lexical-binding: t; _*_


;; * DEFAULT-SETTINGS

(setq speedbar-directory-unshown-regexp "^\(\.\.*$\)\'")

(setq speedbar-show-unknown-files t)

(setq make-backup-files nil) ;; stop creating those backup~ files

(setq auto-save-default nil)  ;; stop creating those #auto-save# files

(set-frame-parameter nil 'unsplittable t)

(cua-mode -1)

(tool-bar-mode -1)

(scroll-bar-mode -1)

(toggle-frame-maximized)

(show-paren-mode 1)

(electric-pair-mode -1)

(global-visual-line-mode t)

(global-font-lock-mode 1)

(global-linum-mode 1)

(setq linum-format "  %4d  ")

(setq pop-up-swindows nil)

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

(setq default-major-mode 'text-mode)

(setq-default auto-fill-function 'do-auto-fill)

(defalias 'yes-or-no-p 'y-or-n-p)

;; (add-hook 'before-save-hook 'delete-trailing-whitespace)

;; * GLOBAL-KEYBINDINGS

(global-set-key [f2] 'eval-buffer)

(global-set-key [f6] 'goto-line)

(global-set-key [f7] 'save-buffer)

(global-set-key [f9] 'split-window-vertically)

(global-set-key [(shift f9)] 'split-window-horizontally)

(global-set-key [f10] 'delete-other-windows)

(global-set-key [(shift f10)] 'lacarte-execute-menu-command)

(global-set-key [(shift f12)] 'dot-emacs)

(global-set-key [M-left] 'windmove-left)          ; move to left window

(global-set-key [M-right] 'windmove-right)        ; move to right window

(global-set-key [M-up] 'windmove-up)              ; move to upper window

(global-set-key [M-down] 'windmove-down)          ; move to lower window

(global-set-key (kbd "C-o") 'other-window)

(global-set-key (kbd "C-x o") 'open-line)

;; make cursor movement keys under right hand's home-row.
(global-set-key (kbd "M-h") 'backward-char) ; was indent-new-comment-line

(global-set-key (kbd "M-l") 'forward-char)  ; was downcase-word

(global-set-key (kbd "M-k") 'previous-line) ; was tab-to-tab-stop

(global-set-key (kbd "M-j") 'next-line) ; was kill-sentence

(global-set-key (kbd "M-SPC") 'set-mark-command) ; was just-one-space

(global-set-key (kbd "M-a") 'execute-extended-command) ; was backward-sentence

(global-set-key (kbd "s-s") 'sr-speedbar-toggle)

;; * PACKAGE-MANAGEMENT

(require 'package)

(setq package-enable-at-startup nil)

(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("SC"  . "http://joseito.republika.pl/sunrise-commander/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(package-initialize)

(package-refresh-contents)

(global-eldoc-mode 1)



;; * LOAD-PATH-SETTINGS

(push "~/.emacs.d/neos/local" load-path)
(push "~/.emacs.d/neos/config" load-path)

;; * CALLS-TO-REQUIRE

(require 'font-lock+)
(require 'lacarte)
(require 'sr-speedbar)

;; * BOOTSTRAP-USE-PACKAGE

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

     
;; * GENERAL-DEFINE-KEY

(use-package general
  :ensure t
  :config
  (general-define-key
  :prefix "C-c"
  ;; bind "C-c a" to 'org-agenda
  "a" 'org-agenda
  "b" 'counsel-bookmark
  "c" 'outshine-cycle-buffer))


;; * USEFULL-LIBRARIES

(use-package w3m
  :ensure t)

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

;; * DIMINISH-MODE

(use-package diminish
  :ensure t
  :demand t
  :diminish (visual-line-mode . "ω")
  :diminish hs-minor-mode
  :diminish abbrev-mode
  :diminish auto-fill-function
  :diminish subword-mode)

;; * ORG-MODE

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
        org-todo-keywords '((sequence "TODO(t)" "DOING(g)" "|" "DONE(d)")
                            (sequence "|" "CANCELED(c)")))
  

  :config
  (setq org-directory "~/.emacs.d/neos/org")

  
  (setq org-agenda-files '("~/gtd/inbox.org"
                           "~/gtd/gtd.org"
                           "~/gtd/tickler.org"))

  (setq org-capture-templates '(("t" "Todo [inbox]" entry
                                 (file+headline "~/gtd/inbox.org" "Tasks")
                                 "* TODO %i%?")
                                ("T" "Tickler" entry
                                 (file+headline "~/gtd/tickler.org" "Tickler")
                                 "* %i%? \n %U")))


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
              (local-set-key "\C-y" 'yank))))

;;   (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)"))))


;; (setq org-startup-indented t
;;       org-bullets-bullet-list '(" ") ;; no bullets, needs org-bullets package
;;       org-ellipsis "  " ;; folding symbol
;;       org-pretty-entities t
;;       org-hide-emphasis-markers t
;;       ;; show actually italicized text instead of /italicized text/
;;       org-agenda-block-separator ""
;;       org-fontify-whole-heading-line t
;;       org-fontify-done-headline t
;;       org-fontify-quote-and-verse-blocks t)



(use-package org-download
  :ensure t)

(use-package org-bullets
    :ensure t
    :init
    (add-hook 'org-mode-hook (lambda ()
                               (org-bullets-mode 1))))

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

;; * AVY-MODE

(use-package avy
  :ensure t
  :config
  (global-set-key (kbd "M-g e") 'avy-goto-word-0)
  (global-set-key (kbd "M-g f") 'avy-goto-line)
  (global-set-key (kbd "C-:") 'avy-goto-char)
  (global-set-key (kbd "C-'") 'avy-goto-char-2))

;; * HYDRA-MODE

(use-package hydra
  :ensure t)

;; * HYPERBOLE-MODE

;; * ENGINE-MODE

;; * LISP-PROGRAMING

;;; * EMACS-LISP

(use-package elisp-mode
  :bind (("C-c C-f" . find-function)
         ("C-c C-v" . find-variable)))

;;; * COMMON-LISP

;;; * RACKET-MODE

(use-package racket-mode
  :ensure t)

;; * LSP-MODE

(use-package lsp-mode
  :ensure t
  :init
  (add-hook 'prog-major-mode #'lsp-prog-major-mode-enable))

;;; * LSP-UI

(use-package lsp-ui
  :ensure t
  :init
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

;; * COMPANY-MODE

;; (use-package company
;;   :ensure t
;;   :bind (:map company-active-map
;;          ("C-n" . company-select-next)
;;          ("C-p" . company-select-previous))
;;   :init
;;   (global-company-mode)
;;   :config
;;   (setq company-idle-delay 0) ; Delay to complete
;;   (setq company-minimum-prefix-length 1)
;;   (setq company-selection-wrap-around t)) ; Loops around suggestions

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


;; * QUICKREF-MODE

(use-package quickref
  :ensure t
  :init
  (setq quickref-command-prefix (kbd "C-M-q"))
  :config
  (quickref-global-mode +1))

;; * OUTSHINE-MODE

(use-package outshine
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook 'outshine-mode)
  (add-hook 'prog-mode-hook 'outline-minor-mode))

;; * OUTLINE-MINOR-FACES

(use-package outline-minor-faces
  :ensure t
  :after outline
  :config (add-hook 'outline-minor-mode-hook
                    'outline-minor-faces-add-font-lock-keywords))

;; * OUTLINE-IVY


;; * THEME-SETTINGS


(use-package all-the-icons
  :ensure t)

(use-package mode-icons
  :ensure t
  :config
  (mode-icons-mode))

;;(use-package powerline
;; :ensure t
;; :config (powerline-center-evil-theme))

 (use-package jazz-theme
   :ensure t
   :config
   (load-theme 'jazz t))


;; (use-package color-theme-sanityinc-tomorrow
;;   :ensure t
;;   :config
;;   (load-theme 'sanityinc-tomorrow-bright t))

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

;; (use-package hide-mode-line
;;   :ensure t
;;   :config
;;   (add-hook 'neotree-mode-hook #'hide-mode-line-mode))

;; * IVY-SWIPER-COUNSEL

(use-package smex
  :ensure t)

(use-package counsel
  :ensure t)


(use-package ivy
  :demand
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         :map ivy-minibuffer-map
         ("TAB" . ivy-next-line)
         ("RET" . ivy-alt-done)
         :map ivy-switch-buffer-map
         ("C-d" . ivy-switch-buffer-kill))
  :init
  (setq ivy-initial-inputs-alist nil)

  :config
  (setq ivy-re-builders-alist
        '((t . ivy--regex-ignore-order)))
  (setq ivy-wrap t)
  (ivy-mode 1))

(use-package swiper
  :bind (("M-s" . swiper)))

(use-package ivy-hydra
    :ensure t)

;; * DIRED-MODE

(setq
 delete-by-moving-to-trash          t        ; in dired mode
 dired-auto-revert-buffer           t        ; automatically revert buffer
 dired-clean-up-buffers-too         t        ; kill buffers for deleted files
 dired-dwim-target                  t        ; guess target directory
 dired-keep-marker-copy             nil      ; don't mark copied files
 dired-listing-switches             "-GAlh --group-directories-first"
 dired-recursive-copies             'always  ; don't ask me, just do it
 dired-recursive-deletes            'always  ; ^
 image-dired-show-all-from-dir-max-files 127 ; a bit more
 wdired-allow-to-change-permissions t        ; change permissions with Dired
 ztree-dir-filter-list              nil      ; don't hide anything
 ztree-draw-unicode-lines           t)       ; I like Unicode

(use-package dired-sidebar
  :ensure t)

(use-package dired-filter
  :ensure t)

(use-package dired-narrow
  :ensure t)

(use-package dired-imenu
  :ensure t)

(use-package dired-async
  :ensure nil)

(use-package image-dired
  :ensure nil)

(use-package wdired
  :ensure nil)

(use-package ztree
  :ensure t)

(use-package quick-preview
  :ensure t
  :init
  (global-set-key (kbd "C-c q") 'quick-preview-at-point)
  (define-key dired-mode-map (kbd "Q") 'quick-preview-at-point))

(use-package dired-hacks-utils
  :ensure t)

(use-package dired-ranger
  :ensure t)

(use-package dired-icon
  :ensure t)

(use-package all-the-icons-dired
  :ensure t
  :init
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))


(use-package dired-narrow
  :ensure t
  :bind (:map dired-mode-map
              ("/" . dired-narrow)))

(use-package dired-column
  :ensure nil
  :bind (:package dired
                  :map dired-mode-map
                  ("o" . dired-column-find-file)))

(use-package dired-subtree
  :bind (:package dired
                  :map dired-mode-map
                  ("<tab>" . dired-subtree-toggle)
                  ("TAB" . dired-subtree-toggle)
                  ("<backtab>" . dired-subtree-cycle)))


(use-package dired-x
  :ensure nil
  :hook ((dired-mode . dired-omit-mode)
         (dired-mode . dired-hide-details-mode))
  :bind (("s-\\" . dired-jump-other-window)
         :package dired
         :map dired-mode-map
         (")" . dired-omit-mode)))


(use-package diredfl
  :ensure t
  :config
  (diredfl-global-mode))

(use-package dired-filetype-face
  :ensure t)

(use-package dired-rainbow
  :ensure t
  :config
  (progn
    (dired-rainbow-define-chmod directory "#6cb2eb" "d.*")
    (dired-rainbow-define html "#eb5286" ("css" "less" "sass" "scss" "htm" "html" "jhtm" "mht" "eml" "mustache" "xhtml"))
    (dired-rainbow-define xml "#f2d024" ("xml" "xsd" "xsl" "xslt" "wsdl" "bib" "json" "msg" "pgn" "rss" "yaml" "yml" "rdata"))
    (dired-rainbow-define document "#9561e2" ("docm" "doc" "docx" "odb" "odt" "pdb" "pdf" "ps" "rtf" "djvu" "epub" "odp" "ppt" "pptx"))
    (dired-rainbow-define markdown "#ffed4a" ("org" "etx" "info" "markdown" "md" "mkd" "nfo" "pod" "rst" "tex" "textfile" "txt"))
    (dired-rainbow-define database "#6574cd" ("xlsx" "xls" "csv" "accdb" "db" "mdb" "sqlite" "nc"))
    (dired-rainbow-define media "#de751f" ("mp3" "mp4" "MP3" "MP4" "avi" "mpeg" "mpg" "flv" "ogg" "mov" "mid" "midi" "wav" "aiff" "flac"))
    (dired-rainbow-define image "#f66d9b" ("tiff" "tif" "cdr" "gif" "ico" "jpeg" "jpg" "png" "psd" "eps" "svg"))
    (dired-rainbow-define log "#c17d11" ("log"))
    (dired-rainbow-define shell "#f6993f" ("awk" "bash" "bat" "sed" "sh" "zsh" "vim"))
    (dired-rainbow-define interpreted "#38c172" ("py" "ipynb" "rb" "pl" "t" "msql" "mysql" "pgsql" "sql" "r" "clj" "cljs" "scala" "js"))
    (dired-rainbow-define compiled "#4dc0b5" ("asm" "cl" "lisp" "el" "c" "h" "c++" "h++" "hpp" "hxx" "m" "cc" "cs" "cp" "cpp" "go" "f" "for" "ftn" "f90" "f95" "f03" "f08" "s" "rs" "hi" "hs" "pyc" ".java"))
    (dired-rainbow-define executable "#8cc4ff" ("exe" "msi"))
    (dired-rainbow-define compressed "#51d88a" ("7z" "zip" "bz2" "tgz" "txz" "gz" "xz" "z" "Z" "jar" "war" "ear" "rar" "sar" "xpi" "apk" "xz" "tar"))
    (dired-rainbow-define packaged "#faad63" ("deb" "rpm" "apk" "jad" "jar" "cab" "pak" "pk3" "vdf" "vpk" "bsp"))
    (dired-rainbow-define encrypted "#ffed4a" ("gpg" "pgp" "asc" "bfe" "enc" "signature" "sig" "p12" "pem"))
    (dired-rainbow-define fonts "#6cb2eb" ("afm" "fon" "fnt" "pfb" "pfm" "ttf" "otf"))
    (dired-rainbow-define partition "#e3342f" ("dmg" "iso" "bin" "nrg" "qcow" "toast" "vcd" "vmdk" "bak"))
    (dired-rainbow-define vc "#0074d9" ("git" "gitignore" "gitattributes" "gitmodules"))
    (dired-rainbow-define-chmod executable-unix "#38c172" "-.*x.*")
    ))

;; * RAINBOW-DELIMITERS

(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode))

;; * SMARTPARENS-MODE

(use-package smartparens-config
  :ensure smartparens 
  :config (progn (smartparens-global-mode 1)))

(add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)

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

(global-set-key [(shift f5)] 'org-refile)

;; * NEOTREE-MODE

(use-package neotree
  :ensure t
  :bind (("<f8>" . neotree-toggle))
  :init
  (setq neo-window-width 40)
  (setq neo-show-hidden-files t)
  (setq neo-theme 'arrow))

;; (add-hook 'neotree-mode-hook
;;               (lambda ()
;;                 (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
;;                 (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-quick-look)
;;                 (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
;;                 (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
;;                 (define-key evil-normal-state-local-map (kbd "g") 'neotree-refresh)
;;                 (define-key evil-normal-state-local-map (kbd "n") 'neotree-next-line)
;;                 (define-key evil-normal-state-local-map (kbd "p") 'neotree-previous-line)
;;                 (define-key evil-normal-state-local-map (kbd "A") 'neotree-stretch-toggle)
;;                 (define-key evil-normal-state-local-map (kbd "H") 'neotree-hidden-file-toggle)))


 (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
    (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
    (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
    (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
    (evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
    (evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
    (evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
    (evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
    (evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)


;; * WHICH-KEY-MODE

(use-package which-key
  :ensure t
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode))

;; * USE-PACKAGE-CHORDS

(use-package use-package-chords
    :ensure t
    :config
    (key-chord-mode 1))

;; * UNDO-TREE

(use-package undo-tree
    :ensure t
    :chords (("uu" . undo-tree-visualize))
    :diminish undo-tree-mode:
    :config
    (global-undo-tree-mode 1))

;; * NYAN-MODE

(use-package nyan-mode
  :ensure t)

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

;; * YASNIPPET-MODE

(use-package yasnippet
      :ensure t
      :diminish yas-minor-mode
      :config
      (add-to-list 'yas-snippet-dirs "~/.emacs.d/yasnippet-snippets")
      (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
      (yas-global-mode)
      (global-set-key (kbd "M-/") 'company-yasnippet))

;; * DUMB-JUMP-MODE

(use-package dumb-jump
  :ensure t
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g b" . dumb-jump-back)
         ("M-g q" . dumb-jump-quick-look)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config (setq dumb-jump-selector 'ivy))

(defhydra dumb-jump-hydra (:color blue :columns 3)
    "Dumb Jump"
    ("j" dumb-jump-go "Go")
    ("o" dumb-jump-go-other-window "Other window")
    ("e" dumb-jump-go-prefer-external "Go external")
    ("x" dumb-jump-go-prefer-external-other-window "Go external other window")
    ("i" dumb-jump-go-prompt "Prompt")
    ("l" dumb-jump-quick-look "Quick look")
    ("b" dumb-jump-back "Back"))

;; * DISCOVER-MY-MAJOR

(use-package discover-my-major
  :ensure t
  :bind (("C-h C-m" . discover-my-major)
         ("C-h M-m" . discover-my-mode)))

;; * JAVASCRIPT-SETTINGS

(use-package js2-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

(use-package tern :ensure t)

(use-package typescript-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode)))

;; LSP for JavaScript and TypeScript
;;(use-package lsp-javascript-typescript
;;  :ensure t
;;  :init
 ;;  (add-to-list 'js-mode-hook #'lsp-javascript-typescript-enable)
;;  (add-to-list 'typescript-mode-hook #'lsp-javascript-typescript-enable))

;; * CONFIG-PDF-TOOLS

;;; * PDF-TOOLS

(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page)
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward))

;;; * PDF-VIEW-SETTINGS

(use-package pdf-view
  :ensure nil
  :after pdf-tools
  :bind (:map pdf-view-mode-map
        ("C-s" . isearch-forward))
  :custom (pdf-view-use-unicode-ligther nil))

;;; * DOC-VIEW-SETTINGS

(use-package doc-view
  :init
  (setq doc-view-resolution 200))
;; * CONFIG-WRITING

(setq sentence-end-double-space nil)

(add-hook 'text-mode-hook 'flyspell-mode)

;; Thesaurus
;; Many of the thesaurus packages use an online service,
;; synosaurus gives you the option of using a local Wordnet install.
;; It also has a nice 'replace word' interface.

;; NOTE: this requires you to install wordnet

(use-package synosaurus
  :ensure t
  :after wordnut
  :config (progn
            (setq synosaurus-backend 'synosaurus-backend-wordnet)
            (setq synosaurus-choose-method 'default)))

;; Dictionary
;; Since I already use a local Wordnet as a thesaurus,
;; I'm using it for a dictionary as well via the wordnut package.

(use-package wordnut
  :ensure t)

;; A minor mode for a nice writing environment.

(use-package olivetti
  :ensure t
  :config (setq olivetti-body-width 90)) 



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

;; * CONFIG-MARKDOWN

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package markdown-mode+
  :ensure t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NOTHING-BELOW-THIS-POINT ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (jazz)))
 '(custom-safe-themes
   (quote
    ("eb7be1648009af366d83f855191057bdc09348a2d9353db31da03b1cdec50cc5" default)))
 '(package-selected-packages
   (quote
    (w3m pdf-tools typescript-mode tern js2-mode discover-my-major dumb-jump yasnippet counsel-projectile projectile nyan-mode use-package-chords which-key neotree restart-emacs smartparens rainbow-delimiters dired-rainbow dired-filetype-face diredfl all-the-icons-dired dired-icon dired-ranger quick-preview ztree dired-imenu dired-narrow dired-filter dired-sidebar ivy-hydra counsel smex doom-modeline jazz-theme mode-icons all-the-icons outline-minor-faces outshine quickref company-lsp company lsp-ui lsp-mode racket-mode hydra avy whitespace-cleanup-mode use-package org-plus-contrib org-download org-bullets general format-all expand-region evil-vimish-fold evil-org diminish deft ag)))
 '(pdf-view-use-unicode-ligther nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
