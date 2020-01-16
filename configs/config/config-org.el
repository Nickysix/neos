

;; * ORG-MODE * ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package org

  :ensure org-plus-contrib

  :init
  
  (setq org-use-speed-commands t
        org-return-follows-link t
        org-hide-emphasis-markers t
        org-completion-use-ido t
        org-outline-path-complete-in-steps nil
        org-src-fontify-natively t   ;; Pretty code blocks
        org-src-tab-acts-natively t
        org-confirm-babel-evaluate nil

        org-log-done t
        org-fast-tag-selection-single-key t
        org-use-fast-todo-selection t
        org-startup-truncated nil
        org-enable-priority-commands nil
        org-reverse-note-order t
        
       (setq org-todo-keywords '((sequence "IDEA(i)" "TODO(t)" "STARTED(s)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)")
                            (sequence "|" "CANCELED(c)" "DELEGATED(l)" "SOMEDAY(f)")))
        
   (setq org-todo-keyword-faces '(("IDEA" . (:foreground "GoldenRod" :weight bold))
                                 ("NEXT" . (:foreground "IndianRed1" :weight bold))   
                                 ("STARTED" . (:foreground "OrangeRed" :weight bold))
                                 ("WAITING" . (:foreground "coral" :weight bold)) 
                                 ("CANCELED" . (:foreground "LimeGreen" :weight bold))
                                 ("DELEGATED" . (:foreground "LimeGreen" :weight bold))
                                 ("SOMEDAY" . (:foreground "LimeGreen" :weight bold))))
        
   (setq org-tag-persistent-alist '((:startgroup . nil)
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
                                   ("noexport" . ?x)))
        
       (setq org-tag-faces '(("HOME" . (:foreground "GoldenRod" :weight bold))
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
                        ("noexport" . (:foreground "LimeGreen" :weight bold))))
        
         org-list-demote-modify-bullet '(("+" . "-")
                                         ("*" . "-")
                                         ("1." . "-")
                                         ("1)" . "a)")))

  :hook ((org-mode . toc-org-enable))

  :config
  
  (setq org-directory "~/.emacs.d/neos/org")

  
  (setq org-agenda-files '("~/.emacs.d/neos/org/refile.org"
                           "~/gtd/gtd.org"
                           "~/gtd/tickler.org"))

  (setq org-capture-templates '(("t" "Todo" entry (file+headline "~/.emacs.d/neos/org/refile.org" "Tasks")
                                 "* TODO %?\nAdded: %U\n" :prepend t :kill-buffer t)
                                ("w" "Web" entry (file+headline "~/www/org/index.org" "Tasks")
                                 "* TODO %?\nAdded: %U\n" :prepend t :kill-buffer t)
                                ("r" "Prog. R" entry (file+headline "~/www/org/teaching/introR.org" "Tasks")
                                 "* TODO %?\nAdded: %U\n" :prepend t :kill-buffer t)
                                ("i" "Idea" entry (file+headline "~/org/mygtd.org" "Someday/Maybe")
                                 "* IDEA %?\nAdded: %U\n" :prepend t :kill-buffer t)
                                ("h" "Home" entry (file+headline "~/org/mygtd.org" "Home")
                                 "* TODO %?\nAdded: %U\n" :prepend t :kill-buffer t)))

  (setq org-refile-targets '(("~/gtd/gtd.org" :maxlevel . 3)
                             ("~/gtd/someday.org" :level . 1)
                             ("~/gtd/tickler.org" :maxlevel . 2)))


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




(org-babel-do-load-languages
       'org-babel-load-languages
       '(
         (sh . t)
         (cfengine3 . t)
         (python . t)
         (ruby . t)
         (ditaa . t)
         (perl . t)
         ))

      (defadvice org-babel-execute-src-block (around load-language nil activate)
        "Load language if needed"
        (let ((language (org-element-property :language (org-element-at-point))))
          (unless (cdr (assoc (intern language) org-babel-load-languages))
            (add-to-list 'org-babel-load-languages (cons (intern language) t))
            (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages))
          ad-do-it))


  ) 


;; end of orgmode configuration ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

