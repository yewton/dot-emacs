(defvar ac-dictionary-directories)
(add-to-list 'ac-dictionary-directories
             (expand-file-name (concat user-emacs-directory "/ac-dict")))
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)
