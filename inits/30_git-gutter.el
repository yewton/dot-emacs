(if (or (eq window-system 'w32)
        (eq window-system nil))
    (require 'git-gutter)
  (require 'git-gutter-fringe))
(defun my:eval-after-git-gutter-load ()
  (global-git-gutter-mode +1))

(eval-after-load "git-gutter" #'my:eval-after-git-gutter-load)
(eval-after-load "git-gutter-fringe" #'my:eval-after-git-gutter-load)

;; Local Variables:
;; byte-compile-warnings: (not unresolved)
;; End: