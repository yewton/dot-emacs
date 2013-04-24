;; -*- mode: emacs-lisp; coding: utf-8-unix; -*-
;;;; 適当におすすめのフォント設定を試みる
(eval-when-compile
  (require 'cl-lib))
(defvar cfg:font-list
  '("Migu 1M-10"
    "M+2VM+IPAG circle-10"
    "Source Code Pro Medium-9"
    "Ricty-11"
    "Consolas-10"
    "Inconsolata-10"))
(dolist (font cfg:font-list)
  (ignore-errors
    (set-face-attribute 'default nil :font font)
    (return)))
;;; 文字コードの設定
(setq default-file-name-coding-system 'cp932-dos)
(defadvice magit-diff (around magit-diff-around activate)
  (let ((default-process-coding-system 'utf-8))
      ad-do-it))
(defadvice magit-log-edit (around magit-diff-around activate)
  (let ((default-process-coding-system 'utf-8)
        (default-file-name-coding-system 'utf-8)
        (coding-system-for-write 'utf-8))
    (set-terminal-coding-system 'utf-8)
    ad-do-it))

