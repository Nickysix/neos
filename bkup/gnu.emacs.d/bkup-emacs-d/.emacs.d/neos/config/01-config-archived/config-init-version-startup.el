(defun prompt-for-empty-emacs ()
  (if (y-or-n-p "Load the evil-mode config? ")
      (load-file "~/.emacs.d/evil-init.el")
    (if (y-or-n-p "Load the classic config? ")
        (load-file "~/.emacs.d/non-evil-init.el")
      (message "No emacs config loaded. "))))

(prompt-for-empty-emacs)
