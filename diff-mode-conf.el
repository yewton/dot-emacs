;; Emacs上でカラフルにdiffを表示する - ククログ(2012-04-03) <http://www.clear-code.com/blog/2012/4/3.html>
;; diffの表示方法を変更
(declare-function diff-auto-refine-mode "diff-mode.el" (&optional ARG))
(set-face-attribute 'diff-added nil
                    :foreground "white" :background "dark green")
(set-face-attribute 'diff-removed nil
                    :foreground "white" :background "dark red")
(set-face-attribute 'diff-refine-change nil
                    :background
                    :foreground nil :background nil
                    :weight 'bold :inverse-video t)
;; diffを表示したらすぐに文字単位での強調表示も行う
(add-hook 'diff-mode-hook '(lambda () (diff-auto-refine-mode t)))
;; diffを表示しているときに文字単位での変更箇所も強調表示する
;; 'allではなくtにすると現在選択中のhunkのみ強調表示する
(custom-set-variables
 '(magit-diff-refine-hunk 'all))
