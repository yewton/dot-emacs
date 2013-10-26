;;; 試行錯誤用ファイルを開くための設定
(autoload 'open-junk-file "open-junk-file" "" t)
;; C-x C-zで試行錯誤ファイルを開く
(global-set-key (kbd "C-x C-z") 'open-junk-file)
