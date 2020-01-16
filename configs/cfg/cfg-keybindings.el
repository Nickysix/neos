

(use-package general
  :ensure t
  :config
  (general-define-key
  :prefix "C-c"
  "c" 'outshine-cycle-buffer))


(general-define-key
 [f6] 'goto-line
 [f9] 'split-window-vertically
 [(shift f9)] 'split-window-horizontally
 [f10] 'delete-other-windows
 "s-s" 'sr-speedbar-toggle)

(general-define-key
 :keymaps 'drag-stuff-mode-map
 "<M-up>" 'drag-stuff-up
 "<M-down>" 'drag-stuff-down
 "<M-left>" 'drag-stuff-left
 "<M-right>" 'drag-stuff-right)



(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)


;; * PKG: EVIL-MODE
 
(use-package evil
  :ensure t
  :init
  (setq evil-normal-state-cursor '("DarkGoldenrod2" box)
        evil-insert-state-cursor '("chartreuse3" (bar . 2))
        evil-emacs-state-cursor '("SkyBlue2" box)
        evil-replace-state-cursor '("chocolate" (hbar . 2))
        evil-visual-state-cursor '("gray" (hbar . 2))
        evil-motion-state-cursor '("plum3" box)
        evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-u-scroll t)
  :config
  (evil-mode 1))

(general-define-key
 :states 'insert
 "M-j" 'evil-normal-state)




(use-package evil-collection
  :ensure t
  :after evil
  :config
  (setq evil-collection-mode-list
        '(ediff
          elisp-mode
          flycheck
          magit
          magit-todos))
  (evil-collection-init))








(provide 'cfg-keybindings)
