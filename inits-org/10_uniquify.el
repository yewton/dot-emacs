(require 'uniquify)
(custom-set-variables
 ;; Makefile<foo/bar> といったスタイルを適用する
 '(uniquify-buffer-name-style 'post-forward-angle-brackets)
 ;; 最低でもひとつはディレクトリ名を付与する
 '(uniquify-min-dir-content 1))
