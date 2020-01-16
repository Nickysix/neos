



;; * GLOBAL-KEYBINDINGS

(global-set-key [f2] 'eval-buffer)

(global-set-key [f6] 'goto-line)

(global-set-key [f7] 'save-buffer)

(global-set-key [f9] 'split-window-vertically)

(global-set-key [(shift f9)] 'split-window-horizontally)

(global-set-key [f10] 'delete-other-windows)

(global-set-key [(shift f10)] 'lacarte-execute-menu-command)

(global-set-key [(shift f12)] 'dot-emacs)

(global-set-key [M-left] 'windmove-left)          ; move to left window

(global-set-key [M-right] 'windmove-right)        ; move to right window

(global-set-key [M-up] 'windmove-up)              ; move to upper window

(global-set-key [M-down] 'windmove-down)          ; move to lower window

(global-set-key (kbd "C-o") 'other-window)

(global-set-key (kbd "C-x o") 'open-line)

;; make cursor movement keys under right hand's home-row.
(global-set-key (kbd "M-h") 'backward-char) ; was indent-new-comment-line

(global-set-key (kbd "M-l") 'forward-char)  ; was downcase-word

(global-set-key (kbd "M-k") 'previous-line) ; was tab-to-tab-stop

(global-set-key (kbd "M-j") 'next-line) ; was kill-sentence

(global-set-key (kbd "M-SPC") 'set-mark-command) ; was just-one-space

(global-set-key (kbd "M-a") 'execute-extended-command) ; was backward-sentence

(global-set-key (kbd "s-s") 'sr-speedbar-toggle)

;; Delete selected text
(global-set-key [C-M-backspace] 'delete-region)

;; Kill window and buffer in one keystroke
(global-set-key (kbd "s-w") 'kill-buffer-and-window)
