





(add-to-list 'load-path "~/.local/share/icons-in-terminal/") ;; If it's not already done

;;(require 'icons-in-terminal)

;;(insert (icons-in-terminal 'oct_flame)) ; C-h f icons-in-terminal[RET] for more info


(add-to-list 'load-path "~/neos/local/git/sidebar.el/")

(require 'sidebar-utils)
(require 'sidebar)


(global-set-key (kbd "C-x C-f") 'sidebar-open)
(global-set-key (kbd "C-x C-a") 'sidebar-buffers-open)


(provide 'cfg-sidebar)
