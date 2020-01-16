(use-package flyspell
  :defer 1
  :custom
  (flyspell-abbrev-p t)
  (flyspell-issue-message-flag nil)
  (flyspell-issue-welcome-flag nil)
  (flyspell-mode 1))

(use-package flyspell-correct-ivy
  :after flyspell
  :bind (:map flyspell-mode-map
        ("C-;" . flyspell-correct-word-generic))
  :custom (flyspell-correct-interface 'flyspell-correct-ivy))