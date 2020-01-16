(use-package ivy
  :demand
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         :map ivy-minibuffer-map
         ("TAB" . ivy-next-line)
         ("RET" . ivy-alt-done)
         :map ivy-switch-buffer-map
         ("C-d" . ivy-switch-buffer-kill))
  :init
  (use-package smex)
  (use-package counsel)
  :config
  (setq ivy-re-builders-alist
        '((t . ivy--regex-ignore-order)))
  (setq ivy-wrap t)
  (ivy-mode 1)

  (use-package doom-todo-ivy
    :ensure nil
    :config
    (evil-define-command doom/ivy-tasks-ex (&optional bang)
      "An ex wrapper around `doom/ivy-tasks'."
      (interactive "<!>")
      (doom/ivy-tasks bang))
    (evil-ex-define-cmd "todo" 'doom/ivy-tasks-ex))

  (eval-after-load "hydra" (use-package ivy-hydra)))


(use-package swiper
  :bind (("C-s" . swiper)))

(provide 'config-isc2)
