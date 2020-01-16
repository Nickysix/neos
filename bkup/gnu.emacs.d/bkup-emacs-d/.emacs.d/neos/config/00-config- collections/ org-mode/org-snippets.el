(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(setq org-log-done t)
(setq org-fast-tag-selection-single-key t)
(setq org-use-fast-todo-selection t)
(setq org-startup-truncated nil)

Default directories for my notes and website.
it’s best to set aside a separate directory where your org files will be kept. The agenda directories are not visited recursivly.

(setq org-directory (expand-file-name "~/org"))
(setq org-default-notes-file (concat org-directory "/mygtd.org"))
(setq org-agenda-files '("~/org" "~/www/org" "~/www/_org"))
Todo and Tags
Define TODO and TAG keywords with smooth colors.

(setq org-todo-keywords
      '(
        (sequence "IDEA(i)" "TODO(t)" "STARTED(s)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)")
        (sequence "|" "CANCELED(c)" "DELEGATED(l)" "SOMEDAY(f)")
        ))

(setq org-todo-keyword-faces
      '(("IDEA" . (:foreground "GoldenRod" :weight bold))
        ("NEXT" . (:foreground "IndianRed1" :weight bold))   
        ("STARTED" . (:foreground "OrangeRed" :weight bold))
        ("WAITING" . (:foreground "coral" :weight bold)) 
        ("CANCELED" . (:foreground "LimeGreen" :weight bold))
        ("DELEGATED" . (:foreground "LimeGreen" :weight bold))
        ("SOMEDAY" . (:foreground "LimeGreen" :weight bold))
        ))

(setq org-tag-persistent-alist 
      '((:startgroup . nil)
        ("HOME" . ?h) 
        ("RESEARCH" . ?r)
        ("TEACHING" . ?t)
        (:endgroup . nil)
        (:startgroup . nil)
        ("OS" . ?o) 
        ("DEV" . ?d)
        ("WWW" . ?w)
        (:endgroup . nil)
        (:startgroup . nil)
        ("EASY" . ?e)
        ("MEDIUM" . ?m)
        ("HARD" . ?a)
        (:endgroup . nil)
        ("URGENT" . ?u)
        ("KEY" . ?k)
        ("BONUS" . ?b)
        ("noexport" . ?x)  
        )
      )

(setq org-tag-faces
      '(
        ("HOME" . (:foreground "GoldenRod" :weight bold))
        ("RESEARCH" . (:foreground "GoldenRod" :weight bold))
        ("TEACHING" . (:foreground "GoldenRod" :weight bold))
        ("OS" . (:foreground "IndianRed1" :weight bold))   
        ("DEV" . (:foreground "IndianRed1" :weight bold))   
        ("WWW" . (:foreground "IndianRed1" :weight bold))
        ("URGENT" . (:foreground "Red" :weight bold))  
        ("KEY" . (:foreground "Red" :weight bold))  
        ("EASY" . (:foreground "OrangeRed" :weight bold))  
        ("MEDIUM" . (:foreground "OrangeRed" :weight bold))  
        ("HARD" . (:foreground "OrangeRed" :weight bold))  
        ("BONUS" . (:foreground "GoldenRod" :weight bold))
        ("noexport" . (:foreground "LimeGreen" :weight bold))  
        )
)
Disable priorities
(setq org-enable-priority-commands nil)
Lists
(setq org-list-demote-modify-bullet (quote (("+" . "-")
                                            ("*" . "-")
                                            ("1." . "-")
                                            ("1)" . "a)"))))  
STARTED Agenda
Honestly, I am do not use much org-agenda.

     (setq org-agenda-ndays 7)
     (setq org-agenda-show-all-dates t)
     (setq org-agenda-skip-deadline-if-done t)
     (setq org-agenda-skip-scheduled-if-done t)
     (setq org-agenda-start-on-weekday nil)
     (setq org-deadline-warning-days 14)
(setq org-agenda-custom-commands
      '(("g" . "GTD contexts")
        ("gh" "Home" tags-todo "HOME")
        ("gu" "Urgent" tags-todo "URGENT")
        ("G" "GTD Block Agenda"
         ((todo "STARTED")
          (tags-todo "URGENT")
          (todo "NEXT"))
         ((org-agenda-prefix-format "[ ] %T: ")
          (org-agenda-with-colors nil)
          (org-agenda-compact-blocks t)
          (org-agenda-remove-tags t)
          (ps-number-of-columns 2)
          (ps-landscape-mode t))
         ;;nil                      ;; i.e., no local settings
         ("~/next-actions.txt"))
        ))    
STARTED Capture
(setq org-reverse-note-order t)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/mygtd.org" "Tasks")
         "* TODO %?\nAdded: %U\n" :prepend t :kill-buffer t)
        ("w" "Web" entry (file+headline "~/www/org/index.org" "Tasks")
         "* TODO %?\nAdded: %U\n" :prepend t :kill-buffer t)
        ("r" "Prog. R" entry (file+headline "~/www/org/teaching/introR.org" "Tasks")
         "* TODO %?\nAdded: %U\n" :prepend t :kill-buffer t)
        ("i" "Idea" entry (file+headline "~/org/mygtd.org" "Someday/Maybe")
         "* IDEA %?\nAdded: %U\n" :prepend t :kill-buffer t)
        ("h" "Home" entry (file+headline "~/org/mygtd.org" "Home")
         "* TODO %?\nAdded: %U\n" :prepend t :kill-buffer t)
        )
      )




(add-hook 'org-mode-hook 
          (lambda ()
            (local-set-key "\M-n" 'outline-next-visible-heading)
            (local-set-key "\M-p" 'outline-previous-visible-heading)
            ;; table
            (local-set-key "\C-\M-w" 'org-table-copy-region)
            (local-set-key "\C-\M-y" 'org-table-paste-rectangle)
            (local-set-key "\C-\M-l" 'org-table-sort-lines)
            ;; display images
            (local-set-key "\M-I" 'org-toggle-iimage-in-org)
            ;; fix tab
            (local-set-key "\C-y" 'yank)))



(setq initial-major-mode 'org-mode)


(setq org-refile-use-outline-path t)
(setq org-outline-path-complete-in-steps t)


(setq org-refile-targets '((nil . (:maxlevel . 3))))


(setq org-refile-allow-creating-parent-nodes 'confirm)






