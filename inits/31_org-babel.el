(executable-find "plantuml.jar")
(eval-when-compile (require 'cl-lib))
(dolist (path exec-path)
  (let ((jar-path (concat path "/plantuml.jar")))
    (when (file-exists-p jar-path)
      (customize-set-value 'org-plantuml-jar-path jar-path)
      (return))))

(defvar my:ob-load-languages '((emacs-lisp . t)))

(when (and
       (boundp 'org-plantuml-jar-path)
       org-plantuml-jar-path)
  (add-to-list 'my:ob-load-languages '(plantuml . t)))

(custom-set-variables
 '(org-babel-load-languages my:ob-load-languages)
 '(org-src-fontify-natively t)
 '(org-edit-src-content-indentation 0))

;; Local Variables:
;; byte-compile-warnings: (not unresolved)
;; End:
