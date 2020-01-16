;; neotree
(use-package neotree
  :ensure t)
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(global-set-key [f9] 'neotree-refresh)


;; * NEOTREE-MODE

(use-package neotree
  :ensure t
  :bind (("<f8>" . neotree-toggle))
  :init
  (setq neo-window-width 40)
  (setq neo-show-hidden-files t)
  (setq neo-theme 'arrow))

;; (add-hook 'neotree-mode-hook
;;               (lambda ()
;;                 (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
;;                 (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-quick-look)
;;                 (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
;;                 (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
;;                 (define-key evil-normal-state-local-map (kbd "g") 'neotree-refresh)
;;                 (define-key evil-normal-state-local-map (kbd "n") 'neotree-next-line)
;;                 (define-key evil-normal-state-local-map (kbd "p") 'neotree-previous-line)
;;                 (define-key evil-normal-state-local-map (kbd "A") 'neotree-stretch-toggle)
;;                 (define-key evil-normal-state-local-map (kbd "H") 'neotree-hidden-file-toggle)))


 (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
    (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
    (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
    (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
    (evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
    (evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
    (evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
    (evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
    (evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)

