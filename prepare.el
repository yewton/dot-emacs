;; 変数宣言
(defvar default-frame-top)
(defvar default-frame-left)
(defvar default-frame-width)
(defvar default-frame-height)
(defvar default-frame-alpha)
(defvar migemo-command)
(defvar migemo-options)
(defvar migemo-coding-system)
(defvar migemo-dictionary)

;; デフォルトフレームの設定
(setq default-frame-top 0)
(setq default-frame-left 0)
(setq default-frame-width 100)
(setq default-frame-height 50)
(setq default-frame-alpha 85)

;; migemo
(let ((migemo-executable (executable-find "cmigemo")))
  (when migemo-executable
    (setq migemo-command migemo-executable)
    (setq migemo-options '("-q" "--emacs"))
    (setq migemo-coding-system 'utf-8)
    (setq migemo-dictionary
          (concat
           (file-name-directory (file-truename migemo-executable))
           "../share/migemo/utf-8/migemo-dict"))))

