;;; -*- lexical-binding: t -*-


;; * DIRED: VARIABLES

(setq
 delete-by-moving-to-trash          t        ; in dired mode
 dired-auto-revert-buffer           t        ; automatically revert buffer
 dired-clean-up-buffers-too         t        ; kill buffers for deleted files
 dired-dwim-target                  t        ; guess target directory
 dired-keep-marker-copy             nil      ; don't mark copied files
 dired-listing-switches             "-GAlh --group-directories-first"
 dired-recursive-copies             'always  ; don't ask me, just do it
 dired-recursive-deletes            'always  ; ^
 image-dired-show-all-from-dir-max-files 127 ; a bit more
 wdired-allow-to-change-permissions t        ; change permissions with Dired
 ztree-dir-filter-list              nil      ; don't hide anything
 ztree-draw-unicode-lines           t)       ; I like Unicode

;; Keep dired buffers updated when the file system changes.
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

(use-package dired-async
  :ensure nil)

(use-package image-dired
  :ensure nil)

(use-package wdired
  :ensure nil)

(use-package ztree
  :ensure t)

(use-package quick-preview
  :ensure t
  :init
  (global-set-key (kbd "C-c q") 'quick-preview-at-point)
  (define-key dired-mode-map (kbd "Q") 'quick-preview-at-point))

(use-package dired-hacks-utils
  :ensure t)

(use-package all-the-icons-dired
  :ensure t
  :init
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))


(use-package dired-narrow
  :ensure t
  :bind (:map dired-mode-map
              ("/" . dired-narrow)))

(use-package dired-column
  :ensure nil
  :bind (:package dired
                  :map dired-mode-map
                  ("o" . dired-column-find-file)))

(use-package dired-subtree
  :bind (:package dired
                  :map dired-mode-map
                  ("<tab>" . dired-subtree-toggle)
                  ("TAB" . dired-subtree-toggle)
                  ("<backtab>" . dired-subtree-cycle)))


(use-package dired-x
  :ensure nil
  :hook ((dired-mode . dired-omit-mode)
         (dired-mode . dired-hide-details-mode))
  :bind (("s-\\" . dired-jump-other-window)
         :package dired
         :map dired-mode-map
         (")" . dired-omit-mode)))


(use-package diredfl
  :ensure t
  :init
  (diredfl-global-mode 1))

(use-package dired-rainbow
  :ensure t
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



;; Shows icons
  (use-package all-the-icons-dired
    :diminish
    :functions (dired-move-to-filename
                dired-get-filename
                my-all-the-icons-dired--display)
    :commands all-the-icons-dired--display
    :custom-face (all-the-icons-dired-dir-face ((t (:foreground nil))))
    :hook (dired-mode . all-the-icons-dired-mode)
    :config
    (declare-function all-the-icons-octicon 'all-the-icons)
    (declare-function all-the-icons-match-to-alist 'all-the-icons)
    (declare-function all-the-icons-dir-is-submodule 'all-the-icons)
    (defun my-all-the-icons-dired--display ()
      "Display the icons of files without colors in a dired buffer."
      (when dired-subdir-alist
        (let ((inhibit-read-only t)
              (remote-p (and (fboundp 'tramp-tramp-file-p)
                             (tramp-tramp-file-p default-directory))))
          (save-excursion
            ;; TRICK: Use TAB to align icons
            (setq-local tab-width 1)
            (goto-char (point-min))
            (while (not (eobp))
              (when (dired-move-to-filename nil)
                (insert " ")
                (let ((file (dired-get-filename 'verbatim t)))
                  (unless (member file '("." ".."))
                    (let ((filename (file-local-name (dired-get-filename nil t))))
                      (if (file-directory-p filename)
                          (let ((icon (cond
                                       (remote-p
                                        (all-the-icons-octicon "file-directory"
                                                               :v-adjust all-the-icons-dired-v-adjust
                                                               :face 'all-the-icons-dired-dir-face))
                                       ((file-symlink-p filename)
                                        (all-the-icons-octicon "file-symlink-directory"
                                                               :v-adjust all-the-icons-dired-v-adjust
                                                               :face 'all-the-icons-dired-dir-face))
                                       ((all-the-icons-dir-is-submodule filename)
                                        (all-the-icons-octicon "file-submodule"
                                                               :v-adjust all-the-icons-dired-v-adjust
                                                               :face 'all-the-icons-dired-dir-face))
                                       ((file-exists-p (format "%s/.git" filename))
                                        (all-the-icons-octicon "repo"
                                                               :height 1.1
                                                               :v-adjust all-the-icons-dired-v-adjust
                                                               :face 'all-the-icons-dired-dir-face))
                                       (t (let ((matcher (all-the-icons-match-to-alist
                                                          file all-the-icons-dir-icon-alist)))
                                            (apply (car matcher)
                                                   (list (cadr matcher)
                                                         :face 'all-the-icons-dired-dir-face
                                                         :v-adjust all-the-icons-dired-v-adjust)))))))
                            (insert icon))
                        (insert (all-the-icons-icon-for-file file :v-adjust all-the-icons-dired-v-adjust))))
                    (insert "\t "))))   ; Align and keep one space for refeshing after operations
              (forward-line 1))))))
    (advice-add #'all-the-icons-dired--display :override #'my-all-the-icons-dired--display))

  ;; Extra Dired functionality
(use-package dired-aux :ensure nil)

  (use-package dired-x
    :ensure nil
    :demand
    :config
    (let ((cmd (cond
                (sys/mac-x-p "open")
                (sys/linux-x-p "xdg-open")
                (sys/win32p "start")
                (t ""))))
      (setq dired-guess-shell-alist-user
            `(("\\.pdf\\'" ,cmd)
              ("\\.docx\\'" ,cmd)
              ("\\.\\(?:djvu\\|eps\\)\\'" ,cmd)
              ("\\.\\(?:jpg\\|jpeg\\|png\\|gif\\|xpm\\)\\'" ,cmd)
              ("\\.\\(?:xcf\\)\\'" ,cmd)
              ("\\.csv\\'" ,cmd)
              ("\\.tex\\'" ,cmd)
              ("\\.\\(?:mp4\\|mkv\\|avi\\|flv\\|rm\\|rmvb\\|ogv\\)\\(?:\\.part\\)?\\'" ,cmd)
              ("\\.\\(?:mp3\\|flac\\)\\'" ,cmd)
              ("\\.html?\\'" ,cmd)
              ("\\.md\\'" ,cmd))))

    (setq dired-omit-files
          (concat dired-omit-files
                  "\\|^.DS_Store$\\|^.projectile$\\|^.git*\\|^.svn$\\|^.vscode$\\|\\.js\\.meta$\\|\\.meta$\\|\\.elc$\\|^.emacs.*")))





(provide 'cfg-dired)















































