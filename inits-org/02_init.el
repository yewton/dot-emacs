(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)

(when (eq window-system 'ns)
  (setq locale-coding-system 'utf-8)
  (setq system-time-locale "ja_JP.UTF-8")
  (setenv "LANG" "ja_JP.UTF-8")
  (setenv "LC_ALL" "ja_JP.UTF-8")
  (setenv "LC_MESSAGES" "ja_JP.UTF-8"))

(custom-set-variables
 `(temporary-file-directory ,(concat user-emacs-directory "temp/")))

(custom-set-variables
 '(backup-directory-alist `((".*" . ,(concat user-emacs-directory "backup/"))))
 '(auto-save-file-name-transforms `((".*" ,(concat user-emacs-directory "auto-save/") t)))
 `(auto-save-list-file-prefix ,(concat user-emacs-directory "auto-save-list/.saves-")))

(custom-set-variables '(create-lockfiles nil))

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
;; いちいち音を鳴らすな
(setq ring-bell-function 'ignore)
;; electric-pair 勝手に閉じカッコとかを入れてくれるやつ
(electric-pair-mode 1)
;; 現在行をハイライト
(global-hl-line-mode t)
(set-face-background 'hl-line "gray15")
;; 現在いる関数名をモードラインに表示
(which-function-mode t)
(setq-default which-func-unknown "")
;; キーストロークをすぐにエコーエリアに表示する
(custom-set-variables '(echo-keystrokes 0.2))
;; セッションを保存する
;; cf. http://www.emacswiki.org/DeskTop
(desktop-save-mode 1)
(custom-set-variables
 `(desktop-dirname ,(expand-file-name (concat user-emacs-directory "/desktop/")))
 '(desktop-save 'ask-if-new)
 '(desktop-globals-to-save '(extended-command-history
                             desktop-missing-file-warning
                             tags-file-name
                             tags-table-list
                             search-ring
                             regexp-search-ring
                             register-alist
                             file-name-history)))
