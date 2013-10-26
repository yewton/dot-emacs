;;;; dsvn
(autoload 'svn-status "dsvn" "Run `svn status'." t)
(autoload 'svn-update "dsvn" "Run `svn update'." t)
(eval-after-load "dsvn"
  (require 'vc-svn)) ;; これでいいのか不安
;; ;; Emacs/Lisp/Drill - Emacsグループ <http://emacs.g.hatena.ne.jp/k1LoW/200810>
(defadvice svn-commit (around svn-commit-around activate)
  (goto-char (point-min))
  (let ((prefix
         (if (re-search-forward "\\([^/ ]+\\)/\\(trunk\\|branches\\|tags\\)\\(/[^/ ]+\\)?" nil t)
             (let ((component-name (match-string-no-properties 1))
                   (branch (match-string-no-properties 2))
                   (branch-name (match-string-no-properties 3)))
               (if (string= "trunk" branch)
                   (setq prefix (concat "[" component-name "][trunk]"))
                 (setq prefix (concat
                               "[" component-name "]"
                               "[" branch branch-name "]"))))
           (setq prefix "[ ][trunk]"))))
    ad-do-it
    (erase-buffer)
    (insert prefix)))
