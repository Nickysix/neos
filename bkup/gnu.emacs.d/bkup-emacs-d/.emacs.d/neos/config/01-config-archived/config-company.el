;;; Company-mode Configerations
;;; There are multiple company configs in this file.

(use-package company
  :ensure t
  :commands company-mode)





(use-package company
:ensure t
:config
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 3)
(global-company-mode t))


(use-package company-lsp
:ensure t
:init
(push 'company-lsp company-backends))



;; ;;; * config-company-v1

;; (use-package company
;;   :bind
;;   (:map company-active-map
;;         ("RET" . nil)
;;         ([return] . nil)
;;         ("TAB" . company-complete-selection)
;;         ([tab] . company-complete-selection)
;;         ("<right>" . company-complete-common))
;;   :hook (after-init . global-company-mode)
;;   :config
;;   (setq-default
;;    company-dabbrev-downcase nil
;;    company-idle-delay .2
;;    company-minimum-prefix-length 1
;;    company-require-match nil
;;    company-tooltip-align-annotations t))




;; ;;; * config-company-v2

;; (use-package company
;;   :ensure t
;;   :init
;;   (setq company-minimum-prefix-length 3)
;;   (setq company-auto-complete nil)
;;   (setq company-idle-delay 0)
;;   (setq company-require-match 'never)
;;   (setq company-frontends
;; 	'(company-pseudo-tooltip-unless-just-one-frontend
;; 	  company-preview-frontend
;; 	  company-echo-metadata-frontend))
;;   (setq tab-always-indent 'complete)
;;   (defvar completion-at-point-functions-saved nil)

;;   :config
;;   (global-company-mode 1)
;;   (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
;;   (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
;;   (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
;;   (define-key company-active-map (kbd "<backtab>") 'company-select-previous)
;;   (define-key company-mode-map [remap indent-for-tab-command] 'company-indent-for-tab-command)
;;   (defun company-indent-for-tab-command (&optional arg)
;;     (interactive "P")
;;     (let ((completion-at-point-functions-saved completion-at-point-functions)
;; 	  (completion-at-point-functions '(company-complete-common-wrapper)))
;;       (indent-for-tab-command arg)))

;;   (defun company-complete-common-wrapper ()
;;     (let ((completion-at-point-functions completion-at-point-functions-saved))
;;       (company-complete-common))))


;; version-3

;; (use-package company
;;   :ensure t
;;   :bind (:map company-active-map
;;          ("C-n" . company-select-next)
;;          ("C-p" . company-select-previous))
;;   :init
;;   (global-company-mode)
;;   :config
;;   (setq company-idle-delay 0) ; Delay to complete
;;   (setq company-minimum-prefix-length 1)
;;   (setq company-selection-wrap-around t)) ; Loops around suggestions




(provide 'config-company)
