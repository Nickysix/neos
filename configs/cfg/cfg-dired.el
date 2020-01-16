;;; -*- lexical-binding: t -*-




;; Keep dired buffers updated when the file system changes.
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)


(use-package dired
  :ensure nil
  :custom
  (dired-recursive-copies 'always)
  (dired-recursive-deletes 'always)
  (dired-isearch-filenames 'dwim)
  (delete-by-moving-to-trash t)
  (dired-listing-switches "-AFhlv --group-directories-first")
  (dired-dwim-target t)
  :hook
  (dired-mode . dired-hide-details-mode)
  (dired-mode . hl-line-mode)
  :bind (("s-d" . dired)
         ("s-D" . dired-other-window)))

(use-package dired+
  :load-path "~/neos/local/dired+.el"
  :after dired)

(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)



(use-package all-the-icons-dired
  :ensure t
  :after all-the-icons dired 
  :init
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

(use-package find-dired
  :after dired
  :custom
  (find-ls-option ;; applies to `find-name-dired'
   '("-ls" . "-AFhlv --group-directories-first"))
  (find-name-arg "-iname"))



(use-package dired-narrow
  :ensure t
  :after dired
  :custom
  (dired-narrow-exit-when-one-left t)
  (dired-narrow-enable-blinking t)
  (dired-narrow-blink-time 0.3)
  :bind (:map dired-mode-map
              ("M-s n" . dired-narrow)))


(use-package wdired
  :after dired
  :init
  (setq wdired-allow-to-change-permissions t)
  (setq wdired-create-parent-directories t))



(use-package peep-dired
  :ensure t
  :after dired
  :bind (:map dired-mode-map
              ("P" . peep-dired))
  :custom
  (peep-dired-cleanup-on-disable t)
  (peep-dired-ignored-extensions
   '("mkv" "webm" "mp4" "mp3" "ogg" "iso")))

;; ;; use this for peep always on
;; (setq peep-dired-enable-on-directories t)



(use-package image-dired
  :custom
  (image-dired-external-viewer "xdg-open")
  (image-dired-thumb-size 80)
  (image-dired-thumb-margin 2)
  (image-dired-thumb-relief 0)
  (image-dired-thumbs-per-row 4)
  :bind (:map image-dired-thumbnail-mode-map
              ("<return>" . image-dired-thumbnail-display-external)))


(use-package dired-subtree
  :ensure t
  :after dired
  :bind (:map dired-mode-map
              ("<tab>" . dired-subtree-toggle)
              ("<C-tab>" . dired-subtree-cycle)
              ("<S-iso-lefttab>" . dired-subtree-remove)))


(use-package dired-sidebar
  :ensure t
  :commands (dired-sidebar-toggle-sidebar))


(use-package dired-x
  :ensure nil
  :after dired
  :bind (("C-x C-j" . dired-jump)
         ("s-j" . dired-jump)
         ("C-x 4 C-j" . dired-jump-other-window)
         ("s-J" . dired-jump-other-window))
  :hook
  (dired-mode . (lambda ()
                  (setq dired-clean-confirm-killing-deleted-buffers t))))


(use-package dired-rsync
  :ensure t
  :bind (:map dired-mode-map
              ("r" . dired-rsync)))


(use-package diredfl
  :ensure t
  :hook (dired-mode . diredfl-mode))


(use-package dired-rainbow
  :ensure t
  :after dired 
  :config
  (progn
    (dired-rainbow-define-chmod directory "#6cb2eb" "d.*")
    (dired-rainbow-define html "#eb5286" ("css" "less" "sass" "scss" "htm" "html" "jhtm" "mht" "eml" "mustache" "xhtml"))
    (dired-rainbow-define xml "#f2d024" ("xml" "xsd" "xsl" "xslt" "wsdl" "bib" "json" "msg" "pgn" "rss" "yaml" "yml" "rdata"))
    (dired-rainbow-define document "#9561e2" ("docm" "doc" "docx" "odb" "odt" "pdb" "pdf" "ps" "rtf" "djvu" "epub" "odp" "ppt" "pptx"))
    (dired-rainbow-define markdown "#ffed4a" ("org" "etx" "info" "markdown" "md" "mkd" "nfo" "pod" "rst" "tex" "textfile" "txt"))
    (dired-rainbow-define database "#6574cd" ("xlsx" "xls" "csv" "accdb" "db" "mdb" "sqlite" "nc"))
    (dired-rainbow-define media "#de751f" ("mp3" "mp4" "MP3" "MP4" "avi" "mpeg" "mpg" "flv" "ogg" "mov" "mid" "midi" "wav" "aiff" "flac"))
    (dired-rainbow-define image "#f66d9b" ("tiff" "tif" "cdr" "gif" "ico" "jpeg" "jpg" "png" "psd" "eps" "svg"))
    (dired-rainbow-define log "#c17d11" ("log"))
    (dired-rainbow-define shell "#f6993f" ("awk" "bash" "bat" "sed" "sh" "zsh" "vim"))
    (dired-rainbow-define interpreted "#38c172" ("py" "ipynb" "rb" "pl" "t" "msql" "mysql" "pgsql" "sql" "r" "clj" "cljs" "scala" "js"))
    (dired-rainbow-define compiled "#4dc0b5" ("asm" "cl" "lisp" "el" "c" "h" "c++" "h++" "hpp" "hxx" "m" "cc" "cs" "cp" "cpp" "go" "f" "for" "ftn" "f90" "f95" "f03" "f08" "s" "rs" "hi" "hs" "pyc" ".java"))
    (dired-rainbow-define executable "#8cc4ff" ("exe" "msi"))
    (dired-rainbow-define compressed "#51d88a" ("7z" "zip" "bz2" "tgz" "txz" "gz" "xz" "z" "Z" "jar" "war" "ear" "rar" "sar" "xpi" "apk" "xz" "tar"))
    (dired-rainbow-define packaged "#faad63" ("deb" "rpm" "apk" "jad" "jar" "cab" "pak" "pk3" "vdf" "vpk" "bsp"))
    (dired-rainbow-define encrypted "#ffed4a" ("gpg" "pgp" "asc" "bfe" "enc" "signature" "sig" "p12" "pem"))
    (dired-rainbow-define fonts "#6cb2eb" ("afm" "fon" "fnt" "pfb" "pfm" "ttf" "otf"))
    (dired-rainbow-define partition "#e3342f" ("dmg" "iso" "bin" "nrg" "qcow" "toast" "vcd" "vmdk" "bak"))
    (dired-rainbow-define vc "#0074d9" ("git" "gitignore" "gitattributes" "gitmodules"))
    (dired-rainbow-define-chmod executable-unix "#38c172" "-.*x.*")
    ))



;; * dired-functions

;; A function for deleting the file being edited.
;; This one is a bit dangerous, even with the yes/no question, so
;; it's not bound to any key by default.
;; Run it using M-x delete-current-buffer-file.

(defun delete-current-buffer-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

;; And a function for renaming the file being edited, bound to C-x C-r.

(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))
(global-set-key (kbd "C-x C-r") 'rename-current-buffer-file)

;; Offer to create parent directories if they do not exist
;; http://iqbalansari.github.io/blog/2014/12/07/automatically-create-parent-directories-on-visiting-a-new-file-in-emacs/
(defun my-create-non-existent-directory ()
  (let ((parent-directory (file-name-directory buffer-file-name)))
    (when (and (not (file-exists-p parent-directory))
               (y-or-n-p (format "Directory `%s' does not exist! Create it?" parent-directory)))
      (make-directory parent-directory t))))

(add-to-list 'find-file-not-found-functions 'my-create-non-existent-directory)




  ;; Extra Dired functionality
(use-package dired-aux
  :ensure nil)

 




(provide 'cfg-dired)















































