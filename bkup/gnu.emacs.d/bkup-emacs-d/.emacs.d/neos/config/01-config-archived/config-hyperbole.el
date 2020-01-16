(require 'package)
      (setq package-enable-at-startup nil) ;; Prevent double loading of libraries
      (package-initialize)
      (unless (package-installed-p 'hyperbole)
        (package-refresh-contents)
        (package-install 'hyperbole))
      (require 'hyperbole)
