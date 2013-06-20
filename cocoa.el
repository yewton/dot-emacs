;; CommandとOptionを入れ替える
(defvar ns-command-modifier)
(defvar ns-alternate-modifier)
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; font
(create-fontset-from-ascii-font "Ricty-14:weight=normal:slant=normal" nil "ricty")
(set-fontset-font "fontset-ricty"
                  'unicode
                  (font-spec :family "Ricty" :size 14)
                  nil
                  'append)
(add-to-list 'default-frame-alist '(font . "fontset-ricty"))
