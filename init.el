;; emacs -l init.el のように起動されるとload-file-nameにinit.elのパスが入るので
(when load-file-name
  ;; 設定ファイルの基準となるディレクトリを読み込んだinit.elのあるディレクトリへ変更する
  (setq user-emacs-directory (file-name-directory load-file-name)))
(add-to-list 'load-path user-emacs-directory)

;; 設定ディレクトリの場所を設定
(defvar cfg:base-dir
      (expand-file-name (file-name-directory user-emacs-directory)))

;; system-type predicates
(defvar w32-p (eq window-system 'w32))
(defvar cocoa-p (eq window-system 'ns))
(defvar x-p (eq window-system 'x))
(defvar term-p (eq window-system nil))
(defvar gui-p (or w32-p cocoa-p x-p))

;; 各種ディレクトリ設定
(defvar cfg:theme-dir (concat cfg:base-dir "themes/"))
(defvar cfg:el-get-dir (concat cfg:base-dir "el-get/"))
(defvar cfg:el-get-recipe-dir (concat cfg:base-dir "recipes/"))
(defvar cfg:tmp-dir (concat cfg:base-dir "tmp/"))

;; 各種設定ファイル名の定義
(defvar cfg:init (concat cfg:base-dir "init.el"))
(defvar cfg:common (concat cfg:base-dir "common.el"))
(defvar cfg:win32 (concat cfg:base-dir "win32.el"))
(defvar cfg:cocoa (concat cfg:base-dir "cocoa.el"))
(defvar cfg:x (concat cfg:base-dir "x.el"))
(defvar cfg:term (concat cfg:base-dir "my-term.el"))
(defvar cfg:frame (concat cfg:base-dir "my-frame.el"))
(defvar cfg:prepare (concat cfg:base-dir "prepare.el"))
(defvar cfg:post-init (concat cfg:base-dir "post-init.el"))
(defvar cfg:before (concat cfg:base-dir "before.el"))
(defvar cfg:after (concat cfg:base-dir "after.el"))
(defvar cfg:misc (concat cfg:base-dir "my-misc.el"))
(defvar cfg:base-config-list
  (list cfg:init cfg:common cfg:win32 cfg:cocoa cfg:x cfg:term cfg:frame cfg:prepare
        cfg:post-init cfg:before cfg:after cfg:misc))

;; デフォルトエンコード指定
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)

;; バックアップファイル
(setq backup-directory-alist `(("." . ,(concat cfg:base-dir "backup"))))

;; load-path の設定
(add-to-list 'custom-theme-load-path cfg:theme-dir)

;; バイトコンパイルしてから読み込む関数
(require 'bytecomp)
(defun load-after-recompile (file)
  (byte-recompile-file file nil 0 t))

;; prepare.el 読み込み
(load-after-recompile cfg:prepare)

;; before.el があれば読み込み
(when (file-exists-p cfg:before) (load-after-recompile cfg:before))

;; el-get
(add-to-list 'load-path (concat cfg:el-get-dir "el-get"))
(custom-set-variables `(el-get-dir ,cfg:el-get-dir))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))
(require 'el-get)
(add-to-list 'el-get-recipe-path cfg:el-get-recipe-dir)
(setq el-get-verbose t)
(defvar cfg:packages)
(setq cfg:packages
  '(el-get migemo apel auto-async-byte-compile cl-lib howm
    magit helm helm-migemo open-junk-file buffer-move
    markdown-mode jaspace emacs-w3m dsvn yasnippet crontab-mode
    maxframe ruby-mode ruby-block ruby-electric ruby-end scala-mode
    auto-complete flymake flymake-ruby php-mode-improved scala-mode2
    helm-gtags bookmark+ php-eldoc php-completion ensime htmlize
    term+ git-gutter git-gutter-fringe multiple-cursors sudo-ext
    haskell-mode emacs-mozc color-moccur))
(el-get 'sync cfg:packages)

;; package
(require 'package)
(package-initialize)

;; テーマの読み込み
(load-theme 'clarity t)

;; フレーム設定の読み込み
(when gui-p (load-after-recompile cfg:frame))

;; 個別設定ファイルのバイトコンパイル
(dolist (file (directory-files cfg:base-dir t "\\.el$"))
  (unless (member (expand-file-name file) cfg:base-config-list)
    (byte-recompile-file file nil 0)))

;; 共通
(load-after-recompile cfg:common)

;; system 依存
(load-after-recompile (cond (w32-p cfg:win32) (cocoa-p cfg:cocoa) (x-p cfg:x) (t cfg:term)))

;; 雑多
(load-after-recompile cfg:misc)

;; post-init.el 読み込み
(load-after-recompile cfg:post-init)

;; after.el があれば読み込み
(when (file-exists-p cfg:after) (load-after-recompile cfg:after))
