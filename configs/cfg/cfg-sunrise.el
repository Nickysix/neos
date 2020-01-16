;;; -*- lexical-binding: t -*-

;; sunrise-commander configuration


(use-package sunrise
  :load-path "~/neos/local/git/sunrise-commander"
  :config
;;  (require 'sunrise)
  (require 'sunrise-buttons)
  (require 'sunrise-checkpoint)
  (require 'sunrise-loop)
  (require 'sunrise-mirror)
  (require 'sunrise-modeline)
  (require 'sunrise-popviewer)
  (require 'sunrise-tabs)
  (require 'sunrise-tree)
  (require 'sunrise-w32))



(provide 'cfg-sunrise)
