(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "M-x") 'helm-M-x)
;; 無視するファイルを指定
(custom-set-variables
 '(helm-ff-auto-update-initial-value nil) ; 自動補完を無効
 '(helm-ff-file-name-history-use-recentf nil)
 '(helm-findutils-skip-boring-files t) ; 無視ファイルを非表示
 '(helm-for-files-preferred-list
   '(helm-source-locate helm-source-buffers-list helm-source-bookmarks helm-source-recentf helm-source-file-cache helm-source-files-in-current-dir))
 '(helm-boring-file-regexp-list
   '("\\.git$" "\\.hg$" "\\.svn$" "\\.CVS$" "\\._darcs$" "\\.la$" "\\.o$" "~$"
     "\\.class$" "\\.elc$")))
;; 無視ファイルを表示しない
(require 'helm-files)
(defadvice helm-ff-directory-files (after ad-helm-find-files-skip-boring-files activate)
 (when helm-findutils-skip-boring-files
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
;; from dot-emacs/dot.emacs.d/inits/40_helm.el at master · handlename/dot-emacs
;; https://github.com/handlename/dot-emacs/blob/master/dot.emacs.d/inits/40_helm.el
;; overwrite helm debugging command prefix
(eval-after-load 'helm
  '(progn
     (define-key helm-map (kbd "C-h") 'delete-backward-char)))
(eval-after-load 'helm-files
  '(progn
     (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)))
(eval-after-load 'helm-c-moccur
  '(progn
     (define-key helm-c-moccur-helm-map (kbd "C-h") 'delete-backward-char)))
