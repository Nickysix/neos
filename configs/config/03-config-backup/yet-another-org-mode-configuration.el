


Yet Another Org-Mode Configuration


Notes about publishing a website using emacs and org-mode (tutorial, manual, example).

Org-Mode Configuration
Version
I mostly rely on the yum package manager, my org version is (also mentionned in the postamble).


"8.2.10"

Activation
This will make sure org gets loaded, and some basic global key combinations are defined.

(provide 'emacs-orgmode-config)
(require 'ox)  

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
TODO use the variable org-default-notes-file instead of absolute path
STARTED LaTeX
I rarely use org-mode to generate LaTeX files, I simply prefer auctex.

(require 'ox-latex)

(add-to-list 'org-latex-packages-alist '(\"\" \"listings\"))
(add-to-list 'org-latex-packages-alist '(\"\" \"color\"))

(setq org-format-latex-options (quote (:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 2.0 :matchers ("begin" "$1" "$" "$$" "\\(" "\\["))))
Speed commands
Speed commands enable single-letter commands in Org-mode files when the point is at the beginning of a headline, or at the beginning of a code block. See the org-speed-commands-default variable for a list of the keys and commands enabled at the beginning of headlines.

(setq org-use-speed-commands t)
Code blocks
This activates a number of widely used languages. You can to activate more languages using the customize interface for the org-babel-load-languages variable, or with an elisp form like the one below.

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (emacs-lisp . t)
   (org . t)
   (sh . t)
   (C . t)
   (python . t)
   (gnuplot . t)
   (octave . t)
   (R . t)
   (dot . t)
   (awk . t)
   ))
Fontification
The following displays the contents of code blocks in Org-mode files using the major-mode of the code. It also changes the behavior of TAB to as if it were used in the appropriate major mode.

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
Evaluation
It is possible to inhibit the evaluation of code blocks during export. Based on the documentation one can set the header arguments system wide using these variables:

org-babel-default-header-args (for all)
org-babel-default-header-args:<lang>   (language specific)
File wide using PROPERTY

#+PROPERTY: header-args :eval never-export
Org heading wide using a local property setting:

* sample header
  :PROPERTIES:
  :header-args:    :eval never-export
  :END:
(setq org-babel-default-header-args '((:eval . "never-export")))    
Tangle
Tangle only one code block.

(defun org-babel-tangle-block()
  (interactive)
  (let ((current-prefix-arg '(4)))
    (call-interactively 'org-babel-tangle)
))
Spell checking
From stackexchange ispell can be configured to skip over regions that match regexes. For example, to skip over :PROPERTIES: and :LOGBOOK: drawers as well as SRC AND EXAMPLE blocks:

(add-to-list 'ispell-skip-region-alist '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_SRC" . "#\\+END_SRC"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_EXAMPLE" . "#\\+END_EXAMPLE"))
Text export
Fix missing links in ASCII export
(setq org-ascii-links-to-notes nil)
Adjust the number of blank lines inserted around headlines
(setq org-ascii-headline-spacing (quote (1 . 1)))
Smart quotes
(setq org-export-with-smart-quotes t)
Org File Template
#+STARTUP: overview
#+STARTUP: hidestars
#+STARTUP: logdone
#+COLUMNS: %38ITEM(Details) %7TODO(To Do) %TAGS(Context) 
#+OPTIONS: tags:t 
#+OPTIONS: timestamp:t p:t
#+OPTIONS: todo:t
#+OPTIONS: TeX:t
##Do the right thing automatically (MathJax)
#+OPTIONS: LaTeX:t          
#+OPTIONS: skip:t @:t ::t |:t ^:t f:t    
Org Reveal File Template
#+STARTUP: overview
#+STARTUP: hidestars
#+STARTUP: logdone
#+COLUMNS: %38ITEM(Details) %7TODO(To Do) %TAGS(Context) 
#+OPTIONS: tags:t 
#+OPTIONS: timestamp:t p:t
#+OPTIONS: todo:t
#+OPTIONS: TeX:t
##Do the right thing automatically (MathJax)
#+OPTIONS: LaTeX:t          
#+OPTIONS: skip:t @:t ::t |:t ^:t f:t
#+REVEAL_ROOT: http://cdn.jsdelivr.net/reveal.js/3.0.0/
#+OPTIONS: reveal_center:t reveal_progress:t reveal_history:nil reveal_control:t
#+OPTIONS: reveal_rolling_links:t reveal_keyboard:t reveal_overview:t num:nil
#+OPTIONS: reveal_width:1200 reveal_height:800
#+REVEAL_MARGIN: 0.1
#+REVEAL_MIN_SCALE: 0.5
#+REVEAL_MAX_SCALE: 2.5
#+REVEAL_TRANS: slide
#+REVEAL_THEME: league
#+REVEAL_PLUGINS: (markdown notes)
#+REVEAL_EXTRA_CSS: ./local-reveal.css
#+REVEAL_PLUGINS: (highlight)
#+PROPERTY: header-args :results output
#+PROPERTY: header-args :exports both
Publishing the Website
Activation
(require 'ox-publish)
(setq org-html-coding-system 'utf-8-unix) 
Project Tree
www
├── org
├── _org
├── static_html
└── utils

4 directories

(
 setq org-publish-project-alist
      '(
        ("html-static"
         :base-directory "~/www/static_html/"
         :base-extension "html\\|xml\\|css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|zip\\|gz\\|csv\\|m\\|R"
         :include (".htaccess")
         :publishing-directory "~/public_html/"
         :recursive t
         :publishing-function org-publish-attachment
         )

        ("org-notes"
         :base-directory "~/www/org/"
         :base-extension "org"
         :publishing-directory "~/public_html/org/"
         :recursive t
         :exclude ".*-reveal\.org"        ; exclude org-reveal slides 
         :publishing-function org-html-publish-to-html
         :headline-levels 2               ; Just the default for this project.
         :auto-sitemap t                  ; Generate sitemap.org automagically...
         :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
         :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.
         :with-creator nil    ; Disable the inclusion of "Created by Org" in the postamble.
         :with-email nil      ; Disable the inclusion of "(your email)" in the postamble.
         :with-author nil       ; Enable the inclusion of "Author: Your Name" in the postamble.
         :auto-preamble t;         ; Enable auto preamble 
         :auto-postamble t         ; Enable auto postamble 
         :table-of-contents t        ; Set this to "t" if you want a table of contents, set to "nil" disables TOC.
         :toc-levels 2               ; Just the default for this project.
         :section-numbers nil        ; Set this to "t" if you want headings to have numbers.
         :html-head-include-default-style nil ;Disable the default css style
         :html-head-include-scripts nil ;Disable the default javascript snippet
         :html-head "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n<link rel=\"stylesheet\" type=\"text/css\" href=\"http://www.i3s.unice.fr/~malapert/css/worg.min.css\"/>\n<script type=\"text/javascript\" src=\"http://www.i3s.unice.fr/~malapert/js/ga.min.js\"></script>" ;Enable custom css style and other tags
         :html-link-home "index.html"    ; Just the default for this project.
         :html-link-up "../index.html"    ; Just the default for this project.
         )

        ("org-static"
         :base-directory "~/www/org/"
         :base-extension "html\\|xml\\|css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|zip\\|gz\\|csv\\|m\\|R"
         :publishing-directory "~/public_html/org/"
         :recursive t
         :publishing-function org-publish-attachment
         :exclude "Rplots.pdf"
         )

        ("org" 
         :components ("org-notes" "org-static" "html-static")
         )

        ("_org-notes"
         :base-directory "~/www/_org/"
         :base-extension "org"
         :publishing-directory "~/private_html/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 2               ; Just the default for this project.
         :auto-preamble t
         :auto-sitemap nil                  ; Do NOT Generate sitemap.org automagically...
         :with-creator nil    ; Disable the inclusion of "Created by Org" in the postamble.
         :with-email nil      ; Disable the inclusion of "(your email)" in the postamble.
         :with-author nil       ; Enable the inclusion of "Author: Your Name" in the postamble.
         :auto-preamble t;         ; Enable auto preamble 
         :auto-postamble t         ; Enable auto postamble 
         :table-of-contents t        ; Set this to "t" if you want a table of contents, set to "nil" disables TOC.
         :toc-levels 2               ; Just the default for this project.
         :section-numbers nil        ; Set this to "t" if you want headings to have numbers.
         :html-head-include-default-style nil ;Disable the default css style
         :html-head-include-scripts nil ;Disable the default javascript snippet     
         :html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"http://www.i3s.unice.fr/~malapert/css/worg.min.css\"/>" ;Enable custom css style
         )

        ("_org-static"
         :base-directory "~/www/_org/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|zip\\|gz"
         :publishing-directory "~/private_html/"
         :recursive t
         :publishing-function org-publish-attachment
         :exclude "Rplots.pdf"
         )

        ("_org" 
         :components ("_org-notes" "_org-static")
         )        
        )
      )
CANCELED Globally remove HTML style and scripts
style and scripts are configured via project settings.

(setq org-html-head-include-default-style nil)
(setq org-html-head-include-scripts nil)
Remove validation link
:html-validation-link is not yet available as a projects setting in Org-mode 8.2.

(setq org-html-validation-link nil)
MathJax CDN
The defaults use an old MathJax version

(setf org-html-mathjax-options
      '((path "https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML")
        (scale "100") 
        (align "center") 
        (indent "2em")
        (mathml nil))
      )
(setf org-html-mathjax-template
      "<script type=\"text/javascript\" src=\"%PATH\"></script>")
Table
I prefer to rely on CSS style rather than on HTML attributes that are not supported anymore in HTML5.

(setq org-html-table-default-attributes
      '(:border "0" :cellspacing "0" :cellpadding "6" :rules "none" :frame "none"))
TODO Force relative links
MELPA + org-reveal
(require 'ox-reveal)
References
http://orgmode.org/worg/org-configs/org-customization-guide.html
http://orgmode.org/worg/org-tutorials/org-publish-html-tutorial.html
Created: 2019-03-07 jeu. 09:15

Emacs 26.1 (Org mode 9.1.9)