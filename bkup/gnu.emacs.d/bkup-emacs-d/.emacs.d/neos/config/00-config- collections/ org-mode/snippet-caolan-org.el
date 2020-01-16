

(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (ledger . t)
    (scheme . t)
    (python . t)
    (dot . t)
    (shell . t)))




Make the lines in the buffer wrap around the edges of the screen.

;; (add-hook 'org-mode-hook #'visual-line-mode)
Hide multiple asterisks in outline mode and indent content to match level.

(add-hook 'org-mode-hook #'org-indent-mode)
Enable spellcheck.

(add-hook 'org-mode-hook 'flyspell-mode)
Display inline images at startup. This can be customized per-file with corresponding #+STARTUP keywords 'inlineimages' and 'noinlineimages'.

(setq org-startup-with-inline-images t)



Install exporter backend for GitHub-flavoured markdown:

(use-package ox-gfm
  :ensure t)


(defun org-elfeed-store-link ()
  "Store a link to an elfeed post's URL."
  (message "org elfeed store link")
  (cond
   ;; storing links to queries
   ((eq major-mode 'elfeed-show-mode)
    (let ((link (elfeed-entry-link elfeed-show-entry))
          (desc (elfeed-entry-title elfeed-show-entry)))
      (org-store-link-props :link link :description desc)
      (print link)
      link))))

(add-hook 'org-store-link-functions 'org-elfeed-store-link)



Enable org-capture hotkey.

(define-key global-map "\C-cc" 'org-capture)

Start with empty capture templates list.

(setq org-capture-templates nil)



(push '("l" "Link" entry (file "~/org/notes.org") "* %a")
      org-capture-templates)


(push `("r" "Respond later" entry (file+headline "~/org/tasks.org" "Capture")
        ,(string-join
          '("* TODO Respond to %:from on %a"
            "  %?"
            "  :LOGBOOK:"
            "  - Captured on %U from %a"
            "  :END:")
          "\n"))
        org-capture-templates)


(push `("t" "Todo" entry (file+headline "~/org/tasks.org" "Capture")
        ,(string-join
          '("* TODO %^{Description}"
            "  %?"
            "  %a"
            "  :LOGBOOK:"
            "  - Captured on %U"
            "  :END:")
          "\n"))
        org-capture-templates)


(push '("n" "Note" entry (file "~/org/notes.org")
        "* %?\nCaptured on %U %a")
      org-capture-templates)


Provide refile targets as paths, so a level 3 headline will be available as level1/level2/level3. Offer completions in hierarchical steps.

(setq org-refile-use-outline-path t)
(setq org-outline-path-complete-in-steps t)


Consider only headings in current buffer for refiling, up to a maximum depth.

(setq org-refile-targets '((nil . (:maxlevel . 3))))
Create any missing parent nodes during refile (after asking for confirmation).

(setq org-refile-allow-creating-parent-nodes 'confirm)
Org-protocol
Use org-protocol to trigger org-mode interactions from external programs. Useful for capturing links from Firefox using the org-mode-capture add-on.

(require 'org-protocol)


Specifying only those files with agenda items and TODO's for faster scanning. The check to exclude paths for missing files is taken from Sacha Chua's config.

(setq org-agenda-files
      (delq nil
            (mapcar (lambda (x) (and (file-exists-p x) x))
                    '("~/org/tasks.org"))))



;; Global keyboard shortcuts

(bind-key "C-c a" 'org-agenda)
(bind-key "C-c l" 'org-store-link)
(bind-key "C-c L" 'org-insert-link-global)
(bind-key "C-c O" 'org-open-at-point-global)

;; Presentations

(use-package ox-reveal
  :ensure t)






