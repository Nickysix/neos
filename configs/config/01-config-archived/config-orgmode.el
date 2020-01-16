;; * ORG-MODE

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
        org-todo-keywords '((sequence "TODO(t)" "DOING(g)" "|" "DONE(d)")
                            (sequence "|" "CANCELED(c)")))
  

  :config
  (setq org-directory "~/.emacs.d/neos/org")

  
  (setq org-agenda-files '("~/gtd/inbox.org"
                           "~/gtd/gtd.org"
                           "~/gtd/tickler.org"))

  (setq org-capture-templates '(("t" "Todo [inbox]" entry
                                 (file+headline "~/gtd/inbox.org" "Tasks")
                                 "* TODO %i%?")
                                ("T" "Tickler" entry
                                 (file+headline "~/gtd/tickler.org" "Tickler")
                                 "* %i%? \n %U")))


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
              (local-set-key "\C-y" 'yank))))

;;   (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)"))))


;; (setq org-startup-indented t
;;       org-bullets-bullet-list '(" ") ;; no bullets, needs org-bullets package
;;       org-ellipsis "  " ;; folding symbol
;;       org-pretty-entities t
;;       org-hide-emphasis-markers t
;;       ;; show actually italicized text instead of /italicized text/
;;       org-agenda-block-separator ""
;;       org-fontify-whole-heading-line t
;;       org-fontify-done-headline t
;;       org-fontify-quote-and-verse-blocks t)



(use-package org-download
  :ensure t)

(use-package org-bullets
    :ensure t
    :init
    (add-hook 'org-mode-hook (lambda ()
                               (org-bullets-mode 1))))

(use-package deft
  :ensure t
  :init
  (setq deft-directory "~/.emacs.d/neos/org")
  (setq deft-recursive t)
  (setq deft-use-filename-as-title t)
  (setq deft-default-extension "org")
  (setq deft-extensions '("org"))
  (setq deft-use-filter-string-for-filename t)
  (setq deft-file-naming-rules '((noslash . "-")
                                 (nospace . "-")
                                 (case-fn . downcase)))
  (setq deft-text-mode 'org-mode)
  (setq deft-org-mode-title-prefix t))








(use-package org-bullets
    :ensure t
    :config
    (setq org-bullets-bullet-list '("∙"))
    (add-hook 'org-mode-hook 'org-bullets-mode))





Customize appearance.

  (let*
      ((variable-tuple (cond
                        ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
                        ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
                        ((x-list-fonts "Verdana")         '(:font "Verdana"))
                        ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
                        (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
       (base-font-color     (face-foreground 'default nil 'default))
       (headline           `(:inherit default :weight normal :foreground ,base-font-color)))

    (custom-theme-set-faces 'user
                            `(org-level-8 ((t (,@headline ,@variable-tuple))))
                            `(org-level-7 ((t (,@headline ,@variable-tuple))))
                            `(org-level-6 ((t (,@headline ,@variable-tuple))))
                            `(org-level-5 ((t (,@headline ,@variable-tuple))))
                            `(org-level-4 ((t (,@headline ,@variable-tuple))))
                            `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.33))))
                            `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.33))))
                            `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.33))))
                            `(org-document-title ((t (,@headline ,@variable-tuple :height 1.33 :underline nil))))))
















