;; Emacs上でカラフルにdiffを表示する - ククログ(2012-04-03) <http://www.clear-code.com/blog/2012/4/3.html>
;; diffの表示方法を変更
(eval-when-compile
  (require 'magit))
(declare-function diff-auto-refine-mode "diff-mode.el" (&optional ARG))
(defun diff-mode-setup-faces ()
  ;; 追加された行は緑で表示
  (set-face-attribute 'diff-added nil
                      :foreground "white" :background "dark green")
  (set-face-attribute 'magit-diff-add nil
                      :foreground "white" :background "dark green")
  ;; 削除された行は赤で表示
  (set-face-attribute 'diff-removed nil
                      :foreground "white" :background "dark red")
  (set-face-attribute 'magit-diff-del nil
                      :foreground "white" :background "dark red")
  ;; 文字単位での変更箇所は色を反転して強調
  (set-face-attribute 'diff-refine-change nil
                      :foreground nil :background nil
                      :weight 'bold :inverse-video t))
(add-hook 'diff-mode-hook 'diff-mode-setup-faces)
;; diffを表示したらすぐに文字単位での強調表示も行う
(defun diff-mode-refine-automatically ()
  (diff-auto-refine-mode t))
(add-hook 'diff-mode-hook 'diff-mode-refine-automatically)
;; diffを表示しているときに文字単位での変更箇所も強調表示する
;; 'allではなくtにすると現在選択中のhunkのみ強調表示する
(custom-set-variables
 '(magit-diff-refine-hunk 'all))
;; diff関連の設定
(defun magit-setup-diff ()
  ;; diff用のfaceを設定する
  (diff-mode-setup-faces)
  ;; diffの表示設定が上書きされてしまうのでハイライトを無効にする
  ;; (set-face-attribute 'magit-item-highlight nil :inherit nil))
  )
(add-hook 'magit-mode-hook 'magit-setup-diff)
