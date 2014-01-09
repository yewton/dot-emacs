;; font
(create-fontset-from-ascii-font
 "Ricty-14:weight=normal:slant=normal" nil "ricty")
(set-fontset-font "fontset-ricty"
                  'unicode
                  (font-spec :family "Ricty Discord for Powerline")
                  nil
                  'append)
(add-to-list 'default-frame-alist '(font . "fontset-ricty"))
;;;; cf. http://sourceforge.jp/projects/macemacsjp/lists/archive/users/2011-January/001686.html
(setq face-font-rescale-alist '(".*Ricty.*" . 1.2))
