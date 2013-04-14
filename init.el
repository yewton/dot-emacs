;; emacs -l init.el のように起動されるとload-file-nameにinit.elのパスが入るので
(when load-file-name
  ;; 設定ファイルの基準となるディレクトリを読み込んだinit.elのあるディレクトリへ変更する
  (setq user-emacs-directory (file-name-directory load-file-name)))
(add-to-list 'load-path user-emacs-directory)

;; 設定ディレクトリの場所を設定
(setq cfg:base-dir
      (expand-file-name (file-name-directory user-emacs-directory)))

;; system-type predicates
(setq
 w32-p (eq window-system 'w32)
 cocoa-p (eq window-system 'ns)
 x-p (eq window-system 'x)
 term-p (eq window-system nil)
 gui-p (or w32-p cocoa-p x-p))

;; elisp 置き場を設定
(setq cfg:theme-dir (concat cfg:base-dir "themes/"))
(setq cfg:el-get-dir (concat cfg:base-dir "el-get/"))
(setq cfg:el-get-recipe-dir (concat cfg:base-dir "recipes/"))
(setq cfg:system-dir
      (concat cfg:base-dir
          (cond
           (w32-p "win32")
           (cocoa-p "cocoa")
           (x-p "x")
           (t "term")) "/"))

;; 各種設定ファイル名の定義
(setq cfg:common (concat cfg:base-dir "common.el"))
(setq cfg:system (concat cfg:base-dir (cond (w32-p "win32") (cocoa-p "cocoa") (x-p "x") (t "term")) ".el"))
(setq cfg:frame (concat cfg:base-dir "frame.el"))
(setq cfg:before-default (concat cfg:base-dir "before-default.el"))
(setq cfg:after-default (concat cfg:base-dir "after-default.el"))
(setq cfg:before (concat cfg:base-dir "before.el"))
(setq cfg:after (concat cfg:base-dir "after.el"))
(setq cfg:misc (concat cfg:base-dir "misc.el"))

;; load-path の設定
(add-to-list 'custom-theme-load-path cfg:theme-dir)

;; before-default.el 読み込み
(load cfg:before-default)

;; before.el があれば読み込み
(when (file-exists-p cfg:before) (load cfg:before))

;; el-get
(add-to-list 'load-path (concat cfg:el-get-dir "el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
(add-to-list 'el-get-recipe-path cfg:el-get-recipe-dir)
(el-get 'sync)

;; テーマの読み込み
(load-theme 'clarity t)

;; フレーム設定の読み込み
(when gui-p (load cfg:frame))

;; 共通
(load cfg:common)

;; system 依存
(load cfg:system)

;; 雑多
(load cfg:misc)

;; after-default.el 読み込み
(load cfg:after-default)

;; after.el があれば読み込み
(when (file-exists-p cfg:after) (load cfg:after))
