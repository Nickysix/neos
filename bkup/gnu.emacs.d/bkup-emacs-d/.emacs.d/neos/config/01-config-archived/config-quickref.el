;; * QUICKREF-MODE

(use-package quickref
  :ensure t
  :init
  (setq quickref-command-prefix (kbd "C-M-q"))
  :config
  (quickref-global-mode +1))

