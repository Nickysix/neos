

(setq package-check-signature nil)



(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)


(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))


(use-package server
  :hook (after-init . server-start))

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)































