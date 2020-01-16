;; * UNDO-TREE

(use-package undo-tree
    :ensure t
    :chords (("uu" . undo-tree-visualize))
    :diminish undo-tree-mode:
    :config
    (global-undo-tree-mode 1))

