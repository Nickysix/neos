;; * USEFULL-LIBRARIES


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

