;; * CONFIG-JAVASCRIPT

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
