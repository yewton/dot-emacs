(require 'helm-config)
(helm-mode 1)
;; 自動補完を無効
(custom-set-variables '(helm-ff-auto-update-initial-value nil))
;; TABで任意補完。選択肢が出てきたらC-nやC-pで上下移動してから決定することも可能
(defvar helm-read-file-map)
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
