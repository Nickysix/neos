

The load-path specifies where Emacs should look for .el-files (or Emacs lisp files). I have a directory called site-lisp where I keep all extensions that have been installed manually (these are mostly my own projects).


(let ((default-directory (concat user-emacs-directory "site-lisp/")))
  (when (file-exists-p default-directory)
    (setq load-path
          (append
           (let ((load-path (copy-sequence load-path)))
             (normal-top-level-add-subdirs-to-load-path)) load-path))))
