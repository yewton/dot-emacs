;; 自動保存ファイル（#ファイル名#）の設定
(setq auto-save-file-name-transforms
      `((".*/Dropbox/.*" ,temporary-file-directory t)))
;; リージョンをハイライト
(setq-default transient-mark-mode t)
;; 対応する括弧の強調表示
(show-paren-mode t)
;;; ツールバーを消す
(tool-bar-mode 0)
;;; タイトルバーにいろいろ表示する
(setq frame-title-format (format "%%f - %s-%s@%s" invocation-name emacs-version system-name))
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
;; ウィンドウ間移動
(require 'windmove)
(setq windmove-wrap-around t)
;; cf. Emacs のあらゆるモードで有効なキーバインドの設定方法 - http://pqrs.org/emacs/doc/keyjack-mode/
(defvar my-keyjack-mode-map (make-sparse-keymap))
(mapc (lambda (x)
        (define-key my-keyjack-mode-map (car x) (cdr x))
        (global-set-key (car x) (cdr x)))
      '(("\C-\M-h" . windmove-left)
        ("\C-\M-k" . windmove-up)
        ("\C-\M-l" . windmove-right)
        ("\C-\M-j" . windmove-down)))
