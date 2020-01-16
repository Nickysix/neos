;;; * WRITING-SETTINGS

;; * config-writing.el

(setq sentence-end-double-space nil)

(add-hook 'text-mode-hook 'flyspell-mode)

;; Thesaurus
;; Many of the thesaurus packages use an online service,
;; synosaurus gives you the option of using a local Wordnet install.
;; It also has a nice 'replace word' interface.

;; NOTE: this requires you to install wordnet

(use-package synosaurus
  :ensure t
  :config (progn
            (setq synosaurus-backend 'synosaurus-backend-wordnet)
            (setq synosaurus-choose-method 'default)))

;; Dictionary
;; Since I already use a local Wordnet as a thesaurus,
;; I'm using it for a dictionary as well via the wordnut package.

(use-package wordnut
  :ensure t)

;; A minor mode for a nice writing environment.

(use-package olivetti
  :ensure t
  :config (setq olivetti-body-width 90))


(provide 'config-writing)
