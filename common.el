;; 変数宣言
(defvar cfg:base-dir)
(defvar cfg:tmp-dir)

;; symlink を自動で解決する
(setq vc-follow-symlinks t)

;; 共通設定ファイル
;;;; custom-set-variables
(custom-set-variables
 '(package-user-dir (concat cfg:package-install-dir))
 )

;;;; el-get
(require 'el-get)
(defvar cfg:packages
  '(helm
    helm-migemo
    auto-async-byte-compile
    apel
    migemo))
(dolist (package cfg:packages)
  (el-get-install package))

;;;; helm
(require 'helm-config)
(global-set-key (kbd "C-x C-b") 'helm-mini)
(global-set-key "\C-xb" 'helm-buffers-list)

;;;; auto-async
(require 'auto-async-byte-compile)
;;自動バイトコンパイルを無効にするファイル名の正規表現
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

;; migemo
(when migemo-command
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-use-pattern-alist t)
  (setq migemo-pattern-alist-file (concat cfg:tmp-dir "migemo-pattern"))
  (setq migemo-use-frequent-pattern-alist t)
  (setq migemo-frequent-pattern-alist-file (concat cfg:tmp-dir "migemo-frequent"))
  (setq migemo-pattern-alist-length 2048)
  (load-library "migemo")
  (migemo-init))

;;;; other
;; 自動保存ファイル（#ファイル名#）の設定
(setq auto-save-file-name-transforms
      `((".*/Dropbox/.*" ,temporary-file-directory t)))
;; バックアップファイル
(setq backup-directory-alist '(("." . (concat cfg:base-dir "backup"))))
;; リージョンをハイライト
(setq-default transient-mark-mode t)
;; 対応する括弧の強調表示
(show-paren-mode t)
;;; ツールバーを消す
(tool-bar-mode 0)
;;; タイトルバーにファイル名を表示する
(setq frame-title-format (format "%%f" (system-name)))
;; スクロールバーも消す
(scroll-bar-mode 0)
;; 指定行ジャンプ
(global-set-key "\M-g" 'goto-line)
;; なにもしなくていい
(global-set-key "\C-\\" 'ignore)
(global-set-key [M-kanji] 'ignore)
;; タブでなくスペースでインデント
(setq-default tab-width 4 indent-tabs-mode nil)
;; 行番号と列番号の組を表示
(column-number-mode t)
(line-number-mode t)
;; いちいち音を鳴らすな
(setq ring-bell-function 'ignore)
