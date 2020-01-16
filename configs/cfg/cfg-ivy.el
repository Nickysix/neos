;;;; cfg-ivy.el

;;; notes:

;; counsel pulls in ivy swiper as deps.

;; amx replaces smex more functionality.

;;(use-package smex
;;  :ensure t)

(use-package all-the-icons-ivy
  :ensure t
  :after all-the-icons
  :config
  (all-the-icons-ivy-setup))


(use-package amx
  :ensure t)

(use-package counsel
  :ensure t)

(use-package counsel-etags
  :ensure t
  :bind (("C-]" . counsel-etags-find-tag-at-point))
  :init
  (add-hook 'prog-mode-hook
        (lambda ()
          (add-hook 'after-save-hook
            'counsel-etags-virtual-update-tags 'append 'local)))
  :config
  (setq counsel-etags-update-interval 60)
  (add-to-list 'counsel-etags-ignore-directories "build"))

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

;;(use-package ivy-posframe
;;    :ensure t
;;    :after counsel ivy swiper posframe
;;    :init
;;    (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display)))
;;    (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
;;    (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-center)))
;;    (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-bottom-left)))
;;    (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-bottom-left)))
;;    (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))
;;    :config
;;    (ivy-posframe-mode 1))


;;(use-package ivy-posframe
;;    :ensure t
;;    :after counsel ivy swiper posframe
;;    :init
;;    (setq ivy-posframe-height-alist '((swiper . 20)
;;                                      (t      . 40)))
;;
;;    (setq ivy-posframe-display-functions-alist
;;          '((swiper          . nil)
;;            (complete-symbol . ivy-posframe-display-at-point)
;;            (counsel-M-x     . ivy-posframe-display-at-window-center)
;;            (t               . ivy-posframe-display)))
;;    :config
;;    (ivy-posframe-mode 1))

;;(use-package ivy-explorer
;;    :ensure t
;;    :after ivy posframe
;;    :init
;;    (setq ivy-explorer-message-function #'ivy-explorer--posframe)
;;    :config
;;    (ivy-explorer-mode 1))



(provide 'cfg-ivy)
