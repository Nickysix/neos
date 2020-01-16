
;; config-helpful.el

;; version-1

(use-package helpful
  :defer t
  :bind
  (("C-h f" . helpful-callable)
   ("C-h v" . helpful-variable)
   ("C-h k" . helpful-key)
   ("C-h F" . helpful-function)
   ("C-h C" . helpful-command))
  :config
  (evil-define-key 'normal helpful-mode-map (kbd "q") 'kill-buffer-and-window)
  (set-face-attribute 'helpful-heading nil :height 1.1))

;; version-2

;; * HELPFUL-MODE

(use-package helpful
  :ensure t
  :config
  (global-set-key (kbd "C-h f") #'helpful-callable)
  (global-set-key (kbd "C-h v") #'helpful-variable)
  (global-set-key (kbd "C-h k") #'helpful-key)
  (global-set-key (kbd "C-c C-d") #'helpful-at-point)
  (global-set-key (kbd "C-h F") #'helpful-function)
  (global-set-key (kbd "C-h C") #'helpful-command))



(use-package helpful
  :after counsel
  :bind (("C-h v"   . helpful-variable)
         ("C-h C-v" . helpful-variable)
         ("C-h f"   . helpful-function)
         ("C-h C-f" . helpful-function))
  :init
  (add-to-list 'evil-motion-state-modes 'helpful-mode)
  (add-to-list 'evil-motion-state-modes 'elisp-refs-mode)
  :config
  (ivy-set-actions
   'counsel-M-x
   '(("d" counsel--find-symbol "definition")
     ("h" (lambda (x) (helpful-function (intern x))) "helpful"))))
