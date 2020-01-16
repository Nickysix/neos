(require 'ibuffer)

  ;;replace default with ibuffer. Open i other window, and take me there.
  (global-set-key (kbd "C-x C-b") 'ibuffer-other-window)

  ;;sort on major-mode
  (setq ibuffer-default-sorting-mode 'major-mode)

  (setq ibuffer-saved-filter-groups
        (quote (("default"
                 ("Org" ;; all org-related buffers
                  (mode . org-mode))
                 ;; ("equfitter"
                 ;;  (filename . "equationfitter/"))
                 ("Programming C++" ;; prog stuff not already in MyProjectX
                  (or
                   (mode . c-mode)
                   (mode . c++-mode)
                   ))

                 ("Source Code" ;; non C++ related stuff.
                  (or
                   (mode . python-mode)
                   (mode . emacs-lisp-mode)
                   (mode . shell-script-mode)
                   (mode . f90-mode)
                   (mode . scheme-mode)
                   ;; etc
                   ))

                 ("LaTeX"
                  (or
                   (mode . tex-mode)
                   (mode . latex-mode)
                   (name . ".tex")
                   (name . ".bib")
                   ))

                 ("Text" (name . ".txt"))

                 ("Mail"
                  (or  ;; mail-related buffers
                   (mode . message-mode)
                   (mode . mail-mode)
                   (mode . mime-mode)
;;                   (mode . MIME-mode)

                   ;; etc.; all your mail related modes
                   ))

                 ("Web" (or (mode . html-mode)
                            (mode . css-mode)))

                 ("ERC"   (mode . erc-mode))

                 ;; ("Subversion" (name . "\*svn"))
                 ;; ("Magit" (name . "\*magit"))

                 ("Emacs-created"
                  (or
                   (name . "^\\*")))
                 ))))

  (add-hook 'ibuffer-mode-hook
            (lambda ()
              ;;(ibuffer-auto-mode 1)   ;auto update the buffer-list
              (ibuffer-switch-to-saved-filter-groups "default")))

  ;;Don't show (filter) groups that are empty.
  (setq ibuffer-show-empty-filter-groups nil)
  ;;(autoload 'ibuffer "ibuffer" "List buffers." t)

  ;; keep from warning, twice, about deleting buffers.
  ;; only warn about deleting modified buffers.
  (setq ibuffer-expert t)

