Sometimes I want to make use of the space occupied by the mode-line. You can hide the mode-line by (setq mode-line-format nil). But it brings problem when you have the frame vertically splitted, as you cannot easily tell which is the current buffer. What I did is setting the height of the mode-line face very small, so that the mode-line turns into a thin line and the font is too small to be seen. Here is the code:



(defvar zwz-mode-line-height 0.8)
(defun restore-mode-line-height ()
  (set-face-attribute 'mode-line nil :height zwz-mode-line-height))
(restore-mode-line-height)
(add-hook 'after-make-frame-hook 'restore-mode-line-height)
(defun toggle-mode-line ()
  (interactive)
  (if (= 0.8 zwz-mode-line-height)
      (setq zwz-mode-line-height 0.1)
      (setq zwz-mode-line-height 0.8))
  (restore-mode-line-height))
