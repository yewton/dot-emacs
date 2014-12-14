;;; -*- coding: utf-8; lexical-binding: t -*-
;;;; 初期化
(when load-file-name
  ;; emacs -l init.el のように起動されると load-file-name に init.el のパスが入るので、
  ;; 設定ファイルの基準となるディレクトリを、読み込んだ init.el のあるディレクトリへ変更する。
  (setq user-emacs-directory (file-name-directory load-file-name)))

(org-babel-load-file (expand-file-name "bootstrap.org" user-emacs-directory))
;; init.el ends here
