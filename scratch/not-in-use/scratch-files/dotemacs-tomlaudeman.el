
;; title:Tom Laudeman's .emacs file aka dot emacs file
;; description:Example emacs configuration file with extensive comments and elisp functions.

;; added to make auto-complete work, but probably necessary for other
;; stuff too. Suggest: use $HOME/.emacs.d
(add-to-list 'load-path "/home/twl8n/.emacs.d")
(add-to-list 'load-path "/Users/twl/.emacs.d")
(add-to-list 'load-path "/home/tom.laudeman/.emacs.d")

;; Download a text version at http://defindit.com/readme_files/tom_emacs.txt

;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Just-Spaces.html#Just-Spaces
;; M-x tabify scans the region for sequences of spaces, and converts
;; sequences of at least two spaces to tabs if that can be done
;; without changing indentation. M-x untabify changes all tabs in the
;; region to appropriate numbers of spaces.

(setq-default indent-tabs-mode nil)

;; Skip to "core" for core key bindings.

;; A require that knows how to handle missing packages gracefully.

(defun safe-require (package_name)
  (condition-case err
      ((lambda ()
	 (require package_name)
	 (message "safe-require ok: %s" package_name)
	 ))
    (error
     (message "%s" (error-message-string err))
     )))

;; desktop-files-not-to-save defaults to "\\(^/[^/:]*:\\|(ftp)$\\)"
;; but that breaks tramp saving tramp dired (and tramp files?).
;; Basically, save everything. This could slow down startup.

(setq desktop-files-not-to-save "^$")

;; Two settings to speed up tramp. tramp-verbose defaults to 3. Only
;; set it higher for debugging.

(setq tramp-verbose 0)

;; As far as I know, I don't want emacs doing anything with version
;; control. I certaily don't want tramp running extra commands to
;; check on the version control status of files.

(setq vc-ignore-dir-regexp
      (format "\\(%s\\)\\|\\(%s\\)"
              vc-ignore-dir-regexp
              tramp-file-name-regexp))

;; This helps speed. It might be the new default. Check by using
;; describe-variable. For a one-time test, you can also open a remote
;; dir as /scpc:dev/remote_dir/ and any files opened in that dir will
;; (apparently) be opened with the same method as the dir. Also fast
;; is scpx.

;; (setq tramp-default-method "scpc")

;; Disable auto save for all buffers. I manually disable auto-save
;; when I'm using tramp or sshfs and fuse. Might be better to just
;; eval this by hand rather than have it here. However, I'm typically
;; a compusive saver so I probably won't notice if it disabled.
;; http://www.emacswiki.org/emacs/AutoSave
(setq auto-save-default nil)

;; http://amitp.blogspot.com/2007/03/emacs-move-autosave-and-backup-files.html
;; Running these manually in *scratch* gives:
;; user-temporary-file-directory
;; nil
;; "/var/folders/3M/3M+5Z2l7FtaCjIk8KrqGLU+++TI/-Tmp-/twl/.auto-saves-"
;; ((".*" "/var/folders/3M/3M+5Z2l7FtaCjIk8KrqGLU+++TI/-Tmp-/twl/" t))

;; This didn't work. # files are still saved on the remote with fuse:
;; lrwxrwxrwx  1 tom.laudeman tom.laudeman        26 2012-03-15 10:02 .#rc_notes.php -> twl@hagrid.westell.com.454

;; http://stackoverflow.com/questions/5738170/why-does-emacs-create-temporary-symbolic-links-for-modified-files

;; (defvar user-temporary-file-directory
;;   (concat temporary-file-directory user-login-name "/"))
;; (make-directory user-temporary-file-directory t)
;; (setq auto-save-list-file-prefix
;;       (concat user-temporary-file-directory ".auto-saves-"))
;; (setq auto-save-file-name-transforms
;;       `((".*" ,user-temporary-file-directory t)))

;; http://www.emacswiki.org/emacs/BackupDirectory 

;; This seems to help performance with sshfs fuse file systems by
;; changing some remote operations to local. Also keeps the directory
;; tree cleaner.

(setq
 auto-save-file-name-transforms '((".*" "~/.saves/\\1" t))
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves"))    ; don't litter my fs tree
 delete-old-versions t)

;; this didn't seem to fix the auto save problem.
;; (setq tramp-auto-save-directory "~/.saves")

;; another suggestion
;; Don't clutter with #files either
;; (setq auto-save-file-name-transforms
;;       `((".*" ,(expand-file-name (concat dotfiles-dir "backups")))))

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.saves/" t)

;; Still doesn't stop creation of symlinks of changed files.

;;(safe-require 'inhibit-clash-detection)
;; (setq inhibit-clash-detection t)

;; http://snarfed.org/gnu_emacs_backup_files
;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
;; (custom-set-variables
;;   '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
;;   '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))
;; ;; create the autosave dir if necessary, since emacs won't.
;; (make-directory "~/.emacs.d/autosaves/" t)

;; The term map in char mode. Works

;; (define-key term-raw-map [(control ?a)] 'term-send-raw)

;; (define-key term-raw-map "\M-`" 'other-frame)

;; C-@ .. C-b	term-send-raw
;; C-d .. C-w	term-send-raw
;; C-y .. C-z	term-send-raw
;; C-\ .. DEL	term-send-raw

;; Needs to use the shell mode hoook. shell-file-name, maybe explicit-shell-file-name

;; C-u M-x is more powerful than plain old M-x. Dunno why.

;; C-u M-x apropos-variable RET -mode-map$ RET

;; char mode is term-raw-map. Line mode is term-mode-map.

(defun xf ()
  ""
  (interactive)
  (term-send-raw-string "f"))

(defun my-shell-setup ()
  "Tom's term that really works"

  (local-set-key "\C-x f" 'xf)

  ;; (define-key user-minor-mode-map "\C-x" 'term-send-raw)
  ;; (define-key user-minor-mode-map "\C-p" 'term-send-raw)

  ;;   (suppress-keymap term-raw-map)
  ;;(define-key global-map "\C-x b" 'term-send-eof)
  ;; (local-set-key KEY COMMAND)

  ;; didn't work when the minor mode was disabled
  ;; (local-set-key "\C-x"  'term-send-raw)  

  ;;(local-set-key "\C-p"  'term-send-raw)  

  ;; doesn't work
  ;; (define-key term-raw-map "\C-x" 'term-send-raw)

  ;; doesn't work
  ;; (define-key term-mode-map "\C-x" 'term-send-raw)

  ;; (define-key term-raw-map "\C-c\C-d" 'term-send-raw)
  ;; (define-key term-mode-map "\C-c\C-d" 'term-send-raw)
  (user-minor-mode 0)
  (message "Done running my-shell-setup.")
  )

(add-hook 'term-mode-hook 'my-shell-setup)

;; Weird Mac stuff.
;; http://www.emacswiki.org/emacs/MetaKeyProblems#toc15
;; http://www.emacswiki.org/emacs/CarbonEmacsPackage
;; http://xahlee.info/emacs/emacs_hyper_super_keys.html

;; values: super, hyper, meta, nil

;; Since using define-key here doesn't work, I'm guessing that the
;; super key binding happens after .emacs is loaded.

;; doesn't work 
;;(define-key user-minor-mode-map "s-p" 'down-one)

;; I didn't try global-set-key. Maybe it would work. I switched to
;; define-key and the user-minor-mode-map so that my keybindings would
;; override all the goofy mode maps (like the HTML mode map).
;; (global-set-key [s-p] 'down-one)

(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

;; The daffy Mac and Aquamacs don't read .bash_profile and .bashrc
;; like the rest of the planet. You could go down the rabbit hole
;; http://developer.apple.com/library/mac/#qa/qa1067/_index.html
;; Instead, just get Emacs to add stuff to your path. The Mac GPG
;; tools are in /usr/local/bin.

;; http://lists.gnu.org/archive/html/help-gnu-emacs/2011-04/msg00210.html

(setenv "PATH" (concat "/usr/local/bin" path-separator (getenv "PATH")))

;; http://www.andreas-wilm.com/src/dot.emacs.html
;; This would work too, but has the path separator hard coded.
;; (setenv "PATH" (concat (getenv "PATH") ":/opt/local/bin"))

;; Andreas says: delete next line and you get: *ERROR*: Searching for
;; program: No such file or directory, gpg. 

;; You must open a shell and determine the correct path to gpg
;; manually, then put that path in the line below.

(setq exec-path (append exec-path '("/usr/local/bin")))


(defun safe-require (package_name)
  (condition-case err
      ((lambda ()
	 (require package_name)
	 (message "safe-require ok: %s" package_name)
	 ))
    (error
     (message "%s" (error-message-string err))
     )))

;; New emacs suddenly defaulted to bar instead of box. 
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Cursor-Parameters.html
(setq-default cursor-type 'box) 

; Set cursor color
(set-cursor-color "#660099")

;; Show which function the cursor is in.
(which-function-mode t)

;; default the cursor to blinking.
(blink-cursor-mode t)

;; Tell the man-page functions woman* to open documents in the same
;; frame, not a new frame.
(setq woman-use-own-frame nil)

;; http://www.nongnu.org/emacs-tiny-tools/keybindings/index-body.html
;; Does not work in gnu emacs 23.1.1
;; (setq delete-key-deletes-forward t)

;; Save/restore desktop from the launch directory. Normally you
;; disable at launch with --no-desktop, but I've added code below to
;; do things a little differently.
;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Saving-Emacs-Sessions.html

;; Alternate convention for desktop saving. If .emacs.desktop exists,
;; then go into desktop-save-mode, otherwise not. For dirs where I
;; want a desktop file, I'll run the "touch .emacs.desktop" before
;; starting emacs. Most dirs I don't want a desktop.

;; If your messages say: 'Wrong type argument: listp, "."' then the
;; problem is that desktop-path is "." instead of the correct '(".")
;; and the error is coming from desktop-read, not
;; desktop-save-mode. Emacs automatically calls desktop-read at some
;; point after reading the .emacs file. The late call makes the
;; problem difficult to debug since the error message doesn't give
;; hints as to what code generated it. I had a condition-case around
;; desktop-save-mode, but that didn't do anything because the error
;; was later.

(if (file-exists-p ".emacs.desktop")
    (progn (setq desktop-path '("."))
	   (desktop-save-mode 1)
	   )
  )

;; Edifying code fragments. Not useful:

;; (condition-case err
;;     (desktop-save-mode 1)
;;   (error (message "error: %s" (error-message-string err)))
;;   )

;; More useful, but pointless once you know that desktop-read is
;; emitting the error:

;; (condition-case err
;;     (desktop-read)
;;   (error (message "error: %s" (error-message-string err)))
;;   )

(if (file-exists-p ".emacs.desktop")
   (progn (setq desktop-path '("."))
	   (desktop-save-mode 1)
	   )
 )

;; Enable auto-complete mode
(add-to-list 'load-path "/home/twl8n/.emacs.d")
(add-to-list 'load-path "/Users/twl/.emacs.d")
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "/home/twl8n/.emacs.d/ac-dict")
  (ac-config-default)
  (ac-set-trigger-key "TAB"))

;; (load "nxhtml/autostart")

(safe-require 'undo-tree)

(safe-require 'multi-term)

;; This works, but my new func safe-require is better.

;; (when (require 'undo-tree nil t)
;;   (princ "undo-tree loaded")
;;   )

; Replace $RSENSE_HOME with the directory where RSense was installed in full path
;; Example for UNIX-like systems
;; (setq rsense-home "/home/tomo/opt/rsense-0.2")
;; or
;; (setq rsense-home (expand-file-name "~/opt/rsense-0.2"))
;; Example for Windows
;; (setq rsense-home "C:\\rsense-0.2")
(setq rsense-home "/home/twl8n/opt")
(add-to-list 'load-path (concat rsense-home "/etc"))
(safe-require 'rsense)


;; EasyPG is part of Emacs from v 22 on (or is that 23?), so don't
;; enable it, and absolutely do not install the standalone. Installing
;; the standalone breaks the internal functions.

;; Enable downcase-region. I don't know why this would be disabled by
;; default, but it is. Something about "confusing to new users". I
;; don't have it bound to a key, but I use it, especially in keyboard
;; macros, so it needs to be working.
(put 'downcase-region 'disabled nil)

;; Skip the startup "message", which looks like a "screen" or
;; "splash". Whatever. This makes it not appear.
(setq inhibit-startup-message t)

;; Not sure what these skip, but I doubt I want to see the splash or
;; startup screen.
;; Non-nil inhibits the startup screen.
;; It also inhibits display of the initial message in the `*scratch*' buffer.
(setq inhibit-startup-screen t)
(setq inhibit-splash-screen t)

;; http://www.emacswiki.org/emacs/CuaMode
;; http://www.gnu.org/software/emacs/manual/html_node/emacs/CUA-Bindings.html
;; New register binding are added to cua mode because C-x conflicts
;; with the normal register commands. Use C-1 C-c to copy to register
;; 1. Use C-1 C-v to paste the contents of register 1. M-x
;; copy-to-register still works.
(condition-case err
    (cua-mode t)
  (error ))

;; Don't tabify after rectangle commands
(setq cua-auto-tabify-rectangles nil)

;; No region when it is not highlighted
(transient-mark-mode 1) 

;; Standard Windows behaviour is t, but since I usually use a C-x
;; command immediately after copy, I have it set to nil
(setq cua-keep-region-after-copy nil)

;; Makes killing/yanking interact with X clipboard and X11 selection. There
;; are several other settings that deal wit the "X selection" which is
;; not quite the same as the X clipboard.
;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Cut_002fPaste-Other-App.html
(setq x-select-enable-clipboard t)  

;; Enable ido-mode for fancy completion on buffer switch and file
;; open. We don't seem to need the require 'ido in recent versions of
;; Emacs.  http://www.emacswiki.org/cgi-bin/wiki/InteractivelyDoThings
(condition-case err
    (ido-mode t)
  (error ))

;; Tell emacs that read-only files whether write protected on disk or
;; set to read-only via toggle-read-only are *not* editable.  The
;; normal "can't edit" was broken somewhere around version 22.1.1 and
;; now it insists on using the version control system (which doesn't
;; work either).
(setq view-mode-only t)

;; Disable the damnable hard to read colorized source code, aka syntax
;; highlighting aka font lock mode.  Automatically becomes
;; buffer-local when set in any fashion, so you have to use the global
;; version of the function. For more info do describe-function on
;; font-lock-mode (Yes, there is a variable and a function with the
;; same name, apparently.) This does not work: (setq font-lock-mode
;; nil) Emacs gets upset when calling the function
;; global-font-lock-mode with an arg nil, so I call it with zero and
;; that's fine. All this time I thought nil was a value.

;; Later, I decided to bind the toggle to a key. Therefore the default
;; is on, but I generally turn it off with C-xt.

;; (global-font-lock-mode nil)
;; (global-font-lock-mode 0)

;; This works.
(setq font-lock-global-modes '(not perl-mode))

;; js2-mode breaks standard font lock in some new way, but is easily fixed.
;; http://steve-yegge.blogspot.com/2008/03/js2-mode-new-javascript-mode-for-emacs.html
(setq js2-use-font-lock-faces t)

;; This works now that the defun is correct. Don't need it, but I've
;; left it here for historical purposes.
;; (defun turn-off-font-lock ()
;;    "Disable font-lock-mode"
;;  (interactive)  
;;    (font-lock-mode nil))
;; (add-hook 'perl-mode-hook 'turn-off-font-lock)

;; Paste (yank) at the text cursor location, not at the 
;; location of the mouse pointer. This only applies to graphical (X)
;; emacs sessions. 
(setq mouse-yank-at-point t)

;; Disable the nasty zmacs region highlighting in xemacs. Having it on
;; breaks mark-search-cut behavior. 
(setq zmacs-regions nil)

;; Uncomment to automatically load ispell at startup.
;(load "ispell")

;; Uncomment for hexl 
;(autoload 'hexl-find-file "hexl" "Edit file FILENAME in hexl-mode." t)
;(define-key global-map "\C-c\C-h" 'hexl-find-file)

;; Uncomment if you like lots of backup versions
;(setq version-control t)

;; Stop emacs from automatically converting end of line characters.
;; Auto converting Windows or Mac eol to Linux eol can be really, really
;; confusing.
(setq inhibit-eol-conversion t)

;; Prevent loading default.el. 
(setq inhibit-default-init 1)

;; valid values for require-final-newline
;; nil
;; t
;; (quote query)
(setq require-final-newline nil)


;; http://stackoverflow.com/questions/683425/globally-override-key-binding-in-emacs
;; I think this allows my preferred mode map to continue working when
;; other minor modes are active. See my user-minor-mode-map define-key
;; bindings below.

(defvar user-minor-mode-map (make-sparse-keymap) "user-minor-mode keymap.")

(define-minor-mode user-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t
  " user-keys"
  'user-minor-mode-map)


;; Turn user-minor-mode on/off 1/0 in the mini-buffer.
;; Oct 5 2009 Was 1 which was clearly a mistake. 

(defun user-minibuffer-setup-hook ()
  (user-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'user-minibuffer-setup-hook)

(user-minor-mode 1)

;; Default is to center text. Too close to M-C-s and I never use
;; it. Disable.  In a lisp eval window, it didn't like the usual
;; shortcuts for Meta, so I just inserted an escape char.
;; (define-key user-minor-mode-map "s" 'noop)

;; Make the "delete" key in the cursor key (aka key pad) area perform
;; a forward delete, backspace (the key above \) performs a backward
;; delete. Sadly, [delete] and [kp-delete] can be different and can be
;; aliased to something else, therefore you must re-bind them
;; separately. (Apple in their bizarre wisdom have written "delete" on
;; the backspace key.)

;; Using the syntax (square brackets): [delete], [DEL], and [\d] did
;; not work.

;; Do not use "\d" because \d is some weird alias for whatever Emacs
;; thinks is the local definition of the delete key. That local
;; definition is often wrong.

;; (define-key global-map "\d" 'delete-char)

;; For Aquamacs and anything else, meta backtick switches Emacs frames
;; ala meta-tab switching windows.
(define-key global-map "\M-`" 'other-frame)

(define-key global-map [delete] 'delete-char)
(define-key global-map [kp-delete] 'delete-char)
(define-key global-map [backspace] 'backward-delete-char)

;; The global-map is overridden by the minibuffer-local-map. When I
;; fixed the stupid Mac delete, it broke backspace in the
;; minibuffer. This fixes both keys for the minibuffer.

(define-key minibuffer-local-map [delete] 'delete-char)
(define-key minibuffer-local-map [kp-delete] 'delete-char)
(define-key minibuffer-local-map [backspace] 'backward-delete-char)

(define-key isearch-mode-map '[backspace] 'isearch-delete-char)


(defun noop ()
  "Placeholder for noop key bindings."
  (interactive)
  (message "key not defined")
  )

;; Unset certain undo bindings that are irritating to hit accidentally.

;; (define-key user-minor-mode-map "\C-_" 'noop)
;; (define-key user-minor-mode-map "\C-\\" 'noop)

;; I think this works now that the key spec is correct. Old comment:
;; none of this works to absolutely map my keys. other modes are
;; taking over my key mapping

(defun beginning-of-defun-one ()
  "beginning of inner defun or function"
  (interactive)
  (beginning-of-defun 1))

(defun end-of-defun-one ()
  "end of inner defun or function"
  (interactive)
  (end-of-defun 1))

;; Core key bindings below. 

;; This seems to work.
(global-set-key "\C-[t" 'noop)

;; This seems to work too, and uses the (kbd) macro which seems handy.
(global-unset-key (kbd "M-k"))

;; This seems to work too, although it rebinds the key to noop, and
;; global-unset-key can't unbind what this does.
(define-key global-map "\C-[t" 'noop)
(define-key user-minor-mode-map  "\C-[t" 'noop)

(define-key user-minor-mode-map "\C-[\C-a" 'beginning-of-defun-one)
(define-key user-minor-mode-map "\C-[\C-e" 'end-of-defun-one)
;; (global-set-key "\C-[\C-a" 'beginning-of-defun-one)

(define-key user-minor-mode-map "\C-[i" 'force-indent)
(define-key user-minor-mode-map [delete] 'delete-char)
(define-key user-minor-mode-map [kp-delete] 'delete-char)
(define-key user-minor-mode-map [backspace] 'backward-delete-char)

(define-key user-minor-mode-map "\C-x\C-d" 'dired)
(define-key user-minor-mode-map "\C-xt" 'font-lock-mode)
(define-key user-minor-mode-map "\C-[#" 'comment-region)
(define-key user-minor-mode-map "\C-x#" 'comment-region)
(define-key user-minor-mode-map "\C-s" 'search-forward)
(define-key user-minor-mode-map "\C-r" 'search-backward)
(define-key user-minor-mode-map "\C-x\C-n" 'next-error)
(define-key user-minor-mode-map "\C-x\C-p" 'previous-error)
(define-key user-minor-mode-map "\C-xc" 'compile)
(define-key user-minor-mode-map "\C-h" 'backward-delete-char)

(define-key user-minor-mode-map "\C-[g" 'goto-line)
(define-key user-minor-mode-map "\C-xn" 'other-window)
(define-key user-minor-mode-map "\C-[q" 'query-replace)
(define-key user-minor-mode-map "\C-xf" 'find-file)
(define-key user-minor-mode-map "\C-[\C-[" 'repeat-complex-command)
(define-key user-minor-mode-map "\C-[r" 'replace-string)
(define-key user-minor-mode-map "\C-[f" 'fill-paragraph)
(define-key user-minor-mode-map "\C-z" 'advertised-undo)

;; Setting keys to nil did not work. They still kept their default
;; actions.  C-S-backspace is control-shift-backspace. I hit
;; C-backspace accidentally which was confusing.

(define-key user-minor-mode-map [C-S-backspace] 'delete-backward-char) 
(define-key user-minor-mode-map [C-backspace] 'delete-backward-char)
(define-key user-minor-mode-map [M-backspace] 'delete-backward-char)
(define-key user-minor-mode-map [insert] nil)
(define-key user-minor-mode-map [insertchar] nil)
;; Standard bind is to recenter-top-bottom. 
(define-key user-minor-mode-map "\C-l" 'recenter)

;; Stupid xemacs can't grok "\C-[\C-[" so re-purpose C-x[ It
;; normally means page up, but I always use something else for page up.
;; (define-key user-minor-mode-map "\C-x\["
;;  'repeat-complex-command) (global-set-key "\C-x\["
;;  'repeat-complex-command)

;;  Use a new function for page up and page down.
;;  This one will place the cursor on the line where you started if
;;  you do the opposite. The default Emacs scroll-up and scroll-down
;;  don't return the cursor to the same line. That's bad.
;;  This still doesn't work quite right if you hit the top or bottom of the buffer.
;;  That could be fixed by remembering how far the last scroll was, and
;;  reversing when necessary. 

(define-key user-minor-mode-map "\C-[a" 'backward-screen)
(define-key user-minor-mode-map "\C-[z" 'forward-screen)
(define-key user-minor-mode-map [(prior)]   'backward-screen)
(define-key user-minor-mode-map [(next)]   'forward-screen)
(define-key user-minor-mode-map "\C-[p" 'down-one)
(define-key user-minor-mode-map "\C-[n" 'up-one)
(define-key user-minor-mode-map "\C-p" 'down-one)
(define-key user-minor-mode-map "\C-n" 'up-one)
(define-key user-minor-mode-map "\C-xp" 'scroll-style)


;; doesn't work 
;;(define-key user-minor-mode-map "s-p" 'down-one)

;;  Remap the danged downcase-region keys
;;  because I'm always hitting these instead of C-l
;;  C-xl might be ok. Consider commenting it out, even 
;;  though l is for "lower" which isn't the command. It should
;;  be d for "downcase". 
(define-key user-minor-mode-map "\C-[l" 'recenter)
(define-key user-minor-mode-map "\C-x\C-l" 'recenter)


;;  Use new kdb syntax available as of 19.30
;;  http://tiny-tools.sourceforge.net/emacs-keys.html

;;  None of these work in -nw
;; ;(define-key user-minor-mode-map (kbd "C-S-N") 'up-one)
;; ;(define-key user-minor-mode-map (kbd "C-S-P") 'down-one)
;; ;(global-set-key [(control shift n)] 'up-one)
;;  (list ?C-S-n (type-of ?C-S-n)) 
;;  (list ?C-n (type-of ?C-n)) 
;; ;;(define-key user-minor-mode-map (kbd "C-N") 'up-one)
;; ;;(define-key user-minor-mode-map (kbd "C-P") 'down-one)

(defun forward-screen ()
  "scroll down one screen in display."
  (interactive)
  (forward-line (- (window-height) 2)))

(defun backward-screen ()
  "scroll down one screen in display."
  (interactive)
  (forward-line (- (- (window-height) 2))))

;;  sep 19 2008 Could bind unindent and force-indent to keys, or just
;;  create a keyboard macro everytime I need one of them.

(defun unindent ()
  ;; remove whitespace from the beginning of a line
  (interactive)
  (beginning-of-line)
  (re-search-forward "^[ 	]*")
  (replace-match "")
  )

(defun force-indent ()
  "remove leading whitespace and insert a tab"
  (interactive)
  (unindent)
  (indent-relative)
  ;; (insert "	")
  )


;;  man page mode uses one of my favorite key bindings.  over load
;;  it's function with mine. Switching my key bindings to
;;  user-minor-mode-map may have fixed this.

(defun Man-next-manpage ()
  "overload"
  (interactive)
  (up-one))

(defun Man-previous-manpage ()
  "overload"
  (interactive)
  (down-one))

;; sep 15 2011 Make all scrolling up and down go through up-one and
;; down-one and use a var and function to toggle whether or not
;; scrolling is normal cursor move, or scrolling the screen and
;; keeping the cursor in the middle.

;; default to normal (traditional scrolling) style


;; http://scottmcpeak.com/elisp/scott.emacs.el

;; (defun line-of-position (pos)
;;   "Return the 1-based line number of the given position."
;;   (count-lines (point-min)
;;                (if (>= pos (point-max))
;;                    (point-max)
;;                    (+ pos 1))
;;   ))

(setq scroll-style-flag nil)

(defun scroll-style ()
  "Toggle between screen and line scrolling."
  (interactive)
  (setq scroll-style-flag (not scroll-style-flag))
  (message (format "scroll-style set to %s" scroll-style-flag ))
  )

(defun up-one ()
  "scroll text up one line in display, or cursor one line down."
  (interactive)
  (let ((sd_ok nil))
    ;; scroll-up moves the cursor if the cursor is at line 1. If we
    ;; don't compensate then next-line below will also move the curosr
    ;; and we'll move 2 lines, but only on line 1.
    (if (and scroll-style-flag (> (line-number-at-pos) (line-number-at-pos (window-start))))
	(condition-case err
	    (progn
	      (scroll-up 1)
	      (setq sd_ok t)
	      ;; (message "scroll text")
	      )
	  ;;(error (message "err"))
	  )
      )
    ;; always move the cursor by one line
    ;; (message "next line")
    (next-line 1)
    (if sd_ok (recenter))
    )
  )


(defun down-one ()
  "scroll text down one line in display, or cursor one line up."
  (interactive)
  (let ((sd_ok nil))
    (if scroll-style-flag
	(condition-case err
	    (progn
	      (scroll-down 1)
	      (setq sd_ok t)
	      ;; (message "scroll text down")
	      )
	  ;; scroll-down is subtly different from scroll-up and this
	  ;; error trap is necessary so that errors in scroll-down
	  ;; don't cause the defun to simply exit. We need the rest of
	  ;; the defun to finish, even if scroll-down threw an error.
	  (error ())
	  )
      )
    ;; always move the cursor by one line
    ;; (message "prev line")
    (previous-line 1)
    (if sd_ok (recenter))
    )
  )


;;http://code.google.com/p/js2-mode/wiki/InstallationInstructions

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; somehow nxhtml overrides the php setting. Investigate.
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

(setq auto-mode-alist (cons (cons "\\.java$" 'c-mode) auto-mode-alist))
(setq auto-mode-alist (cons (cons "\\.cgi$" 'perl-mode) auto-mode-alist))

(put 'upcase-region 'disabled nil)

(setq debug-on-error nil)

;; http://stackoverflow.com/questions/2081577/setting-emacs-split-to-horizontal
;; Stop the window from splitting vertically. For example, when
;; compiling, I want the window split horizontally with code on top
;; and compile results on the bottom.

(setq split-height-threshold 0)
(setq split-width-threshold 0)

 ; This is an example of keyboard rebinding on the Macintosh.
 ; I've preserved this for historical interest only.
 ; It makes these assignments:
 ;   F5 splits the display vertically
 ;   F6 enlarges the window containing the cursor
 ;   F7 shrinks the window containing the cursor
 ;   F8 eliminates all split windows
 ; See the file ~/lisp/mac/Macintosh-win.el for the codes to define other keys.

 ;; (setq mac-raw-map-hooks
 ;; 	  (list
 ;; 	   '(define-key mac-raw-map "\040" 'split-window-vertically)
 ;; 	   '(define-key mac-raw-map "\041" 'enlarge-window)
 ;; 	   '(define-key mac-raw-map "\042" 'shrink-window)
 ;; 	   '(define-key mac-raw-map "\044" 'delete-other-windows)))


;; No idea what this was supposed to do.
;; (put 'upcase-region 'disabled nil)

;; The code below (when uncommented) creates an irritating bug in that
;; it overrides custom-font-faces when first loaded, but allows
;; custom-font-faces to work when loaded via load-file. I'm fairly
;; certain the the code below was a poor work-around for default font
;; loading.

;; (assq-delete-all 'font default-frame-alist)
;; (add-to-list
;;  'default-frame-alist
;;  '(font . "-Adobe-Courier-Medium-R-Normal--17-120-100-100-M-100-ISO8859-1"))

;; The font below was present in Fedora 6, but not in Fedora 8
;; Why did the available fonts change?
;;   '(font . "-Adobe-Courier-Medium-R-Normal--14-140-75-75-M-90-ISO8859-1"))


;; In customization group Editing Basics, Line Move Visual controls
;; whether or not the cursor moves to logical lines or visual
;; lines. The difference is for continuation lines, the visual line is
;; the next line on the screen. The logical line is the next actual
;; line in the file, and not necessarily what is "visual" on the
;; screen. This should not be confused with visual line mode.

;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Continuation-Lines.html
;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Visual-Line-Mode.html#Visual-Line-Mode

;; Keywords: line wrap, wrapping, continuation, visual, logical,
;; cursor, cursor jump, cursor skip, skip line, skip continuation,
;; wrapped lines, continuation lines, line continuation, line
;; continuation mode, cursor movement mode, cursor mode, next line,
;; next logical line, skip to logical line, cursor move, line visual
;; move, line-move-visual, move logical, logical lines

;; http://braeburn.aquamacs.org/code/master/aquamacs/doc/AquamacsHelp/node40.html
;; Starting around version 23.3.50 the default seems to have change to
;; some kind of wrapping for text files.
(setq auto-word-wrap-default-function nil)


(condition-case err
    (custom-set-variables
     ;; custom-set-variables was added by Custom.
     ;; If you edit it by hand, you could mess it up, so be careful.
     ;; Your init file should contain only one such instance.
     ;; If there is more than one, they won't work right.
     '(cua-mode t nil (cua-base))
     '(ess-S-assign "_")
     '(ido-everywhere t)
     '(ido-show-dot-for-dired t)
     '(line-move-visual nil)

     ;; term-bind-key-alist and term-unbind-key-list only apply to
     ;; multi-term.el.

     '(term-bind-key-alist
       (quote (
	       ("C-c C-x b" . switch-to-buffer)
	       ("C-c M-x" . execute-extended-command)
	       ("C-c C-c" . term-interrupt-subjob)
	       ;; M-` is very Mac-ish and may not the best key binding on other systems
	       ("M-`". other-frame)
	       ("C-m" . term-send-raw)
	       )
	      )
       )
     '(term-unbind-key-list (quote ("C-c")))
     )
  (error ))

;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil :background nil :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 136 :width normal :foundry "urw" :family "Nimbus Mono L")))))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "White" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 160 :width normal :foundry "apple" :family "Monaco")))))


(put 'upcase-region 'disabled nil)

;;http://code.google.com/p/js2-mode/wiki/InstallationInstructions

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;; somehow nxhtml overrides the php setting. Investigate.
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(setq auto-mode-alist (cons (cons "\\.java$" 'c-mode) auto-mode-alist))
(setq auto-mode-alist (cons (cons "\\.cgi$" 'perl-mode) auto-mode-alist))
