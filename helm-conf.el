(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
;; 無視するファイルを指定
(custom-set-variables
 '(helm-ff-auto-update-initial-value nil) ; 自動補完を無効
 '(helm-ff-file-name-history-use-recentf nil)
 '(helm-findutils-ignore-boring-files t) ; 無視ファイルを非表示
 '(helm-for-files-preferred-list
   '(helm-source-locate helm-source-buffers-list helm-source-bookmarks helm-source-recentf helm-source-file-cache helm-source-files-in-current-dir))
 '(helm-boring-file-regexp-list
   '("\\.git$" "\\.hg$" "\\.svn$" "\\.CVS$" "\\._darcs$" "\\.la$" "\\.o$" "~$"
     "\\.class$" "\\.elc$")))
;; 無視ファイルを
(require 'helm-files)
(defadvice helm-ff-directory-files (after ad-helm-find-files-skip-boring-files activate)
  (when helm-findutils-ignore-boring-files
    (setq ad-return-value (helm-skip-boring-files ad-return-value))))
;; C-t で任意補完。選択肢が出てきたらC-nやC-pで上下移動してから決定することも可能
(defvar helm-read-file-map)
(defvar helm-find-files-map)
(defvar helm-generic-files-map)
(define-key helm-find-files-map (kbd "C-t") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "C-t") 'helm-execute-persistent-action)
(define-key helm-generic-files-map (kbd "C-t") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "M-t") 'helm-toggle-resplit-and-swap-windows)
(define-key helm-read-file-map (kbd "M-t") 'helm-toggle-resplit-and-swap-windows)
(define-key helm-generic-files-map (kbd "M-t") 'helm-toggle-resplit-and-swap-windows)
