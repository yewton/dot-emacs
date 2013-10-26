(setq howm-view-title-header "*")
(custom-set-variables
 '(howm-file-name-format "%Y/%m/%Y_%m_%d.howm")
 `(howm-directory ,(concat user-emacs-directory "howm"))
 '(howm-menu-lang 'ja)
 '(howm-menu-todo-num 20)
 '(howm-view-use-grep t))
(require 'howm)
(require 'outline)
(global-set-key (kbd "C-c , ,") 'howm-menu)
(custom-set-faces
 '(howm-mode-title-face ((t (:inherit outline-1)))))

;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
