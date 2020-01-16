(use-package elfeed-org
  :ensure t
  :config
  (progn
    (elfeed-org)
    (setq rmh-elfeed-org-files (list "~/org/website/blogroll.org"))))



;;functions to support syncing .elfeed between machines
;;makes sure elfeed reads index from disk before launching
(defun caolan/elfeed-load-db-and-open ()
  "Wrapper to load the elfeed db from disk before opening"
  (interactive)
  (elfeed-db-load)
  (elfeed)
  (elfeed-search-update--force))

;;write to disk when quiting
(defun caolan/elfeed-save-db-and-bury ()
  "Wrapper to save the elfeed db to disk before burying buffer"
  (interactive)
  (elfeed-db-save)
  (quit-window))



(use-package elfeed
  :ensure t
  :bind (:map elfeed-search-mode-map
              ("q" . caolan/elfeed-save-db-and-bury)))



;;Stores a link to the currently open elfeed post.

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








