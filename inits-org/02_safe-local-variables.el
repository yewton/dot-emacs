;; safe-local-variable-values
(custom-set-variables
 '(safe-local-variable-values
   (quote
    ((whitespace-style . (face trailing lines-tail))
     (whitespace-line-column . 80)
     (eval . (ignore-errors
               "Write-contents-functions is a buffer-local alternative to before-save-hook"
               (add-hook 'write-contents-functions
                         (lambda ()
                           (delete-trailing-whitespace)
                           nil))
               (require 'whitespace)
               "Sometimes the mode needs to be toggled off and on."
               (whitespace-mode 0)
               (whitespace-mode 1)))
     (require-final-newline . t)))))
