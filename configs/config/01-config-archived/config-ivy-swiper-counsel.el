;;; config-ivy-swiper-counsel.el settings

;;; ivy-swiper-counsel

;;; counsel pulls in ivy swiper as deps.


(use-package smex
  :ensure t)

(use-package counsel
  :ensure t)

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
  (setq ivy-initial-inputs-alist nil)

  :config
  (setq ivy-re-builders-alist
        '((t . ivy--regex-ignore-order)))
  (setq ivy-wrap t)
  (ivy-mode 1))

(use-package swiper
  :bind (("M-s" . swiper)))

(use-package ivy-hydra
    :ensure t)



(provide 'config-ivy-swiper-counsel)
