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

(provide 'my-functions)
