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
;; 色変更
(set-face-foreground 'magit-diff-add "#b9ca4a")
(set-face-foreground 'magit-diff-del "#d54e53")
(set-face-background 'magit-item-highlight "#000000")

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

;;;; markdown-mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;;; jaspace
(require 'jaspace)

;;;; whitespace
(require 'whitespace)
(global-whitespace-mode 1)
(setq whitespace-style
      '(face tabs tab-mark spaces space-mark newline newline-mark))

(setq whitespace-display-mappings
      '(
        (space-mark ?\u3000 [?□])  ; 全角スペース
        (space-mark ?\u0020 [?\xB7])  ; 半角スペース
        (newline-mark ?\n   [?$ ?\n]) ; 改行記号
        ))

(setq whitespace-space-regexp "\\([\x0020\x3000]+\\)" )
(set-face-foreground 'whitespace-space "Gray10")
(set-face-background 'whitespace-space 'nil)
(set-face-bold-p 'whitespace-space t)
(set-face-foreground 'whitespace-newline  "Gray10")
(set-face-background 'whitespace-newline 'nil)

;;;; emacs-w3m
(require 'el-get-core) ;; for `el-get-executable-find`
(when (el-get-executable-find "w3m")
  (require 'w3m-load)
  (autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
  (custom-set-variables
   '(w3m-use-tab t)
   `(w3m-arrived-file ,(concat cfg:tmp-dir "w3m-arrived"))
   `(w3m-cookie-file ,(concat cfg:tmp-dir "w3m-cookie"))
   `(w3m-form-textarea-directory ,(concat cfg:tmp-dir "w3m-textarea"))
   `(w3m-bookmark-file ,(concat cfg:tmp-dir "w3m-bookmark")))
  )
