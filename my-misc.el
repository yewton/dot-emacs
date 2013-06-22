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
;; cf. keyboard shortcuts - Globally override key binding in Emacs - Stack Overflow
;;     <http://stackoverflow.com/questions/683425/globally-override-key-binding-in-emacs>
(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")
(mapc (lambda (x)
        (define-key my-keys-minor-mode-map (car x) (cdr x))
        (global-set-key (car x) (cdr x)))
      '(("\C-\M-h" . windmove-left)
        ("\C-\M-k" . windmove-up)
        ("\C-\M-l" . windmove-right)
        ("\C-\M-j" . windmove-down)))
(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)
(my-keys-minor-mode 1)
(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0))
(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)
(defadvice load (after give-my-keybindings-priority)
  "Try to ensure that my keybindings always have priority."
  (if (not (eq (car (car minor-mode-map-alist)) 'my-keys-minor-mode))
      (let ((mykeys (assq 'my-keys-minor-mode minor-mode-map-alist)))
        (assq-delete-all 'my-keys-minor-mode minor-mode-map-alist)
        (add-to-list 'minor-mode-map-alist mykeys))))
(ad-activate 'load)
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
;; linum-mode
(require 'linum)
(global-linum-mode 1)
(custom-set-variables
 '(linum-format "%5d "))
;; 現在行をハイライト
(global-hl-line-mode t)
(set-face-background 'hl-line "gray15")
;; safe-local-variable-values
(custom-set-variables
 '(safe-local-variable-values
   (quote
    ((whitespace-style . (face trailing lines-tail))
     (whitespace-line-column . 80)
     (eval . (ignore-errors
               "Write-contents-functions is a buffer-local alternative to before-save-hook"
               (add-hook 'write-contents-functions
                         (lambda ()
                           (delete-trailing-whitespace)
                           nil))
               (require 'whitespace)
               "Sometimes the mode needs to be toggled off and on."
               (whitespace-mode 0)
               (whitespace-mode 1)))
     (require-final-newline . t)))))
;; Removing Killed Buffers from the History <http://www.emacswiki.org/emacs/MinibufferHistory#toc4>
(add-hook
 'kill-buffer-hook
 (lambda ()
   (setq buffer-name-history
         (delete
          (buffer-name)
          buffer-name-history))))
;; dired でディレクトリを先に表示する
(require 'ls-lisp)
(custom-set-variables
 '(ls-lisp-dirs-first t)
 '(ls-lisp-use-insert-directory-program nil)
 '(ls-lisp-use-localized-time-format t)
 '(dired-listing-switches "-AFlh"))
;; case-insensitive なソート
;; (dolist (i (ci-sort (directory-files "~/dot-emacs" t) 'string<))
;;   (insert (concat ";; " i "\n")))
(defun ci-sort (l p)
  (sort l
        (lambda (a b)
          (funcall p (upcase a) (upcase b)))))
;; directory 優先でソート
;; (dolist (i (sort-by-file-directory-p (directory-files "~/dot-emacs" t)))
;;   (insert (concat ";; " i "\n")))
(defun sort-by-file-directory-p (l)
  (sort l
        (lambda (a b)
          (let ((a-is-a-directory (file-directory-p a))
                (b-is-a-directory (file-directory-p b)))
            (cond
             ((and a-is-a-directory (not b-is-a-directory)) t)
             ((and (not a-is-a-directory) b-is-a-directory) nil)
             (t nil))))))
;; case-insensitive に、かつディレクトリを優先してリスティングする
(defadvice directory-files
  (after after-helm-ff-directory-find-files activate)
  (setq ad-return-value
        (sort-by-file-directory-p
         (ci-sort ad-return-value 'string<))))
;; お約束
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-c h") 'help-command)
