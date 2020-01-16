;;; quickref-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "quickref" "quickref.el" (0 0 0 0))
;;; Generated autoloads from quickref.el

(autoload 'quickref-in-echo-area "quickref" "\
Display quickref about TOPICS in the echo area.

\(fn TOPICS)" t nil)

(autoload 'quickref-in-window "quickref" "\
Display quickref about TOPICS in a window.

Use `quickref-dismiss-window' to hide it again.

\(fn TOPICS)" t nil)

(autoload 'quickref-add-note "quickref" "\
Add quickref about TOPIC labeled LABEL with value NOTE.

\(fn TOPIC LABEL NOTE)" t nil)

(autoload 'quickref-delete-note "quickref" "\
Delete the note about TOPIC with label LABEL.

\(fn TOPIC LABEL)" t nil)

(autoload 'quickref-load-save-file "quickref" "\
If `quickref-save-file' exists, set `quickref-refs' to its contents.

\(fn)" t nil)

(autoload 'quickref-write-save-file "quickref" "\
Write the pretty printed contents of `quickref-refs' to `quickref-save-file'.

\(fn)" t nil)

(autoload 'quickref-describe-refs "quickref" "\
`describe-variable' `quickref-refs'.

\(fn)" t nil)

(autoload 'turn-on-quickref-mode "quickref" "\
Turn on `quickref-mode'.

\(fn)" t nil)

(autoload 'turn-off-quickref-mode "quickref" "\
Turn off `quickref-mode'.

\(fn)" t nil)

(autoload 'quickref-mode "quickref" "\
Quickly display notes you've made to yourself.

\(fn &optional ARG)" t nil)

(defvar quickref-global-mode nil "\
Non-nil if Quickref-Global mode is enabled.
See the `quickref-global-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `quickref-global-mode'.")

(custom-autoload 'quickref-global-mode "quickref" nil)

(autoload 'quickref-global-mode "quickref" "\
Toggle Quickref mode in all buffers.
With prefix ARG, enable Quickref-Global mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Quickref mode is enabled in all buffers where
`turn-on-quickref-mode' would do it.
See `quickref-mode' for more information on Quickref mode.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "quickref" '("quickref-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; quickref-autoloads.el ends here
