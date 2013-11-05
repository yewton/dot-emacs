(require 'bytecomp)

;; 独自マクロ
(byte-recompile-file (concat user-emacs-directory "my-macros.el") nil 0)
;; 独自関数
(byte-recompile-file (concat user-emacs-directory "my-functions.el") nil 0)

;; exec-path の設定
(when (eq window-system 'ns)
  (byte-recompile-file (concat user-emacs-directory "my-exec-path-from-shell-path.el") nil 0 t))

;; el-get
(defvar my:el-get-base-dir (concat user-emacs-directory "el-get/"))
(defvar my:el-get-sources-file (concat my:el-get-base-dir "el-get-sources"))
(defvar el-get-dir (concat my:el-get-base-dir "el-get/"))
(defvar el-get-git-install-url "https://github.com/dimitri/el-get.git")
(defvar el-get-github-default-url-type "https")
(add-to-list 'load-path (concat el-get-dir "el-get/"))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))
(require 'el-get)
(custom-set-variables
 '(package-archives
   '(("gnu" . "http://elpa.gnu.org/packages/")
     ("tromey" . "http://tromey.com/elpa/")
     ("marmalade" . "http://marmalade-repo.org/packages/"))))
(load my:el-get-sources-file)
(add-to-list 'el-get-recipe-path (concat my:el-get-base-dir "recipes/"))

(defun sync-packages ()
  "Synchronize packages"
  (interactive)
  (el-get 'sync '(el-get package))
  (let ((my-packages (mapcar 'el-get-source-name el-get-sources)))
    (el-get 'sync my-packages)))

;; たまに失敗することがあるので、5 回はリトライする
(setq el-get-verbose t)
(let ((trial (number-sequence 1 5)))
  (while trial
    (condition-case err-var
        (progn
          (sync-packages)
          (setq trial nil))
      (error
       (message "Trial %d: failed with: %s" (car trial) err-var)
       (setq trial (cdr trial))
       (if trial
	   (sleep-for (car trial))
	 (error "el-get failed with: %s" err-var))))))

;; package
(require 'package)
(package-initialize)

(require 'init-loader)
(custom-set-variables
 '(init-loader-directory (concat user-emacs-directory "inits"))
 '(init-loader-show-log-after-init t)
 '(init-loader-byte-compile t))

(init-loader-load)

;; Local Variables:
;; byte-compile-warnings: (not obsolete)
;; End:
