;; デフォルトエンコード指定
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
;; 一時ファイル
(customize-set-value
 'temporary-file-directory (concat user-emacs-directory "temp/"))
;; バックアップファイル
(customize-set-value
 'backup-directory-alist `(("." . ,(concat user-emacs-directory "backup/"))))
;; 自動保存ファイル
(customize-set-value
 'auto-save-list-file-prefix (concat user-emacs-directory "auto-save-list/.saves-"))
;; 自動保存ファイル（#ファイル名#）の設定
(setq auto-save-file-name-transforms
      `((".*/Dropbox/.*" ,temporary-file-directory t)))
;; リージョンをハイライト
(setq-default transient-mark-mode t)
;; 対応する括弧の強調表示
(show-paren-mode t)
;;; ツールバーを消す
(when (fboundp 'tool-bar-mode) (tool-bar-mode 0))
;;; タイトルバーにいろいろ表示する
(setq frame-title-format (format "%%f - %s-%s@%s" invocation-name emacs-version system-name))
;; スクロールバーも消す
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode 0))
;; タブでなくスペースでインデント
(setq-default tab-width 4 indent-tabs-mode nil)
;; 行番号と列番号の組を表示
(column-number-mode t)
(line-number-mode t)
;; いちいち音を鳴らすな
(setq ring-bell-function 'ignore)
;; electric-pair
(electric-pair-mode 1)
;; 現在行をハイライト
(global-hl-line-mode t)
(set-face-background 'hl-line "gray15")