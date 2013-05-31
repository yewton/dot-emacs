(require 'yasnippet)
(defvar cfg:base-dir)
(defvar cfg:el-get-dir)
(defun my-yas-prompt (prompt choices &optional display-fn)
  (let* ((names (loop for choice in choices
                      collect (or (and display-fn (funcall display-fn choice))
                                  coice)))
         (selected (helm-other-buffer
                    `(((name       . ,(format "%s" prompt))
                       (candidates . names)
                       (action     . (("Insert snippet" . (lambda (arg) arg))))))
                    "helm yas/prompt*")))
    (if selected
        (let ((n (position selected names :test 'equal)))
          (nth n choices))
      (signal 'quit "user quit!"))))
(custom-set-variables
 '(yas-snippet-dirs
   `(,(concat cfg:base-dir "snippets")
     ,(concat el-get-dir  "yasnippet/snippets")))
 '(yas-prompt-functions '(my-yas-prompt)))
(yas-global-mode 1)
;; 既存スニペットを挿入する
(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;; 既存スニペットを閲覧・編集する
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)
