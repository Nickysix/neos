;; * GENERAL

(use-package general
  :ensure t
  :config
  (general-define-key
  :prefix "C-c"
  ;; bind "C-c a" to 'org-agenda
  "a" 'org-agenda
  "b" 'counsel-bookmark
  "c" 'outshine-cycle-buffer))

(provide 'config-general)

