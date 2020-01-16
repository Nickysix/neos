

By default dired colors files with one of two colors, depending on if it's a folder or not. We can do better: 
(eval-after-load 'dired '(progn (require 'dired-filetype-face)))

(use-package dired-hacks-utils
  :ensure t
  :after dired
  :bind
  (:map dired-mode-map
        (("n" . dired-hacks-next-file)
         ("p" . dired-hacks-previous-file))))

(use-package dired-narrow
  :ensure t
  :after dired
  :bind (:map dired-mode-map
              ("/" . dired-narrow-fuzzy)))


(use-package dired
  :hook (dired-mode . dired-hide-details-mode)
  :bind ("C-x C-j" . dired-jump)
  :custom
  (dired-auto-revert-buffer t)
  (dired-recursive-copies 'always)
  (dired-recursive-deletes ' always))

(setq font-lock-maximum-decoration t)



;; wolfe company-mode configurations

(use-package company
  :bind (:map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous))
  :init
  (global-company-mode)
  :config
  (setq company-idle-delay 0) ; Delay to complete
  (setq company-minimum-prefix-length 1)
  (setq company-selection-wrap-around t) ; Loops around suggestions

  (if (display-graphic-p)
      (define-key company-active-map [tab] 'company-select-next)
    (define-key company-active-map (kbd "C-i") 'company-select-next))

(hook-if-daemonp
 (lambda ()
   (require 'color)
   (let ((bg (face-attribute 'default :background))
         (ac (face-attribute 'match :foreground)))
     (custom-set-faces
      `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
      `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
      `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
      `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
      `(company-tooltip-common ((t (:inherit font-lock-constant-face))))
      `(company-preview-common ((t (:foreground ,ac :background ,(color-lighten-name bg 10))))))))))


;; wolfe ivy settings

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

(use-package swiper
  :bind (("C-s" . swiper)))


;; evil with use of collections

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))


;; evil-collections manual setup


(add-to-list 'load-path (expand-file-name "/path/to/evil-collection/" user-emacs-directory))

;; register all at once

(evil-collection-init)

;; register mode by mode

(with-eval-after-load 'calendar (require 'evil-collection-calendar) (evil-collection-calendar-setup))

;; or 

(evil-collection-init 'calendar)




;; initial window
(setq initial-frame-alist
      '((width . 102)   ; characters in a line
        (height . 54))) ; number of lines

;; sebsequent frame
(setq default-frame-alist
      '((width . 100)   ; characters in a line
        (height . 52))) ; number of lines


;; Bar cursor
(setq-default cursor-type '(bar . 1))
;; Don't blink the cursor
(blink-cursor-mode -1)



(setq-default truncate-lines t)


(setq save-abbrevs 'silently)
(setq-default abbrev-mode t)





(use-package eww
  :bind* (("M-m g x" . eww)
          ("M-m g :" . eww-browse-with-external-browser)
          ("M-m g #" . eww-list-histories)
          ("M-m g {" . eww-back-url)
          ("M-m g }" . eww-forward-url))
  :config
  (progn
    (add-hook 'eww-mode-hook 'visual-line-mode)))



;; :USE 0-9 TO SELECT COMPANY-MODE SELECTIONS FUNCTION: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ora-company-number ()
  "Forward to `company-complete-number'.

Unless the number is potentially part of the candidate.
In that case, insert the number."
  (interactive)
  (let* ((k (this-command-keys))
         (re (concat "^" company-prefix k)))
    (if (cl-find-if (lambda (s) (string-match re s))
                    company-candidates)
        (self-insert-command 1)
      (company-complete-number (string-to-number k)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;; chords borrowed from prelude.
 (use-package key-chord
   :ensure t
   :config
   (key-chord-mode 1)
   ;; (let (
   (key-chord-define-global "jj" 'avy-goto-word-1)
   (key-chord-define-global "jl" 'avy-goto-line)
   (key-chord-define-global "jk" 'avy-goto-char)
   (key-chord-define-global "JJ" 'crux-switch-to-previous-buffer)
   (key-chord-define-global "uu" 'undo-tree-visualize)
   (key-chord-define-global "xx" 'counsel-M-x)
   (key-chord-define-global "yy" 'counsel-yank-pop)
   (key-chord-define-global "  " ". ")

   ;; This create a prefix keymap
   ;; https://stackoverflow.com/questions/25473660/how-do-i-use-a-key-chord-combination-as-a-prefix-binding
   (let
       ((sub-keymap (make-sparse-keymap)))
     (define-key sub-keymap "a" 'org-agenda)
     (define-key sub-keymap "c" 'org-capture)
     (key-chord-define-global "cc" sub-keymap))

   (defvar key-chord-tips
     '("Press <jj> quickly to jump to the beginning of a visible word."
       "Press <jl> quickly to jump to a visible line."
       "Press <jk> quickly to jump to a visible character."
       "Press <JJ> quickly to switch to previous buffer."
       "Press <uu> quickly to visualize the undo tree."
       "Press <xx> quickly to execute extended command."
       "Press <yy> quickly to browse the kill ring.")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(setq key-chord-two-keys-delay .015
      key-chord-one-key-delay .020)

(dolist (binding
         `((" i" . previous-multiframe-window)
           (" o" . next-multiframe-window)
           (" l" . ibuffer)
           
           (" m" . magit)

           (" e" . er/expand-region)
           
           (" q" . quake-mode)
           
           (" 0" . delete-window)
           (" 1" . delete-other-windows)
           (" 2" . split-window-below)
           (" 3" . split-window-right)
           (" =" . winstack-push)
           (" -" . winstack-pop)
           
           (" w" . whitespace-mode)
           
           ("ji" . undo-tree-undo)
           ("jo" . undo-tree-redo)
           ("jk" . undo-tree-switch-branch)
           ("j;" . undo-tree-visualize)
           
           (" b" . ido-switch-buffer)
           (" f" . ido-find-file)
           (" s" . save-buffer)
           
           (" x" . shell)
           
           (" \\". jorbi/toggle-comment)
           
           ("nw" . jabber-display-roster)
           ("ne" . jabber-chat-with)
           
           ("nv" . jorbi/find-init-file)
           
           (" r" . recompile)))
  (key-chord-define jordon-dev-mode-map (car binding) (cdr binding)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




(key-chord-define-global ";u" 'undo-tree-visualize)
  (key-chord-define-global ";j" 'ace-jump-mode)
  (key-chord-define-global ";s" 'monky-status)
  (key-chord-define-global ";c" 'comment-dwim)

  (require 'python)
  (key-chord-define python-mode-map ";d" 'python-insert-breakpoint)
  (key-chord-define-global ";x" 'execute-extended-command) ;; Meta-X

  ;; window management:
  (key-chord-define-global ";2" 'double-window)
  (key-chord-define-global ";3" 'triple-window)
  (key-chord-define-global ";8" 'eighty-columns)
  (key-chord-define-global ";w" 'one-hundred-thirty-two-columns)
  (key-chord-define-global ";s" 'rotate-windows)  ;; "s" for switch





;; Defining a keybind for imenu - good for navigation
(global-set-key (kbd "M-i") 'imenu)


;; dired settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;preview files in dired
(use-package peep-dired
  :ensure t
  :defer t ; don't access `dired-mode-map' until `peep-dired' is loaded
  :bind (:map dired-mode-map
              ("P" . peep-dired)))


;; allow editing file permissions
(setq wdired-allow-to-change-permissions t)



(use-package dired-quick-sort
  :ensure t
  :config
  (dired-quick-sort-setup))


;;narrow dired to match filter
(use-package dired-narrow
  :ensure t
  :bind (:map dired-mode-map
              ("/" . dired-narrow)))




;; open recent directory, requires ivy (part of swiper)
;; borrows from http://stackoverflow.com/questions/23328037/in-emacs-how-to-maintain-a-list-of-recent-directories
(defun bjm/ivy-dired-recent-dirs ()
  "Present a list of recently used directories and open the selected one in dired"
  (interactive)
  (let ((recent-dirs
         (delete-dups
          (mapcar (lambda (file)
                    (if (file-directory-p file) file (file-name-directory file)))
                  recentf-list))))

    (let ((dir (ivy-read "Directory: "
                         recent-dirs
                         :re-builder #'ivy--regex
                         :sort nil
                         :initial-input nil)))
      (dired dir))))

(global-set-key (kbd "C-x C-d") 'bjm/ivy-dired-recent-dirs)


;; by doing this you can easily jump to dired while browsing for files with C-j

(require 'dired-x)

(use-package dired-x
    :init (setq-default dired-omit-files-p t)
    :config
    (add-to-list 'dired-omit-extensions ".DS_Store"))


(use-package dired-subtree
  :config
  (bind-keys :map dired-mode-map
             ("i" . dired-subtree-insert)
             (";" . dired-subtree-remove)))



(setq dired-listing-switches "-lFaGh1v --group-directories-first")



(setq ls-lisp-dirs-first t)


(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)


(setq delete-by-moving-to-trash t)

(require 'dired-async)













