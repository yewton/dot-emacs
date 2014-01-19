
(defmacro my:define-keys (keymap &rest key-command)
  "特定のキーマップをまとめて設定する。

;; 改善前
(define-key any-mode-map (kbd \"C-x\") 'any-function)
(define-key any-mode-map (kbd \"M-a\") 'hoge-function)

;; 改善後
(define-keys any-mode-map
  ((kbd \"C-x\") 'any-function)
  ((kbd \"M-a\") 'hoge-function))"
  `(progn . ,(mapcar (lambda (k-c) `(define-key ,keymap . ,k-c))
                     key-command)))

(defmacro my:global-set-keys (&rest key-command)
  "`global-set-key'をまとめて設定する。
詳細については`my:define-keys'を参照。"
  `(progn . ,(mapcar (lambda (k-c) `(global-set-key . ,k-c))
                     key-command)))

(provide 'my-macros)
