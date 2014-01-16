(defvar bookmark-dir (concat user-emacs-directory "bookmark/"))
(custom-set-variables
 `(bookmark-default-file ,(concat bookmark-dir "bookmarks"))
 `(bmkp-last-as-first-bookmark-file bookmark-default-file)
 `(bmkp-bmenu-commands-file ,(concat bookmark-dir ".emacs-bmk-bmenu-commands"))
 `(bmkp-bmenu-state-file,(concat bookmark-dir ".emacs-bmk-bmenu-state"))
 `(bmkp-bmenu-image-bookmark-icon-file ,(concat bookmark-dir ".emacs-bmk-bmenu-image-file-icon.png")))

