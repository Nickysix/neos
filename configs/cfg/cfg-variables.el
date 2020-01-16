;;; -*- lexical-binding: t -*-



;; Encoding
;; UTF-8 as the default coding system
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))


;; Explicitly set the prefered coding systems to avoid annoying prompt
;; from emacs (especially on Microsoft Windows)
(prefer-coding-system 'utf-8)
(prefer-coding-system 'utf-8-unix)

(set-language-environment 'utf-8)
(set-file-name-coding-system 'utf-8)

(set-locale-environment "en_US.UTF-8")
(set-default-coding-systems 'utf-8-unix)
(set-selection-coding-system 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
(set-clipboard-coding-system 'utf-8) ; included by set-selection-coding-system
(set-keyboard-coding-system 'utf-8) ; configured by prefer-coding-system
(set-terminal-coding-system 'utf-8) ; configured by prefer-coding-system
(setq buffer-file-coding-system 'utf-8) ; utf-8-unix
(setq save-buffer-coding-system 'utf-8-unix) ; nil

(setq process-coding-system-alist
  (cons '("grep" utf-8 . utf-8) process-coding-system-alist))

(modify-coding-system-alist 'process "*" 'utf-8)

(setq locale-coding-system 'utf-8
      default-process-coding-system '(utf-8 . utf-8))


(setq frame-title-format nil)
(setq ring-bell-function 'ignore)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets) ; Show path if names are same
(setq adaptive-fill-regexp "[ t]+|[ t]*([0-9]+.|*+)[ t]*")
(setq adaptive-fill-first-line-regexp "^* *$")
(setq sentence-end "\\([。、！？]\\|……\\|[,.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)
(setq delete-by-moving-to-trash t)    ; Deleting files go to OS's trash folder
(setq make-backup-files nil)          ; Forbide to make backup files
(setq auto-save-default nil)          ; Disable auto save
(setq set-mark-command-repeat-pop t)  ; Repeating C-SPC after popping mark pops it again
(setq track-eol t)			; Keep cursor at end of lines.
(setq line-move-visual nil)		; To be required by track-eol
(setq-default kill-whole-line t)	; Kill line including '\n'
(setq-default indent-tabs-mode nil)   ; use space
(setq-default tab-width 2)
(defalias 'yes-or-no-p #'y-or-n-p)

;;(setq initial-buffer-choice "/emacs/start.org")

(setq speedbar-directory-unshown-regexp "^\(\.\.*$\)\'")

(setq speedbar-show-unknown-files t)

(setq make-backup-files nil) ;; stop creating those backup~ files

(setq auto-save-default nil)  ;; stop creating those #auto-save# files

(set-frame-parameter nil 'unsplittable t)

(winner-mode 1)

(cua-mode -1)

(tool-bar-mode -1)

(scroll-bar-mode -1)

(toggle-frame-maximized)

(show-paren-mode 1)

(electric-pair-mode -1)

;;(remove-trailing-whitespace-mode)
;;(setq-default require-final-newline 'visit-save)

;;(server-start)


;; Automatically update buffers when files change
;;(global-auto-revert-mode t)

;; Soft-wrap lines
;;(global-visual-line-mode t)

;;(global-display-line-numbers-mode)

(global-linum-mode t)
(setq linum-format "%4d\u2502 ")
;;(set-face-background 'fringe "#f4a460")

(global-font-lock-mode 1)

(setq pop-up-windows nil)

(setq split-height-threshold 5)
(setq split-width-threshold 5)

(setq-default vc-display-status nil)

(setq-default x-underline-at-descent-line t)

(setq-default enable-recursive-minibuffers t)

(setq-default cursor-type '(bar . 1))

(set-cursor-color "#00ff00") 

(setq-default word-wrap t)

(setq-default fill-column 200)

;; Don't break lines for me, please
(setq-default truncate-lines t)


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


(provide 'cfg-variables)
