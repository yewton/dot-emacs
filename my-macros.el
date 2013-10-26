;; キー定義のヘルパ(from ensime-define-keys)
;; cf. define-key や global-set-key をまとめる | less ~/.emacs.d/init.el
;;     <http://hke7.wordpress.com/2011/11/15/define-key-%E3%82%84-global-set-key-%E3%82%92%E3%81%BE%E3%81%A8%E3%82%81%E3%82%8B/>
;; (macroexpand '(my:define-keys helm-gtags-mode-map
;;                              ((kbd "C-c t") 'helm-gtags-find-tag)
;;                              ((kbd "M-.")   'helm-gtags-find-tag)))
;; (progn
;;   (define-key helm-gtags-mode-map (kbd "C-c t") (quote helm-gtags-find-tag))
;;   (define-key helm-gtags-mode-map (kbd "M-.") (quote helm-gtags-find-tag)))
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

;; global-set-keyの複数版。
(defmacro my:global-set-keys (&rest key-command)
  "`global-set-key'をまとめて設定する。
詳細については`my:define-keys'を参照。"
  `(progn . ,(mapcar (lambda (k-c) `(global-set-key . ,k-c))
                     key-command)))

(provide 'my-macros)
