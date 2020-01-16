;; * INTERACTIVE-FUNCTIONS

(defun dot-emacs ()
  "dot-emacs you can call via M-x."
  (interactive)
  (find-file "~/.emacs"))

(defun org-refile ()
  "dot-emacs you can call via M-x."
  (interactive)
  (find-file "~/.emacs.d/neos/org/refile.org"))

(global-set-key [(shift f5)] 'org-refile)

