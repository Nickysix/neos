I use artist/picture-mode a lot with org-mode. It provides many tools for sketch. Among them, I use rectangle and line tools most frequently for a flow chart.

From time to time, I have to put some notes within the rectangle (node) so that the chart could be self-explanatory. In such cases, I have to count the characters to make the room and layout for the rectangles, which is very boring.

To simplify the dull job, I defined some advices (see below). Now when I choose the rectangle operation by C-c C-a r, I can start the drawing by just typing the notes and the rectangle grows by itself as I am typing. C-j (by default) is also available for multiple-line notes. In this case, however, the width of the rectangle is set by the last line.



(defvar zwz-rect-text-y-margin 0)
(defvar zwz-rect-text-x-margin 1)
(defadvice picture-self-insert (around zwz-rect-text-insert activate)
  "When using rect tool, we can draw the rectangle by inputing text.
The rectangle will surround the text by a horizontal margin = zwz-rect-text-x-margin
and vertical margin = zwz-rect-text-y-margin, and therefore the text is center-justified"
  (if (and (eq artist-curr-go 'rect) (not artist-key-is-drawing))
      (zwz-start-rect-text-input))
  ad-do-it
  (if (and (eq artist-curr-go 'rect) artist-key-is-drawing)
      (save-excursion
        (artist-next-line (1+ zwz-rect-text-y-margin))
        (artist-forward-char  zwz-rect-text-x-margin))))

(defun zwz-start-rect-text-input ()
  (if (and (> (artist-current-line) zwz-rect-text-y-margin)
           (> (artist-current-column) zwz-rect-text-x-margin)
           (or (null (char-before)) (< (char-before) 33))
           (or (null (char-after)) (< (char-after) 33)))
      (if (not (member last-command-event '(?- ?  ?| ?+ ?/ ?\\ ?= ?:)))
          (let ((last-ch last-command-event))
            (save-excursion
              (zwz-make-sure-one-line-next)
              (artist-previous-line (1+ zwz-rect-text-y-margin))
              (move-to-column (- (artist-current-column) (1+ zwz-rect-text-x-margin)))
              (artist-key-set-point))
            (setq last-command-event last-ch)))))

(defadvice picture-duplicate-line (around zwz-rect-text-newline activate)
  "for multiple-line inputs"
  (if (and (eq artist-curr-go 'rect) artist-key-is-drawing)
      (let ((left-edge (column-number-at-pos (zwz-rect-topleft-corner))))
        (forward-line)
        (zwz-make-sure-one-line-next)
        (move-to-column (+ left-edge 1 zwz-rect-text-x-margin))
        (save-excursion
          (artist-next-line (1+ zwz-rect-text-y-margin))
          (artist-forward-char  zwz-rect-text-x-margin)))
      ad-do-it))

(defun zwz-rect-topleft-corner ()
  "find the top-left corner of the rectangle.
NOTE: it does not always work in a complicated layout"
  (save-excursion
    (let ((found nil)
          (col (current-column)))
      (while (and (not found) (= (forward-line -1) 0))
        (move-to-column col)
        (while (or (member (char-after) '(?- ?=))
                   (and (= (char-after) ?+) (member (char-before) '(?- ?=))))
          (backward-char))
        (if (member (char-after) '(?+ ?/))
            (setq found t)))
      (point))))

(defun zwz-rect-bottomright-corner ()
  (save-excursion
    (let ((found nil)
          (col (current-column)))
      (while (and (not found) (= (forward-line 1) 0))
        (move-to-column col)
        (while (or (member (char-before) '(?- ?=))
                   (and (= (char-before) ?+) (member (char-after) '(?- ?=))))
          (forward-char))
        (if (member (char-before) '(?+ ?\\))
            (setq found t)))
      (point))))

(defun column-number-at-pos (&optional pos)
  (if pos (save-excursion
            (goto-char pos)
            (current-column))
      (current-column)))

(defun zwz-make-sure-one-line-next ()
  "If current line is the bottom line, a new line will open"
  (save-excursion
    (unless (= (forward-line 2) 0)
      (end-of-line)
      (open-line 1))))
