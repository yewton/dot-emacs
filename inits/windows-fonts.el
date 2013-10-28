;; -*- mode: emacs-lisp; coding: utf-8-unix; -*-
;;;; 適当におすすめのフォント設定を試みる
(let ((font-list '("Migu 1M-10"
                   "M+2VM+IPAG circle-10"
                   "Source Code Pro Medium-9"
                   "Ricty-11"
                   "Consolas-10"
                   "Inconsolata-10")))
  (eval-when-compile (require 'cl))
  (dolist (font font-list)
    (ignore-errors
      (set-frame-font font)
      (return))))

;;; 文字コードの設定
(setq default-file-name-coding-system 'cp932-dos)
