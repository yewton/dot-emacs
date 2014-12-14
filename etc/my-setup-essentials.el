;;; -*- coding: utf-8; lexical-binding: t -*-
(defmacro my-define-keys (keymap &rest key-command)
  "特定のキーマップをまとめて設定する。

;; 改善前
(define-key any-mode-map (kbd \"C-x\") 'any-function)
(define-key any-mode-map (kbd \"M-a\") 'hoge-function)

;; 改善後
(my-define-keys any-mode-map
  ((kbd \"C-x\") 'any-function)
  ((kbd \"M-a\") 'hoge-function))"
  `(progn . ,(mapcar (lambda (k-c) `(define-key ,keymap . ,k-c))
                     key-command)))

(defmacro my-global-set-keys (&rest key-command)
  "`global-set-key'をまとめて設定する。
詳細については`my-define-keys'を参照。"
  `(my-define-keys global-map . ,key-command))

(defmacro my-fpath-ued (filename)
  `(expand-file-name ,filename ,user-emacs-directory))

(defmacro my-dpath-ued (dirname)
  `(my-fpath-ued (file-name-as-directory ,dirname)))

(defmacro my-expand-dir-name (dirname &optional default)
  `(expand-file-name (file-name-as-directory ,dirname) ,default))

(defmacro my-add-to-list (list-var &rest elems)
  `(progn ,@(mapcar (lambda (e) `(add-to-list ,list-var ,e)) elems)))

(defmacro my-add-to-load-path (&rest paths)
  `(progn ,@(mapcar (lambda (p) `(add-to-list 'load-path (file-name-as-directory ,p))) paths)))

(defun my-set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(defvar my-etc-dir (my-dpath-ued "etc"))
(defvar my-lib-dir (my-dpath-ued "lib"))
(defvar my-opt-dir (my-dpath-ued "opt"))
(defvar my-var-dir (my-dpath-ued "var"))

(provide 'my-setup-essentials)
;;; my-setup-essentials.el ends here
