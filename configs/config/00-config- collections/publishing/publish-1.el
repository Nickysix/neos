(setq org-publish-project-alist
      '(("mysite"
     :base-directory "~/Documents/web/"
     :base-extension "org"
     :recursive t
     :section-numbers nil
     :table-of-contents nil
     :publishing-directory "/ssh:joel@example.org:~/public_html"
     :style "")
    ("imgs"
     :base-directory "~/Documents/web/imgs/"
     :base-extension "jpg\\|gif\\|png"
     :publishing-directory "/ssh:joel@example.org:~/public_html/imgs"
     :publishing-function org-publish-attachment
     :recursive t)
    ("etc"
     :base-directory "~/Documents/web/"
     :base-extension "css\\|bib\\|el"
     :publishing-directory "/ssh:joel@example.org:~/public_html"
     :publishing-function org-publish-attachment)
    ("docs"
     :base-directory "~/Documents/web/docs/"
     :base-extension "html\\|tex\\|bib"
     :publishing-directory "/ssh:joel@example.org:~/public_html/docs"
     :publishing-function org-publish-attachment)
    ("thewholedamnshow" :components ("mysite" "imgs" "etc" "docs"))))
