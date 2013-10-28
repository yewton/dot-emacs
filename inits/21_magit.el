;;;; magit
;; diffを表示しているときに文字単位での変更箇所も強調表示する
;; 'allではなくtにすると現在選択中のhunkのみ強調表示する
(custom-set-variables
 '(magit-diff-refine-hunk 'all)
 '(magit-git-executable (if (eq window-system 'w32) "c:/Git/bin/git.exe" "git")))
