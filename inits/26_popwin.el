(require 'popwin)
(popwin-mode 1)
(customize-set-value
 'popwin:special-display-config
 '(;; Emacs
   help-mode
   (completion-list-mode :noselect t)
   (compilation-mode :noselect t)
   (grep-mode :noselect t)
   (occur-mode :noselect t)
   ("*Pp Macroexpand Output*" :noselect t)
   "*Shell Command Output*"
   ;; VC
   "*vc-diff*"
   "*vc-change-log*"
   ;; Undo-Tree
   (" *undo-tree*" :width 60 :position right)
   ;; Anything
   ("^\\*anything.*\\*$" :regexp t)
   ;; SLIME
   "*slime-apropos*"
   "*slime-macroexpansion*"
   "*slime-description*"
   ("*slime-compilation*" :noselect t)
   "*slime-xref*"
   (sldb-mode :stick t)
   slime-repl-mode
   slime-connection-list-mode
   ("*grep*" :noselect t)
   ("*auto-async-byte-compile*" :noselect t)))
