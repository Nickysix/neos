;;; cfg-ido.el


(use-package flx
  :ensure t)

(use-package flx-ido
      :ensure t
      :init (flx-ido-mode 1))    

(use-package smex
      :ensure t
      :init (smex-initialize)
      :bind (("M-x" . smex)))

(use-package ido
  :bind (("C-x b" . ido-switch-buffer))
  :init
  (progn
    (ido-mode 1)
    (ido-everywhere 1))    
  :config
  (progn
    (setq ido-enable-prefix t
          ido-enable-flex-matching t
          ido-case-fold t
          ido-create-new-buffer 'always
          ido-use-filename-at-point nil
          ido-max-prospects 12
          ido-max-directory-size 100000
          completion-ignore-case t
          resize-mini-windows t
          ido-max-window-height 40
          max-mini-window-height 0.5
          ido-file-extensions-order '(".org" ".txt" ".py" ".emacs" ".xml" ".el" ".ini" ".cfg" ".cnf"))))


(use-package ido-vertical-mode
      :ensure t
      :init (ido-vertical-mode 1))


(use-package ido-completing-read+
      :ensure t
      :init (ido-ubiquitous-mode 1))    


(use-package ido-clever-match
  :ensure t
  :config
  (ido-clever-match-enable))


(use-package ido-hacks
  :ensure t)


(use-package ido-grid-mode
      :ensure t
      :config
      (ido-grid-mode 1)
      (setq ido-grid-mode-max-rows 4
            ido-grid-mode-min-rows 4)

      ;; See https://github.com/larkery/ido-grid-mode.el/issues/7
      (setq ido-max-window-height (+ ido-grid-mode-max-rows 1)))


(provide 'cfg-ido)
