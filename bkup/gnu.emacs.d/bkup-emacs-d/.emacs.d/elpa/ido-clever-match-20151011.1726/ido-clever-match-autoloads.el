;;; ido-clever-match-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "ido-clever-match" "ido-clever-match.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from ido-clever-match.el

(autoload 'ido-clever-match-reset-cache "ido-clever-match" "\
Create a hash table representing the cache.

\(fn)" t nil)

(autoload 'ido-clever-match-enable "ido-clever-match" "\
Enable `ido-clever-match'.

An alternative matcher for ido mode.

The matcher ranks the input against each item by class and then by
some sub-metric within that class if applicable (length difference
between the two strings in the case of `substr', the cumulative
distance of consecutive characters in the case of `flex', whether
the match was case-sensitive or not, etc.).

The match classes are:

`exact'
  Exact matches score the highest and they require an exact string
  match.

`prefix'
  Prefix matches score second highest.  They are treated as a
  special case of `substring' matches and will always rank higher.
  This class differentiates between sub-matches by comparing the
  length of the input and each match: the closer the two numbers
  are, the higher the score will be.

`substring'
  Substring matches score third highest.  This class differentiates
  between sub-matches in the same way that prefix matches do with
  an additional check on the distance between the beginning of the
  string and the first occurrence of the text within that string:
  the further away the substring is from the beginning of the
  string, the lower it will score.

`flex'
  Flex matches score lowest.  This class differentiates between
  sub-matches by computing the cumulative distance of consecutive
  characters: the higher that distance is, the lower the score.

\(fn)" t nil)

(autoload 'ido-clever-match-disable "ido-clever-match" "\
Disable `ido-clever-match`.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ido-clever-match" '("ido-clever-match")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; ido-clever-match-autoloads.el ends here
