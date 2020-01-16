

This is a fully featured, supposedly awesome, package to edit HTML in Emacs.


(use-package web-mode
  :ensure t
  :mode ("\\.html$" . web-mode))

This improves on the built-in JavaScript syntax highlighting.


(use-package js3-mode
  :ensure t
  :mode ("\\.js$" . js3-mode))


(use-package coffee-mode
  :ensure t
  :mode "\\.coffee$")


(use-package scss-mode
  :ensure t
  :mode "\\.scss$")

Syntax highlighting for json files.


(use-package json-mode
  :ensure t
  :mode "\\.json$")


(use-package nginx-mode
  :ensure t
  :commands (nginx-mode))


(use-package emmet-mode
  :ensure t
  :diminish (emmet-mode . "ε")
  :bind* (("C-)" . emmet-next-edit-point)
          ("C-(" . emmet-prev-edit-point))
  :commands (emmet-mode
             emmet-next-edit-point
             emmet-prev-edit-point))

This package renders HTML in the web browser as you type.


(use-package impatient-mode
  :ensure t
  :diminish (impatient-mode . "ι")
  :commands (impatient-mode))



Tern describes itself as a code analysis engine and this is an implementation to bring it into Emacs.


(use-package tern
  :ensure t
  :diminish tern-mode
  :defer 2
  :config
  (progn
    (add-hook 'js-mode-hook '(lambda () (tern-mode t)))))




Skewer is a JS REPL for JavaScript evaluation.



(use-package skewer-mode
  :ensure t
  :diminish skewer-mode
  :commands (skewer-mode
             skewer-html-mode
             skewer-css-mode
             run-skewer
             skewer-repl
             list-skewer-clients
             skewer-eval-defun
             skewer-eval-last-expression
             skewer-eval-print-last-expression
             skewer-load-buffer
             skewer-bower-load
             skewer-bower-refresh
             skewer-run-phantomjs
             skewer-phantomjs-kill))



Bring node js to Emacs.



(use-package nodejs-repl
  :ensure t
  :commands (nodejs-repl
             nodejs-repl-send-buffer
             nodejs-repl-switch-to-repl
             nodejs-repl-send-region
             nodejs-repl-send-last-sexp
             nodejs-repl-execute
             nodejs-repl-load-file))





Managing node versions with nvm.el.


(use-package nvm
  :ensure t
  :commands (nvm-use
             nvm-use-for))


























































