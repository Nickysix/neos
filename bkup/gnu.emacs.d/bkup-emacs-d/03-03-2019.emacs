

;; * Package * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)

(setq package-enable-at-startup nil)

(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/")t)
(add-to-list 'package-archives '("SC"  . "http://joseito.republika.pl/sunrise-commander/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; Initialize the emacs packaging system

(package-initialize)


;; * Quelpa-Mode * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Bootstrap quelpa

(if (require 'quelpa nil t)
    (quelpa-self-upgrade)
  (with-temp-buffer
    (url-insert-file-contents
     "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
    (eval-buffer)))

;; Make Quelpa prefer MELPA-stable over melpa. This is optional but
;; highly recommended.
;;
;; (setq quelpa-stable-p t)

;; Install quelpa-use-package, which will install use-package as well

(quelpa
 '(quelpa-use-package
   :fetcher github
   :repo "quelpa/quelpa-use-package"
   :stable nil))
(require 'quelpa-use-package)

;;; How to use this config:
;;
;; This will only go over how to use Quelpa and use-package together.
;; I recommend reading the use-package documentation at
;; https://github.com/jwiegley/use-package at a minimum, as it
;; provides an excellent and easy to understand way to structure your
;; config. If you want more control over package installation, you can
;; also check out the Quelpa documentation at
;; https://github.com/quelpa/quelpa
;;
;; To install a package from MELPA, add a use-package form to your
;; config. For example, if you want to install "fsbot-data-browser"
;; from MELPA, you would add this line:
;;
;; (use-package fsbot-data-browser :quelpa)
;;
;; If you used the (setq quelpa-stable-p t) line above, then packages
;; without a stable version will fail to install. (You can check by
;; searching for the package at https://stable.MELPA.org) For example,
;; the "gruvbox-theme" package has no stable version. You can install
;; packages like these with a line like the following:
;;
;; (use-package gruvbox-theme :quelpa (:stable nil))
;;
;; You can actually pass any of the Quelpa options in that form. For
;; example, to install something like ac-php that isn't on MELPA at
;; all, you could add a line like this:
;;
;; (use-package ac-php :quelpa
;;   (:stable nil :fetcher github :repo "xcwen/ac-php"
;;    :files ("ac-php.el" "company-php.el")))

;; That's all! I hope this example was helpful to you.


;; * Use-package * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(unless (package-installed-p 'use-package)
;;  (package-refresh-contents)
;;  (package-install 'use-package))

;;(use-package quelpa-use-package
;;    :ensure t
;;    :init
;;    (setq quelpa-update-melpa-p nil))


;; * flx * fuzzy * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package flx
  :ensure t)


(use-package fuzzy
   :ensure t)


;; * Environment Settings * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(cua-mode 1)

(global-visual-line-mode t)

(setq-default fill-column 40)

(show-paren-mode 1)
(electric-pair-mode 1)
(global-visual-line-mode t)
;;(setq-default auto-fill-function 'do-auto-fill)
(global-font-lock-mode 1)
(global-linum-mode 1)
(setq linum-format "  %4d  ")
;;(toggle-frame-maximized)
(tool-bar-mode -1)
(scroll-bar-mode 1)
(setq-default word-wrap t)
(setq-default fill-column 80)
(setq pop-up-windows nil)
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

;; Open unidentified files in text mode
(setq default-major-mode 'text-mode)


;; * Global-Set-Key * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key [f2] 'eval-buffer)

(global-set-key [f1] 'goto-line)
 
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


;; * Hydra-Mode * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package hydra :ensure t)

(global-set-key
 (kbd "C-z")
 (defhydra hydra-vi ()
   "vi"
   ("l" forward-char)
   ("h" backward-char)
   ("j" next-line)
   ("k" previous-line)))

(use-package origami
  :ensure quelpa
  :quelpa (origami :repo "seblemaguer/origami.el" :fetcher github)
  :custom
  (origami-show-fold-header t)

  :custom-face
  (origami-fold-replacement-face ((t (:inherit magit-diff-context-highlight))))
  (origami-fold-fringe-face ((t (:inherit magit-diff-context-highlight))))

  :init
  (defhydra origami-hydra (:color blue :hint none)
    "
      _:_: recursively toggle node       _a_: toggle all nodes    _t_: toggle node
      _o_: show only current node        _u_: undo                _r_: redo
      _R_: reset
      "
    (":" origami-recursively-toggle-node)
    ("a" origami-toggle-all-nodes)
    ("t" origami-toggle-node)
    ("o" origami-show-only-node)
    ("u" origami-undo)
    ("r" origami-redo)
    ("R" origami-reset))

  :bind (:map origami-mode-map
              ("C-:" . origami-hydra/body))
  :config
  (face-spec-reset-face 'origami-fold-header-face))



 (use-package fzf
    :ensure t)



(use-package eldoc
  :diminish eldoc-mode
  :init
  (add-hook 'emacs-lisp-mode-hook #'eldoc-mode)
  (add-hook 'ielm-mode-hook #'eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook #'eldoc-mode)
  :config
  (setq eldoc-idle-delay 0.1))

(use-package eldoc
  :ensure nil
  :hook ((emacs-lisp-mode . eldoc-mode)
         (eval-expression-minibuffer-setup . eldoc-mode)
         (lisp-mode-interactive-mode . eldoc-mode)
         (typescript-mode . eldoc-mode)
         (haskell-mode . eldoc-mode)
         (python-mode . eldoc-mode)
         (eshell-mode . eldoc-mode)
         (org-mode . eldoc-mode)))

         
;; * Company-Mode * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Completion ignores filenames ending in any string in this list.
(setq completion-ignored-extensions
      '(".o" ".elc" "~" ".bin" ".class" ".exe" ".ps" ".abs" ".mx"
        ".~jv" ".rbc" ".pyc" ".beam" ".aux" ".out" ".pdf" ".hbc"))

(use-package company
  :ensure t
  :init
  ;; (add-hook 'prog-mode-hook 'company-mode)
  ;; (add-hook 'comint-mode-hook 'company-mode)
  :config
  (global-company-mode)
  (setq company-tooltip-limit 10)
  (setq company-dabbrev-downcase 0)
  (setq company-idle-delay 0)
  (setq company-echo-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-require-match nil)
  (setq company-selection-wrap-around t)
  (setq company-tooltip-align-annotations t)
  ;; (setq company-tooltip-flip-when-above t)
  (setq company-transformers '(company-sort-by-occurrence)) ; weight by frequency
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
  (define-key company-active-map (kbd "<backtab>") 'company-select-previous)


;; * Company-Box * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; needs emacs version 26 or greater to work.

;;(use-package company-box
;;  :hook (company-mode . company-box-mode))

;; * Company-Flx-Mode * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(with-eval-after-load 'company
      (company-flx-mode +1))
      
      
(setq company-dict-dir (concat user-emacs-directory "dict/"))      
(add-to-list 'company-backends 'company-dict)
       
(use-package company-quickhelp
  :ensure t
  :after company
  :config
  (company-quickhelp-mode 1))

 
  ;; Python auto completion
  (use-package company-jedi
    :defer t
    :init
    (setq company-jedi-python-bin "python2")
    :config
    (add-to-list 'company-backends 'company-jedi))

  ;; HTML completion
  (use-package company-web
    :ensure t
    :bind (("C-c w" . company-web-html))
    :config
    (add-to-list 'company-backends 'company-web-html))

  (use-package company-statistics
    :ensure t
    :config
    (add-hook 'after-init-hook 'company-statistics-mode))

  ;; (use-package company-ansible
  ;;   :defer t
  ;;   :config
  ;;   (add-to-list 'company-backends 'company-ansible))
  )

;;(company-quickhelp-mode 1)

(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (require 'company-elisp)
             (push 'company-elisp company-backends)))
             
(setq company-dabbrev-downcase nil)             
             

(defun ora-company-number ()
  "Forward to `company-complete-number'.

Unless the number is potentially part of the candidate.
In that case, insert the number."
  (interactive)
  (let* ((k (this-command-keys))
         (re (concat "^" company-prefix k)))
    (if (cl-find-if (lambda (s) (string-match re s))
                    company-candidates)
        (self-insert-command 1)
      (company-complete-number (string-to-number k)))))
      
      
(let ((map company-active-map))
  (mapc
   (lambda (x)
     (define-key map (format "%d" x) 'ora-company-number))
   (number-sequence 0 9))
  (define-key map " " (lambda ()
                        (interactive)
                        (company-abort)
                        (self-insert-command 1)))
  (define-key map (kbd "<return>") nil))


;; * Elisp-Mode * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(add-hook 'emacs-lisp-mode-hook 'ielm-auto-complete)

;;(use-package outlined-elisp-mode
;;  :ensure t)    

(use-package eldoc
  :init (add-hook 'emacs-lisp-mode-hook 'eldoc-mode))

(abbrev-mode 1)

(define-abbrev-table 'emacs-lisp-mode-abbrev-table
  '(("sm" "string-match") ("mm" "major-mode")
    ("rb" "region-beginning") ("ca" "char-after")
    ("smd" "save-match-data") ("mb" "match-beginning")
    ("pm" "point-min") ("ir" "indent-region")
    ("sf" "search-forward") ("ci" "call-interactively")
    ("sn" "symbol-name") ("se" "save-excursion")
    ("scb" "skip-chars-backward") ("fc" "forward-char")
    ("ff" "find-file") ("fs" "forward-sexp")
    ("pa" "prefix-arg") ("re" "region-end")
    ("dc" "delete-char") ("ms" "match-string")
    ("tc" "this-command") ("dd" "default-directory")
    ("bc" "backward-char") ("rsf" "re-search-forward")
    ("snp" "substring-no-properties")
    ("bsnp" "buffer-substring-no-properties")
    ("lep" "line-end-position") ("bs" "buffer-substring")
    ("cc" "condition-case") ("ul" "up-list")
    ("bfn" "buffer-file-name") ("lb" "looking-back")
    ("tap" "thing-at-point") ("rm" "replace-match")
    ("fl" "forward-line") ("df" "declare-function")
    ("ntr" "narrow-to-region") ("dr" "delete-region")
    ("rsb" "re-search-backward") ("scf" "skip-chars-forward")
    ("wcb" "with-current-buffer") ("ie" "ignore-errors")
    ("gc" "goto-char") ("jos" "just-one-space")
    ("la" "looking-at") ("ow" "other-window")
    ("dk" "define-key") ("dm" "deactivate-mark")
    ("bod" "beginning-of-defun") ("sic" "self-insert-command")
    ("eol" "end-of-line") ("me" "match-end")
    ("nai" "newline-and-indent") ("cb" "current-buffer")
    ("atl" "add-to-list") ("rris" "replace-regexp-in-string")))




;; * Key-Bindings * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package general
  :ensure t)

;; (use-package god-mode
;;   :ensure t
;;   :init
;;   (setq god-exempt-major-modes nil)
;;   (setq god-exempt-predicates nil)
;;   :config
;;   (global-set-key (kbd "<escape>") 'god-mode-all))


;; * Themes-Emacs * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; (use-package color-theme-modern         
;;   :ensure t
;;   :init  
;;   :config
;;   (load-theme 'comidia t))


;; (use-package powerline
;;   :ensure t
;;   :config (powerline-default-theme))


(use-package all-the-icons
  :ensure t)

(use-package doom-modeline
  :ensure t
  :hook (after-int . doom-modeline-mode))


(use-package doom-themes
  :ensure t
  :config (load-theme 'doom-one t))


;; * Common-Lisp * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'cl)


;; * Hyperbole * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(setq package-enable-at-startup nil) ;; Prevent double loading of libraries
(package-initialize)
(unless (package-installed-p 'hyperbole)
  (package-refresh-contents)
  (package-install 'hyperbole))
(require 'hyperbole)


;; * Code-Folding * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package vimish-fold
  :ensure t
  :config
  (vimish-fold-global-mode 1))

;; (use-package vimish-fold

;;   :defer 1

;;   :bind
;;   (:map vimish-fold-folded-keymap
;;         ("<tab>" . vimish-fold-unfold)

;;         :map vimish-fold-unfolded-keymap
;;         ("<tab>" . vimish-fold-refold))

;;   :init
;;   (setq-default vimish-fold-dir (expand-file-name ".vimish-fold/" user-emacs-directory))
;;   (vimish-fold-global-mode 1)

;;   :config
;;   (setq-default vimish-fold-header-width 79))



;; * DIRED-MODE * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
         
                           
;; * Neotree-Mode * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package neotree
  :ensure t
  :bind (("<f8>" . neotree-toggle))
  :init
  (setq neo-window-width 40)
  (setq neo-show-hidden-files t))
 


;; * Org-Mode * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(server-start)
(add-to-list 'load-path "~/.emacs.d/elpa/org-plus-contrib/org-protocol")
(require 'org-protocol)

(use-package org
  :ensure org-plus-contrib
  :init
  (setq org-directory "~/.emacs.d/org/org-files"))


(use-package org-bullets
    :ensure t
    :config
    (setq org-bullets-bullet-list '("∙"))
    (add-hook 'org-mode-hook 'org-bullets-mode))

(use-package deft
  :ensure t
  :init
  (setq deft-directory "~/.emacs.d/org/org-files")
  (setq deft-recursive t)
  (setq deft-use-filename-as-title t))


;; * Engine-mode * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package engine-mode
  :ensure t
  :init
  (progn
    ;; I don't want to override the `org-sparse-tree' binding (C-c /) in org-mode.
    (setq engine/keybinding-prefix "C-x /"))
  :config
  (progn
    (setq engine/browser-function 'eww-browse-url)

    (defengine duckduckgo
      "https://duckduckgo.com/html/?q=%s"
      :keybinding "d")

    (defengine github-el
      "https://github.com/search?type=Code&q=extension:el+%s"
      :keybinding "e"
      :browser 'browse-url-firefox
      :docstring "Search .el files on github.com.")

    (defengine google
      "http://www.google.com/search?ie=utf-8&oe=utf-8&q=%s"
      :keybinding "g")

    (defengine github-el-km
      "https://github.com/search?type=Code&q=extension:el+user:kaushalmodi+%s"
      :keybinding "m"
      :browser 'browse-url-firefox
      :docstring "Search .el files on github.com/kaushalmodi.")

    (defengine wikipedia
      "https://en.wikipedia.org/wiki/%s"
      :keybinding "p")                  ;wiki(p)edia

    (defengine emacs-devel
      "https://lists.gnu.org/archive/cgi-bin/namazu.cgi?query=%s&submit=Search&idxname=emacs-devel"
      :keybinding "v"                   ;emacs de(v)el
      :browser 'browse-url-firefox
      :docstring "Search posts on emacs-devel archive.")

    (defengine word
      "http://wordnik.com/words/%s"
      :term-transformation-hook downcase
      :keybinding "w")

    (engine-mode 1)))




















(use-package aggressive-indent
  :ensure t
  :config
  (global-aggressive-indent-mode 1)
  (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode))



 
(use-package projectile
  :ensure t
  :init  
  (setq projectile-enable-caching t)
  (setq projectile-completion-system 'ivy)
  (setq projectile-switch-project-action 'projectile-find-dir)
  (setq projectile-find-dir-includes-top-level t)
  :config
  (projectile-global-mode))



















(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode))





(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode 1))


(use-package restart-emacs
  :ensure t)




(use-package which-key
  :config (which-key-mode))


(use-package avy
  :ensure t
  :init
  (setq avy-all-windows nil)
  :config
  (avy-setup-default))


;; * Evil-Mode * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package evil-escape
  :ensure t
  :init
  (setq-default evil-escape-delay 0.2)
  (setq-default evil-escape-key-sequence "jj")
  :config
  (evil-escape-mode 1))


(use-package evil
  :ensure t
  :init
  :config
  (evil-mode -1))


(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme))))


(use-package evil-vimish-fold
  :ensure t
  :config
  (evil-vimish-fold-mode 1))


;; * Ivy-Swiper-Counsel * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package counsel
  :ensure t)


(use-package ivy :ensure t
  :diminish (ivy-mode . "")             ; does not display ivy in the modeline
  :init
  (ivy-mode 1)                          ; enable ivy globally at startup
  :bind (:map ivy-minibuffer-map        ; bind in the ivy buffer
       ("RET" . ivy-alt-done)
       ("s-<"   . ivy-avy)
       ("s->"   . ivy-dispatching-done)
       ("s-+"   . ivy-call)
       ("s-!"   . ivy-immediate-done)
       ("s-["   . ivy-previous-history-element)
       ("s-]"   . ivy-next-history-element))
  :config
  (setq ivy-use-virtual-buffers t)       ; extend searching to bookmarks and
  (setq ivy-height 20)                   ; set height of the ivy window
  (setq ivy-count-format "(%d/%d) ")     ; count format, from the ivy help page
  (setq ivy-display-style 'fancy)
  (setq ivy-format-function 'ivy-format-function-line) ; Make highlight extend all the way to the right
  ;; TODO testing out the fuzzy search
  (setq ivy-re-builders-alist
      '((counsel-M-x . ivy--regex-fuzzy) ; Only counsel-M-x use flx fuzzy search
        (t . ivy--regex-plus)))
  (setq ivy-initial-inputs-alist nil))
  

(defun dot-emacs ()
  "dot-emacs you can call via M-x."
  (interactive)
  (find-file "~/.emacs"))







(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(origami-show-fold-header t t)
 '(package-selected-packages
   (quote
    (counsel evil-org evil-escape avy neotree deft org-plus-contrib restart-emacs smartparens outlined-elisp-mode rainbow-delimiters dired+ lacarte use-package projectile powerline jazz-theme hyperbole god-mode general fuzzy evil-vimish-fold diminish dashboard company-flx command-log-mode aggressive-indent))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(origami-fold-fringe-face ((t (:inherit magit-diff-context-highlight))))
 '(origami-fold-replacement-face ((t (:inherit magit-diff-context-highlight)))))
