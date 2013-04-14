;; PATH の設定
(defvar path-list
  '("/usr/local/bin"
   "/usr/bin"
   "/bin"
   "/usr/sbin"
   "/sbin"
   "/usr/X11/bin"
   "/opt/local/bin"
   "/opt/local/sbin"
   "/usr/local/share/gtags/script"
   "~/.cabal/bin"))
(setenv "PATH"
        (mapconcat #'identity path-list ":"))
(mapc (lambda (path) (add-to-list 'exec-path path)) (reverse path-list))

;; CommandとOptionを入れ替える
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
