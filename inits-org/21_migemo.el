;; migemo
(let* ((migemo-executable (executable-find "cmigemo"))
       (migemo-base-directory
        (when migemo-executable
          (file-name-directory (file-truename migemo-executable))))
       (migemo-dictionary-candidates
        (when migemo-base-directory
          (list (concat migemo-base-directory "../share/migemo/utf-8/migemo-dict")
                (concat migemo-base-directory "../share/cmigemo/utf-8/migemo-dict")
                (concat migemo-base-directory "/dict/utf-8/migemo-dict"))))
       (migemo-dictionary-file
        (car-safe
         (delq nil (mapcar (lambda (x) (and (file-exists-p x) x))
                           migemo-dictionary-candidates)))))
  (when (and migemo-executable migemo-dictionary-file)
    (eval-and-compile (require 'migemo))
    (let ((migemo-dir (concat user-emacs-directory "migemo/")))
      (custom-set-variables
       `(migemo-command ,migemo-executable)
       '(migemo-options '("-q" "--emacs"))
       '(migemo-coding-system 'utf-8)
       `(migemo-dictionary ,(expand-file-name migemo-dictionary-file))
       '(migemo-user-dictionary nil)
       '(migemo-regex-dictionary nil)
       '(migemo-use-pattern-alist t)
       '(migemo-use-frequent-pattern-alist t)
       '(migemo-pattern-alist-length 2048)
       `(migemo-pattern-alist-file ,(concat migemo-dir "migemo-pattern"))
       `(migemo-frequent-pattern-alist-file ,(concat migemo-dir "migemo-frequent"))))
    (load-library "migemo")
    (migemo-init)
    (define-key isearch-mode-map (kbd "C-e") 'migemo-isearch-toggle-migemo)))
