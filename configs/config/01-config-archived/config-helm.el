(use-package helm
  :ensure t
  :config
  (setq helm-scroll-amount 4 ; scroll 4 lines other window using M-<next>/M-<prior>
        helm-quick-update t ; do not display invisible candidates
        helm-idle-delay 0.01 ; be idle for this many seconds, before updating in delayed sources.
        helm-input-idle-delay 0.01 ; be idle for this many seconds, before updating candidate buffer
        helm-show-completion-display-function #'helm-show-completion-default-display-function
        helm-split-window-default-side 'below ;; open helm buffer in another window
        helm-split-window-inside-p t ;; open helm buffer inside current window, not occupy whole other window
        helm-candidate-number-limit 200 ; limit the number of displayed canidates
        helm-move-to-line-cycle-in-source nil ; move to end or beginning of source when reaching top or bottom of source.
        )
  )
