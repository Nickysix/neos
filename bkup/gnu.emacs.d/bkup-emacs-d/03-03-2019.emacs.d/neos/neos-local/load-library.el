 (defun load-library (library)
       "Load the Emacs Lisp library named LIBRARY.
     This is an interface to the function `load'.  LIBRARY is searched
     for in `load-path', both with and without `load-suffixes' (as
     well as `load-file-rep-suffixes').
     
     See Info node `(emacs)Lisp Libraries' for more details.
     See `load-file' for a different interface to `load'."
       (interactive
        (list (completing-read "Load library: "
                               (apply-partially 'locate-file-completion-table
                                                load-path
                                                (get-load-suffixes)))))
       (load library))