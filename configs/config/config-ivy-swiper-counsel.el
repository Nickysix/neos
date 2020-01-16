;;;; config-ivy-swiper-counsel.el

;;; notes:

;; counsel pulls in ivy swiper as deps.

;; amx replaces smex more functionality.

;;(use-package smex
;;  :ensure t)

(use-package all-the-icons-ivy
  :after all-the-icons
  :ensure t)

(use-package amx
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

(use-package ivy-rich
    :after ivy
    :custom
    (ivy-virtual-abbreviate 'full
                            ivy-rich-switch-buffer-align-virtual-buffer t
                            ivy-rich-path-style 'abbrev)
    :config
    (ivy-set-display-transformer 'ivy-switch-buffer
                                 'ivy-rich-switch-buffer-transformer))


(use-package swiper
  :bind (("M-s" . swiper)))

(use-package pdf-view
  :ensure nil
  :after pdf-tools
  :bind (:map pdf-view-mode-map
        ("C-s" . isearch-forward))
  :custom (pdf-view-use-unicode-ligther nil))

(use-package ivy-hydra
    :ensure t)



(provide 'config-ivy-swiper-counsel)
