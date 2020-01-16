(use-package isearch
  :ensure nil
  :bind
  (("C-S-r" . isearch-backward-regexp)
   ("C-S-s" . isearch-forward-regexp)
   :map isearch-mode-map
   ("<M-down>" . isearch-ring-advance)
   ("<M-up>" . isearch-ring-retreat)
   :map minibuffer-local-isearch-map
   ("<M-down>" . next-history-element)
   ("<M-up>" . previous-history-element))
  :init
  (setq-default
   isearch-allow-scroll t
   lazy-highlight-cleanup nil
   lazy-highlight-initial-delay 0))
