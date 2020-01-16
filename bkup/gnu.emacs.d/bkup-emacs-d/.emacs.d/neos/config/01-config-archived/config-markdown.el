;; * CONFIG-MARKDOWN

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))


(use-package markdown-mode+
  :ensure t
  :after markdown-mode)


;; (use-package markdown-mode
;;   :straight t
;;   :mode "\\.md$"
;;   :init
;;   (setq markdown-asymmetric-header t)
;;   :config
;;   (add-hook 'markdown-mode-hook 'auto-fill-mode))


(provide 'config-markdown)
