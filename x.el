;; -*- mode: emacs-lisp; coding: utf-8-unix; -*-
;;;; 適当におすすめのフォント設定を試みる
(defvar cfg:font-list
  '("Monospace-9"
    "Ricty-11"
    "M+2VM+IPAG circle-10"
    "Source Code Pro Medium-9"
    "Ricty-11"
    "Consolas-10"
    "Inconsolata-10"))
(eval-when-compile (require 'cl))
(dolist (font cfg:font-list)
  (ignore-errors
    (set-frame-font font)
    (return)))
;; EmacsでMozcを使うための設定 | ユービックログ研究所 <http://www.ubiqlog.com/archives/8538>
(global-set-key (kbd "M-`") 'toggle-input-method)
(global-set-key (kbd "C-\\") 'toggle-input-method)
(custom-set-variables
 '(default-input-method "japanese-mozc")
 ;; sudo apt-get install cmigemo で勝手に辞書も作ってくれる
 '(migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict"))
