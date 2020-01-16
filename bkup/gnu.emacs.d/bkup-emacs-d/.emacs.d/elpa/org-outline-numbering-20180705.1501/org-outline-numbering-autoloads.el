;;; org-outline-numbering-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "org-outline-numbering" "org-outline-numbering.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from org-outline-numbering.el

(autoload 'org-outline-numbering-mode "org-outline-numbering" "\
Minor mode to number ‘org-mode’ headings.

\(fn &optional ARG)" t nil)

(autoload 'org-outline-numbering-display "org-outline-numbering" "\
Put numbered overlays on ‘org-mode’ headings.

\(fn)" t nil)

(autoload 'org-outline-numbering-clear "org-outline-numbering" "\
Clear outline numbering overlays in widened buffer.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-outline-numbering" '("org-outline-numbering-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; org-outline-numbering-autoloads.el ends here
