(unless (package-installed-p 'imenu-anywhere)
  (package-refresh-contents)
  (package-install 'imenu-anywhere))
(global-set-key (kbd "C-.") #'imenu-anywhere)
