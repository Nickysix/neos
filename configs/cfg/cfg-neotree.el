;;; _*_ lexical-binding: t; _*_


(use-package neotree  
  :ensure t
  :bind (("<f8>" . neotree-toggle))
  :init
  (setq neo-window-width 40)
  ;; slow rendering
  (setq inhibit-compacting-font-caches t)

  ;; set icons theme
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))

  ;; Every time when the neotree window is opened, let it find current file and jump to node
  (setq neo-smart-open t)

  ;; When running ‘projectile-switch-project’ (C-c p p), ‘neotree’ will change root automatically
  (setq projectile-switch-project-action 'neotree-projectile-action)

  ;; show hidden files
  (setq-default neo-show-hidden-files t)
  
  :config
  
  (add-hook 'neo-after-create-hook
            (lambda (&rest _)
              (display-line-numbers-mode -1)))

  ;; (add-hook 'neotree-mode-hook
  ;;           (lambda ()
  ;;             (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
  ;;             (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-quick-look)
  ;;             (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
  ;;             (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
  ;;             (define-key evil-normal-state-local-map (kbd "g") 'neotree-refresh)
  ;;             (define-key evil-normal-state-local-map (kbd "n") 'neotree-next-line)
  ;;             (define-key evil-normal-state-local-map (kbd "p") 'neotree-previous-line)
  ;;             (define-key evil-normal-state-local-map (kbd "A") 'neotree-stretch-toggle)
  ;;             (define-key evil-normal-state-local-map (kbd "H") 'neotree-hidden-file-toggle)))

  (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
  (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
  (evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
  (evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
  (evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
  (evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)


  )            


(provide 'cfg-neotree)
