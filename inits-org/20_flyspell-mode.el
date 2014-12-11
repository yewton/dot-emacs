(custom-set-variables
 '(ispell-dictionary "english")
 '(ispell-program-name "aspell"))
(eval-after-load "ispell"
  #'(progn
      (add-to-list 'ispell-skip-region-alist '("[^\000-\377]+"))))
(eval-after-load 'flyspell
  #'(progn
      (define-key flyspell-mode-map [(control ?\.)] 'flyspell-correct-word-before-point)))
;; (dolist (hook '(text-mode-hook org-mode-hook))
;;   (add-hook hook 'flyspell-mode))
;; (dolist (hook '(prog-mode-hook))
;;   (add-hook hook 'flyspell-prog-mode))
