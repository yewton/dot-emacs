
(defun ci-sort (l p)
  (sort l
        (lambda (a b)
          (funcall p (upcase a) (upcase b)))))

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
