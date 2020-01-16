(use-package elfeed
  :straight t
  :commands elfeed
  :bind (:map elfeed-search-mode-map
         ("<SPC>" . next-line)
         ("U" . elfeed-unjam)
         :map elfeed-show-mode-map
         ("S-<SPC>" . scroll-down-command))

  :init
  (with-eval-after-load 'helm-exec
    (helm-exec-register-executable 'elfeed 'elfeed))

  (setq elfeed-use-curl t)
  (setq elfeed-log-level 'debug)

  :config
  (with-eval-after-load 'evil
    (add-to-list 'evil-emacs-state-modes 'elfeed-search-mode)
    (add-to-list 'evil-emacs-state-modes 'elfeed-show-mode))

  (set-face-attribute 'elfeed-search-feed-face
                      nil
                      :foreground (face-attribute 'warning :foreground))

  (set-face-attribute 'elfeed-search-tag-face
                      nil
                      :foreground (face-attribute 'success :foreground))

  (set-face-attribute 'elfeed-search-unread-title-face
                      nil
                      :weight 'normal
                      :foreground (face-attribute 'default :foreground))

  (set-face-attribute 'elfeed-search-title-face
                      nil
                      :foreground (face-attribute 'font-lock-comment-face :foreground)))

(use-package elfeed-protocol
  :disabled t
  :after elfeed
  :straight (:host github
             :type git
             :repo "fasheng/elfeed-protocol"
             :fork (:host github :repo "jinnovation/elfeed-protocol" :branch "master"))

  :if (-all-p 'boundp '(jjin/secret/ttrss-domain
                        jjin/secret/ttrss-username
                        jjin/secret/ttrss-pass))
  :init
  (setq elfeed-feeds
        (list (format "ttrss+http://%s:%s@%s" jjin/secret/ttrss-username jjin/secret/ttrss-pass jjin/secret/ttrss-domain)))

  (setq elfeed-protocol-ttrss-categories-as-tags t)

  :config
  (elfeed-protocol-enable))
















