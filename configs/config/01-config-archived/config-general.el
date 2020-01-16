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


(general-define-key
 [(shift f12)] 'dot-emacs
 [(shift f5)] 'org-refile
 [f6] 'goto-line
 [f9] 'split-window-vertically
 [(shift f9)] 'split-window-horizontally
 [f10] 'delete-other-windows
 "s-s" 'sr-speedbar-toggle)




























(provide 'config-general)

