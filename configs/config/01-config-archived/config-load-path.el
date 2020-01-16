(setq user-emacs-directory "~/Developments/src/github.com/Ladicle/dotfiles/common/emacs.d/elisp")

(eval-and-compile
  (setq load-prefer-newer t
        package-user-dir "~/Developments/src/github.com/Ladicle/dotfiles/common/emacs.d/elpa"
        package--init-file-ensured t
        package-enable-at-startup nil)

  (unless (file-directory-p package-user-dir)
    (make-directory package-user-dir t)))
(eval-and-compile
  (setq load-path (append load-path (directory-files package-user-dir t "^[^.]" t))))

(eval-when-compile
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package)
    (package-install 'diminish)
    (package-install 'quelpa)
    (package-install 'bind-key))

  (setq use-package-always-ensure t)
  (setq use-package-expand-minimally t)

  (require 'use-package))
(require 'diminish)
(require 'bind-key)
