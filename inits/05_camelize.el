;; Emacsで単語単位の移動をキャメルケースの途中で区切るには: 小ネタ帳
;; http://smallsteps.seesaa.net/article/123661899.html
;; 文字カテゴリの作成
(unless (category-docstring ?V)
  (define-category ?V "Upper case"))
(unless (category-docstring ?M)
    (define-category ?M "Lower case"))
;; 文字の登録。とりあえずはAからZまでの英字のみ。
(modify-category-entry (cons ?A ?Z) ?V)
(modify-category-entry (cons ?a ?z) ?M)
;; 小文字に大文字が続く場合を単語境界とする。
(add-to-list 'word-separating-categories (cons ?M ?V))

;; [emacs] CamelCase なんてもういらない - tomykaira makes love with codes <http://tomykaira.hatenablog.com/entry/2012/01/09/152903>
(defun camelize (s)
  "Convert under_score string S to CamelCase string."
  (mapconcat 'identity (mapcar
                        #'(lambda (word) (capitalize (downcase word)))
                        (split-string s "_")) ""))
(defun camelize-previous-snake (&optional beg end)
  "Camelize the previous snake cased string .

If transient-mark-mode is active and a region is activated,
camelize the region."
  (interactive)
  (unless (and beg end)
    (if (and (boundp 'transient-mark-mode) transient-mark-mode mark-active)
        (setq beg (mark)
              end (point))
      (setq end (point)
            beg (+ (point) (skip-chars-backward "[:alnum:]_")))))
  (save-excursion
    (let ((c (camelize (buffer-substring-no-properties beg end))))
      (delete-region beg end)
      (goto-char (min beg end))
      (insert c))))
(defun split-name (s)
  (split-string
   (let ((case-fold-search nil))
     (downcase
      (replace-regexp-in-string "\\([a-z]\\)\\([A-Z]\\)" "\\1 \\2" s)))
   "[^A-Za-z0-9]+"))
(defun camelcase  (s) (mapconcat 'capitalize (split-name s) ""))
(defun underscore (s) (mapconcat 'downcase   (split-name s) "_"))
(defun dasherize  (s) (mapconcat 'downcase   (split-name s) "-"))
(defun colonize   (s) (mapconcat 'capitalize (split-name s) "::"))
(defun camelscore (s)
  (cond ((string-match-p "\:"  s) (camelcase s))
        ((string-match-p "-" s)   (colonize s))
        ((string-match-p "_" s)   (dasherize s))
        (t                        (underscore s))))
(defun camelscore-word-at-point ()
  (interactive)
  (let* ((case-fold-search nil)
         (beg (and (skip-chars-backward "[:alnum:]:_-") (point)))
         (end (and (skip-chars-forward  "[:alnum:]:_-") (point)))
         (txt (buffer-substring beg end))
         (cml (camelscore txt)) )
    (if cml (progn (delete-region beg end) (insert cml))) ))
(global-set-key (kbd "\C-c \C-c") 'camelscore-word-at-point)
