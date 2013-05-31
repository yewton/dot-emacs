;;;; 変数宣言
(defvar cfg:tmp-dir)

;;;; helm
(require 'helm-config)
(helm-mode 1)
;; 自動補完を無効
(custom-set-variables '(helm-ff-auto-update-initial-value nil))
;; TABで任意補完。選択肢が出てきたらC-nやC-pで上下移動してから決定することも可能
(defvar helm-read-file-map)
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)

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

;;;; emacs-w3m
(load "w3m-conf")

;;;; flymake
(require 'flymake)
;; どこだりさファイル作るんでねぇ
(setq flymake-run-in-place nil)

;;;; dsvn
(require 'vc-svn)
(autoload 'svn-status "dsvn" "Run `svn status'." t)
(autoload 'svn-update "dsvn" "Run `svn update'." t)

;;;; helm-gtags
(require 'helm-gtags)
;;; Enable helm-gtags-mode
(add-hook 'php-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)
;; customize
(setq helm-gtags-path-style 'relative)
(setq helm-gtags-ignore-case t)
(setq helm-gtags-read-only t)
;; key bindings
(add-hook 'helm-gtags-mode-hook
          '(lambda ()
              (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
              (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
              (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
              (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)))

;;;; ruby-mode
(load "ruby-mode-conf")

;;;; scala-mode
(load "scala-mode-conf")

;;;; uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;;;; php-mode
(load "php-mode-conf")

;;;; ensime
(require 'ensime)

;;;; jaspace
(load "jaspace-conf")

;;;; yasnippet
(load "yasnippet-conf")

;;;; main-line
;; (require 'main-line)
;; (custom-set-variables '(main-line-separator-style 'wave))

;;;; term+
(autoload 'term+ "term+" nil t)
(autoload 'xterm-256color "xterm-256color" nil t)

;;;; crontab-mode
(autoload 'crontab-mode "crontab-mode" nil t)

;;;; git-guer
(if (or (eq window-system 'w32)
        (eq window-system nil))
    (require 'git-gutter)
  (require 'git-gutter-fringe))

;;;; diff-mode
(load "diff-mode-conf")

;;;; dsvn
;; Emacs/Lisp/Drill - Emacsグループ <http://emacs.g.hatena.ne.jp/k1LoW/200810>
(defadvice svn-commit (around svn-commit-around activate)
  (goto-char (point-min))
  (let ((prefix
         (if (re-search-forward "\\([^/ ]+\\)/\\(trunk\\|branches\\|tags\\)\\(/[^/ ]+\\)?" nil t)
             (let ((component-name (match-string-no-properties 1))
                   (branch (match-string-no-properties 2))
                   (branch-name (match-string-no-properties 3)))
               (if (string= "trunk" branch)
                   (setq prefix (concat "[" component-name "][trunk]"))
                 (setq prefix (concat
                               "[" component-name "]"
                               "[" branch branch-name "]"))))
           (setq prefix "[ ][trunk]"))))
    ad-do-it
    (erase-buffer)
    (insert prefix)))
