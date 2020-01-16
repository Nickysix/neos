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

(global-linum-mode -1)
(global-display-line-numbers-mode)

(setq linum-format "  %2d  ")

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


