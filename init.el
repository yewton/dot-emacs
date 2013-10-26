;; emacs -l init.el のように起動されると load-file-name に init.el のパスが入るので
(when load-file-name
  ;; 設定ファイルの基準となるディレクトリを読み込んだ init.el のあるディレクトリへ変更する
  (setq user-emacs-directory (file-name-directory load-file-name)))
(add-to-list 'load-path user-emacs-directory)

(princ user-emacs-directory)
(load "bootstrap")

;; ;; 設定ディレクトリの場所を設定
;; (require 'my-files)
;; (require 'my-functions)
;; (require 'prepare)

;; ;; prepare.el 読み込み
;; (load-after-recompile my:prepare)

;; ;; before.el があれば読み込み
;; (when (file-exists-p my:before) (load-after-recompile my:before))

;; ;; el-get
;; (add-to-list 'load-path (concat my:el-get-dir "el-get"))
;; (custom-set-variables
;;  `(el-get-dir ,my:el-get-dir)
;;  `(el-get-user-package-directory ,my:el-get-user-package-directory)
;;  '(package-archives
;;    '(("gnu" . "http://elpa.gnu.org/packages/")
;;      ("tromey" . "http://tromey.com/elpa/")
;;      ("marmalade" . "http://marmalade-repo.org/packages/"))))

;; (unless (require 'el-get nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;;     (let (el-get-master-branch)
;;       (goto-char (point-max))
;;       (eval-print-last-sexp))))
;; (require 'el-get)
;; (load "el-get-sources")
;; (defun sync-packages ()
;;   "Synchronize packages"
;;   (interactive)
;;   (el-get 'sync '(el-get package))
;;   (let ((my-packages (mapcar 'el-get-source-name el-get-sources)))
;;     (el-get 'sync my-packages)))
;; (add-to-list 'el-get-recipe-path my:el-get-recipe-dir)
;; (setq el-get-verbose t)

;; ;; たまに失敗することがあるので、5 回はリトライする
;; (let ((trial (number-sequence 1 5)))
;;   (while trial
;;     (condition-case err-var
;;         (progn
;;           (sync-packages)
;;           (setq trial nil))
;;       (error
;;        (message "Trial %d: failed with: %s" (car trial) err-var)
;;        (unless (cdr trial)
;;          (error "el-get failed with: %s" err-var)
;;          (setq trial (cdr trial))
;;          (sleep-for 1))))))

;; ;; package
;; (require 'package)
;; (package-initialize)

;; ;; テーマの読み込み
;; (load-theme 'clarity t)

;; ;; フレーム設定の読み込み
;; (when gui-p (load-after-recompile my:frame))

;; ;; 個別設定ファイルのバイトコンパイル
;; (dolist (file (directory-files my:base-dir t "\\.el$"))
;;   (unless (member (expand-file-name file) my:config-list)
;;     (byte-recompile-file file nil 0)))

;; ;; 共通
;; (load-after-recompile my:common)

;; ;; system 依存
;; (load-after-recompile (cond (w32-p my:win32) (cocoa-p my:cocoa) (x-p my:x) (t my:term)))

;; ;; 雑多
;; (load-after-recompile my:misc)

;; ;; post-init.el 読み込み
;; (load-after-recompile my:post-init)

;; ;; after.el があれば読み込み
;; (when (file-exists-p my:after) (load-after-recompile my:after))

;; Local Variables:
;; byte-compile-warnings: (not cl-functions obolete)
;; End:
