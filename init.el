;; emacs -l init.el のように起動されると load-file-name に init.el のパスが入るので
(when load-file-name
  ;; 設定ファイルの基準となるディレクトリを読み込んだ init.el のあるディレクトリへ変更する
  (setq user-emacs-directory (file-name-directory load-file-name)))
(add-to-list 'load-path user-emacs-directory)

(princ user-emacs-directory)
(load "bootstrap")
