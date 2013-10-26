(require 'auto-complete-config)
(ac-config-default)
(let* ((ac-dir (concat user-emacs-directory "auto-complete/"))
       (ac-dict-dir (concat ac-dir "dict/")))
  (custom-set-variables
   `(ac-comphist-file ,(concat ac-dir "ac-comphist.dat"))))
(global-auto-complete-mode t)
