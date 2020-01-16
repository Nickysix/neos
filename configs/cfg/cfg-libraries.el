;;; -*- lexical-binding: t -*-


;; * dash
;; * esxml
;; * request
;; * s
;; * seq [built-in]
;; * cl-lib [built-in]
;; * ht
;; * f.el
;; * emacs-async
;; * ov.el
;; * names
;; * emacs-deferred
;; * popup
;; * websocket
;; * web-server


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

(use-package cl-libify
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































