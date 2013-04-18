;;;; 変数宣言
(defvar cfg:tmp-dir)

;;;; helm
(require 'helm-config)
(helm-mode 1)

;;;; auto-async
(require 'auto-async-byte-compile)
;;自動バイトコンパイルを無効にするファイル名の正規表現
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

;;;; migemo
(require 'migemo)
(when migemo-command
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-use-pattern-alist t)
  (setq migemo-pattern-alist-file (concat cfg:tmp-dir "migemo-pattern"))
  (setq migemo-use-frequent-pattern-alist t)
  (setq migemo-frequent-pattern-alist-file (concat cfg:tmp-dir "migemo-frequent"))
  (setq migemo-pattern-alist-length 2048)
  (load-library "migemo")
  (migemo-init))

;;;; magit
(require 'magit)

;;; 試行錯誤用ファイルを開くための設定
(require 'open-junk-file)
;; C-x C-zで試行錯誤ファイルを開く
(global-set-key (kbd "C-x C-z") 'open-junk-file)

;;;; バッファの配置を移動する
(require 'buffer-move)
(global-set-key (kbd "C-S-j")  'buf-move-up)
(global-set-key (kbd "C-S-k")  'buf-move-down)
(global-set-key (kbd "C-S-l")  'buf-move-left)
(global-set-key (kbd "C-S-h")  'buf-move-right)
