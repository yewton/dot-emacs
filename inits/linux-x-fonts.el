;; 適当におすすめのフォント設定を試みる
(when (eq window-system 'x)
  (let ((font-list '("Monospace-9"
                     "Ricty-11"
                     "M+2VM+IPAG circle-10"
                     "Source Code Pro Medium-9"
                     "Ricty-11"
                     "Consolas-10"
                     "Inconsolata-10")))
    (eval-when-compile (require 'cl))
    (dolist (font font-list)
      (ignore-errors
        (set-frame-font font)
        (return)))))
