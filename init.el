;;; -*- coding: utf-8; lexical-binding: t -*-
;;;; 初期化
(when load-file-name
  ;; emacs -l init.el のように起動されると load-file-name に init.el のパスが入るので、
  ;; 設定ファイルの基準となるディレクトリを、読み込んだ init.el のあるディレクトリへ変更する。
  (setq user-emacs-directory (file-name-directory load-file-name)))

;; el-get で入っている org-mode があればそちらを使う
(setq el-get-dir (expand-file-name "opt/el-get/" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "el-get" el-get-dir))
(require 'cl-lib)
(when (and (require 'el-get nil t)
           (fboundp 'el-get-package-directory)
           (el-get-package-installed-p 'org-mode))
  (let ((dirs (list "." "lisp" "contrib/lisp"))
        (built-in-org-dir (directory-file-name (file-name-directory (locate-library "org"))))
        (el-get-org-dir (el-get-package-directory 'org-mode)))
    (loop for dir in dirs
          do (add-to-list 'load-path (expand-file-name dir el-get-org-dir)))))

(org-babel-load-file (expand-file-name "bootstrap.org" user-emacs-directory))

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; init.el ends here
