;; デフォルトフレームの設定
(defvar default-frame-top)
(defvar default-frame-left)
(defvar default-frame-width)
(defvar default-frame-height)
(defvar default-frame-alpha)
(setq default-frame-top 0)
(setq default-frame-left 0)
(setq default-frame-width 100)
(setq default-frame-height 50)
(setq default-frame-alpha 85)
;; exec-path の設定
(defvar cocoa-p)
(when cocoa-p
  (defvar path-list
    '("/usr/local/bin"
      "/usr/bin"
      "/bin"
      "/usr/sbin"
      "/sbin"
      "/usr/X11/bin"
      "/opt/local/bin"
      "/opt/local/sbin"
      "/usr/local/share/gtags/script"
      "~/.cabal/bin"))
  (setenv "PATH"
          (mapconcat #'identity path-list ":"))
  (mapc (lambda (path) (add-to-list 'exec-path path)) (reverse path-list)))
;; migemo
(defvar migemo-command)
(defvar migemo-options)
(defvar migemo-coding-system)
(defvar migemo-dictionary)
(let ((migemo-executable (executable-find "cmigemo")))
  (when migemo-executable
    (setq migemo-command migemo-executable)
    (setq migemo-options '("-q" "--emacs"))
    (setq migemo-coding-system 'utf-8)
    (setq migemo-dictionary
          (concat
           (file-name-directory (file-truename migemo-executable))
           "../share/migemo/utf-8/migemo-dict"))))
(custom-set-variables
 '(el-get-sources
   `((:name emacs-w3m
        :build/windows-nt
        (,(concat el-get-emacs
              " -batch -q -no-site-file -l w3mhack.el"
              " NONE -f w3mhack-nonunix-install"))
        :info nil))))
