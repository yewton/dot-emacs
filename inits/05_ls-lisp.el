;; dired でディレクトリを先に表示する
(require 'ls-lisp)
(custom-set-variables
 '(ls-lisp-dirs-first t)
 '(ls-lisp-use-insert-directory-program nil)
 '(ls-lisp-use-localized-time-format t)
 '(dired-listing-switches "-AFlh"))
