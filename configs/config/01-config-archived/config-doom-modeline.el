(use-package doom-modeline
  :demand t
  :config
  (doom-modeline-def-segment me/buffer-name
    "The buffer name."
    (concat
     (doom-modeline-spc)
     (doom-modeline--buffer-name)
     (doom-modeline-spc)))
  (doom-modeline-def-segment me/buffer-position
    "The buffer position."
    (let ((active (doom-modeline--active)))
      (propertize (concat (doom-modeline-spc)
                          (format-mode-line "%l:%c")
                          (doom-modeline-spc))
                  'face (if active 'mode-line 'mode-line-inactive))))
  (doom-modeline-mode 1)
  (doom-modeline-def-modeline 'helm
    '(bar helm-buffer-id helm-follow helm-prefix-argument)
    '(helm-number))
  (doom-modeline-def-modeline 'info
    '(bar me/buffer-name info-nodes me/buffer-position selection-info)
    '(irc matches process major-mode workspace-name))
  (doom-modeline-def-modeline 'main
    '(bar me/buffer-name remote-host me/buffer-position checker selection-info)
    '(irc matches process vcs major-mode workspace-name))
  (doom-modeline-def-modeline 'project
    '(bar buffer-default-directory)
    '(irc matches process major-mode workspace-name))
  (setq-default
   doom-modeline-buffer-file-name-style 'relative-to-project
   doom-modeline-enable-word-count t
   doom-modeline-icon t
   doom-modeline-percent-position nil))