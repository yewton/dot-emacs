;; el-get
(defvar my:el-get-base-dir (concat user-emacs-directory "el-get/"))
(defvar my:el-get-sources-file (concat my:el-get-base-dir "el-get-sources.el"))
(defvar el-get-dir (concat my:el-get-base-dir "el-get/"))
(defvar el-get-git-install-url "https://github.com/dimitri/el-get.git")
(defvar el-get-github-default-url-type "https")
(add-to-list 'load-path (concat el-get-dir "el-get/"))

;; el-get で入っている org-mode があればそちらを使うための記述
(when (and (require 'el-get nil t) (fboundp 'el-get-package-directory))
  (let ((dirs (list "." "lisp" "contrib/lisp")))
    (mapc (lambda (dir)
            (add-to-list
             'load-path
             (expand-file-name (concat (el-get-package-directory 'org-mode) "/" dir))))
          dirs)))

(require 'bytecomp)
(require 'org)

(defun my:org-babel-tangle-and-byte-recompile-file (filename &optional force arg load)
  "`org-babel-tangle-file' したあと `byte-recompile-file' する。"
  (let* ((basename (file-name-sans-extension filename))
         (org (concat basename ".org"))
         (el (concat basename ".el")))
    (when (file-newer-than-file-p org el)
      (org-babel-tangle-file org el "emacs-lisp"))
    (when (file-exists-p el)
      (byte-recompile-file el force arg load))))

;; 独自マクロ
(my:org-babel-tangle-and-byte-recompile-file (concat user-emacs-directory "my-macros.el") nil 0)
;; 独自関数
(my:org-babel-tangle-and-byte-recompile-file (concat user-emacs-directory "my-functions.el") nil 0)

;; exec-path の設定
(when (eq window-system 'ns)
  (my:org-babel-tangle-and-byte-recompile-file (concat user-emacs-directory "my-exec-path-from-shell-path.el") nil 0 t))

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
(byte-recompile-file my:el-get-sources-file nil 0 t)
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
 `(init-loader-directory ,(concat user-emacs-directory "inits"))
 '(init-loader-show-log-after-init t)
 '(init-loader-byte-compile t))

;; inits 以下の org ファイルをすべて el に変換
(loop for org in (directory-files init-loader-directory t)
      unless (string-match
              "\\(\\`README\\.org\\'\\)\\|\\(\\.el\\'\\)"
              (file-name-nondirectory org))
      do (my:org-babel-tangle-and-byte-recompile-file org nil 0))

(init-loader-load)

;; Local Variables:
;; byte-compile-warnings: (not obsolete)
;; End:
