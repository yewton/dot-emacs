;;; 試行錯誤用ファイルを開くための設定
;; C-x C-zで試行錯誤ファイルを開く
(global-set-key (kbd "C-x C-z") 'open-junk-file)
(customize-set-value 'open-junk-file-directory
                     (concat user-emacs-directory "junk/%Y/%m/%d-%H%M%S."))