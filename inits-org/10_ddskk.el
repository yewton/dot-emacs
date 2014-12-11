(require 'skk)
(eval-when-compile
  (require 'skk-vars)
  (require 'skk-autoloads)
  (require 'skk-macs))

(global-set-key (kbd "C-x C-j") 'skk-mode)
(global-set-key (kbd "C-x j") 'skk-auto-fill-mode)
(global-set-key (kbd "C-x t") 'skk-tutorial)

(custom-set-variables `(skk-user-directory ,(concat user-emacs-directory "ddskk/")))

(require 'el-get-core)
(custom-set-variables `(skk-cdb-large-jisyo ,(concat (el-get-package-directory 'ddskk) "dic/SKK-JISYO.L.cdb")))

(custom-set-variables
 `(skk-jisyo ,(concat skk-user-directory "jisyo"))
 `(skk-record-file ,(concat skk-user-directory "record")))

(custom-set-variables '(skk-sticky-key ";"))

(defun skk-C-j-key (arg)
  "C-j の挙動に関する設定"
  (interactive "P")
  (cond
   ;; 必要な箇所でのみ C-j を skk-kakutei に割り当てる
   ((or (skk-in-minibuffer-p) skk-henkan-mode)
    (skk-kakutei arg))
   ;; さもなくば標準の動作を行う
   (t
    (skk-emulate-original-map arg))))
;; 状態遷移規則のリストに追加する
(add-to-list 'skk-rom-kana-rule-list
             '(skk-kakutei-key nil skk-C-j-key))
(defadvice skk-latin-mode (after skk-latin-mode-free-cj activate)
  ;; latin-mode ではこのキーでかなモードに遷移する
  (define-key skk-latin-mode-map (kbd "C-;") #'skk-kakutei)
  ;; latin-mode で C-j を明け渡す
  (define-key skk-latin-mode-map (kbd "C-j") nil))
(defadvice skk-jisx0208-latin-mode (after skk-jisx0208-latin-mode-free-cj activate)
  ;; 全英モードではこのキーでかなモードに遷移する
  (define-key skk-jisx0208-latin-mode-map (kbd "C-;") #'skk-kakutei)
  ;; 全英モードで C-j を明け渡す
  (define-key skk-jisx0208-latin-mode-map (kbd "C-j") nil))

(eval-after-load 'skk
  #'(progn
      (require 'context-skk)
      (require 'skk-hint)
      (custom-set-variables '(skk-hint-start-char ?:))
      ;; 空の辞書ファイルを作成
      (unless (file-exists-p skk-jisyo)
        (write-region "" nil skk-jisyo))))
(custom-set-variables
 ;; Enter で改行しない
 '(skk-egg-like-newline t)
 ;; 注釈の表示
 '(skk-show-annotation nil)
 ;; インジケータを左端に.
 '(skk-status-indicator 'left)
 ;; 半角カナを入力
 '(skk-use-jisx0201-input-method t)
 ;;"「"を入力したら"」"も自動で挿入
 '(skk-auto-insert-paren t)
 ;; 見出し語と送り仮名がマッチした候補を優先して表示
 '(skk-henkan-strict-okuri-precedence t))
