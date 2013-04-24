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
;; (add-to-list 'process-coding-system-alist
;;              (cons magit-git-executable 'utf-8)) ;; diff の文字化け回避
(modify-coding-system-alist 'process "git" '(utf-8-dos . utf-8-unix))
;; http://www.greenwood.co.jp/~k-aki/diary/diary201004.xhtml
;; magitがshell-file-name(sh.exe)経由でgitを呼ぶとき、utf-8で入出力する。
;; magitがshell-file-nameを使ってprocess-fileやcall-processする関数には次のものがある。
;; - magit-shell-command-to-string
;; - magit-git-exit-code
;; - magit-run-shell
;; これらの呼び出し時、一時的にprocess-coding-system-alistを書き換える。
(defun add-sh-utf8-process-coding-system-alist ()
  (cons (cons shell-file-name '(utf-8-dos . utf-8-unix)) process-coding-system-alist))

(defadvice magit-shell-command-to-string (around magit-shell-command-to-string-proc-coding activate)
  (let ((process-coding-system-alist (add-sh-utf8-process-coding-system-alist)))
    ad-do-it))
(defadvice magit-git-exit-code (around magit-git-exit-code-proc-coding activate)
  (let ((process-coding-system-alist (add-sh-utf8-process-coding-system-alist)))
    ad-do-it))

(defadvice magit-run-shell (around magit-run-shell-proc-coding activate)
  (let ((process-coding-system-alist (add-sh-utf8-process-coding-system-alist)))
    ad-do-it))
