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
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode 0))
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
;; カレントバッファの強制再読込を行う
(defun revert-buffer-force ()
  (interactive)
  (revert-buffer t t))
(define-key global-map "\C-c\C-x\C-j" 'revert-buffer-force)
(define-key global-map "\C-c\C-x\ j" 'revert-buffer-force)
(define-key global-map "\C-x\C-j" 'revert-buffer)
(define-key global-map "\C-x\ j" 'revert-buffer)
;; C-aで「行頭」と「インデントを飛ばした行頭」を行き来する Emacs23対応版 - なんとなく目記 <http://d.hatena.ne.jp/gifnksm/20100131/1264956220>
(defun beginning-of-indented-line (current-point)
  "インデント文字を飛ばした行頭に戻る。ただし、ポイントから行頭までの間にインデント文字しかない場合は、行頭に戻る。"
  (interactive "d")
  (if (string-match
       "^[ \t]+$"
       (save-excursion
         (buffer-substring-no-properties
          (progn (beginning-of-line) (point))
          current-point)))
      (beginning-of-line)
    (back-to-indentation)))
(defun beginning-of-visual-indented-line (current-point)
  "インデント文字を飛ばした行頭に戻る。ただし、ポイントから行頭までの間にインデント文 字しかない場合は、行頭に戻る。"
  (interactive "d")
  (let ((vhead-pos (save-excursion (progn (beginning-of-visual-line) (point))))
        (head-pos (save-excursion (progn (beginning-of-line) (point)))))
    (cond
     ;; 物理行の1行目にいる場合
     ((eq vhead-pos head-pos)
      (if (string-match
           "^[ \t]+$"
           (buffer-substring-no-properties vhead-pos current-point))
          (beginning-of-visual-line)
        (back-to-indentation)))
     ;; 物理行の2行目以降の先頭にいる場合
     ((eq vhead-pos current-point)
      (backward-char)
      (beginning-of-visual-indented-line (point)))
     ;; 物理行の2行目以降の途中にいる場合
     (t (beginning-of-visual-line)))))
(global-set-key "\C-a" 'beginning-of-visual-indented-line)
(global-set-key "\C-e" 'end-of-visual-line)
;; electric-pair
(electric-pair-mode 1)
(add-hook 'ruby-mode-hook
          '(lambda ()
             (ruby-electric-mode t)
             ;; Want to avoid some weird completions arising from
             ;; the use of ruby-electric.el and electric-pair-mode.
             (when (>= emacs-major-version 24)
               (set (make-local-variable 'electric-pair-mode) nil))))
