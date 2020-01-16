;;; config-keybindings.el


;;; * global-keybindings

(global-set-key (kbd "C-.") #'imenu-anywhere)

;; Set the enter key to newline-and-indent which inserts a new line and then
;; indents according to the major mode. This is very convenient. 

(global-set-key (kbd "<RET>") 'newline-and-indent)

;; By default C-x o is bound to 'other window, but I find I use it much more
;; ofther than open-line, which is bound to C-o, so I swap their definitions

(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "C-x o") 'open-line)


;;; * evil-mode

(use-package evil
  :ensure t)


;;; * general-mode

(use-package general
  :ensure t
  :config
  (general-define-key
  :prefix "C-c"
  ;; bind "C-c a" to 'org-agenda
  "a" 'org-agenda
  "b" 'counsel-bookmark
  "c" 'outshine-cycle-buffer))


;; * GENERAL-MODE            

;; (use-package general
;;   :ensure t
;;   :config (general-define-key
;;   :states '(normal visual insert emacs)
;;   :prefix "SPC"
;;   :non-normal-prefix "M-SPC"
;;   ;; "/"   '(counsel-rg :which-key "ripgrep") ; You'll need counsel package for this
;;   "TAB" '(switch-to-prev-buffer :which-key "previous buffer")
;;   "SPC" '(helm-M-x :which-key "M-x")
;;   "pf"  '(helm-find-file :which-key "find files")
;;   ;; Buffers
;;   "bb"  '(helm-buffers-list :which-key "buffers list")
;;   ;; Window
;;   "wl"  '(windmove-right :which-key "move right")
;;   "wh"  '(windmove-left :which-key "move left")
;;   "wk"  '(windmove-up :which-key "move up")
;;   "wj"  '(windmove-down :which-key "move bottom")
;;   "w/"  '(split-window-right :which-key "split right")
;;   "w-"  '(split-window-below :which-key "split bottom")
;;   "wx"  '(delete-window :which-key "delete window")
;;   ;; Others
;;   "at"  '(ansi-term :which-key "open terminal")
;; ))




;;; * modalka-mode


;;; * ryo-mode


;;; * bind-key



(provide 'config-keybindings)
