(eval-after-load "el-get"
  #'(custom-set-variables
     '(el-get-sources
       `((:name init-loader
                :checkout "a2fbec1382")
         (:name open-junk-file
                :before
                (autoload 'open-junk-file "open-junk-file" "" t))
         (:name buffer-move)
         (:name helm
                :checkout "56df0e5c8b")
         (:name migemo
                :checkout "b6fd088296")
         (:name apel)
         (:name auto-async-byte-compile)
         (:name cl-lib)
         (:name howm)
         (:name magit
                :checkout "c775f3d96a")
         (:name php-completion)
         (:name markdown-mode)
         (:name emacs-w3m
                :build/windows-nt
                `((,el-get-emacs
                   "--batch" "-q" "--no-site-file" "-l" "w3mhack.el"
                   "NONE" "-f" "w3mhack-nonunix-install"))
                :info nil)
         (:name dsvn
                :before
                (autoload 'svn-status "dsvn" "Run `svn status'." t)
                (autoload 'svn-update "dsvn" "Run `svn update'." t))
         (:name yasnippet)
         (:name crontab-mode)
         (:name maxframe)
         (:name ruby-mode)
         (:name ruby-block)
         (:name ruby-electric)
         (:name ruby-end)
         (:name scala-mode)
         (:name auto-complete)
         (:name flymake)
         (:name php-mode-improved)
         (:name scala-mode2)
         (:name helm-gtags)
         (:name bookmark+)
         (:name php-eldoc)
         (:name ensime)
         (:name htmlize)
         (:name git-gutter)
         (:name git-gutter-fringe)
         (:name multiple-cursors)
         (:name sudo-ext)
         (:name haskell-mode
                :build/windows-nt
                (let* ((target-dir (concat el-get-dir "haskell-mode/"))
                       (autoloads-file "haskell-mode-autoloads.el")
                       (generated-autoload-file (concat el-get-dir "haskell-mode/" autoloads-file)))
                  `((,el-get-emacs
                     "--batch" "-q" "--no-site-file" "--eval"
                     ,(concat
                       "(progn (add-to-list (quote load-path) \".\") (ignore-errors (byte-recompile-directory \".\" 0))"
                       (format "(let ((generated-autoload-file \"%s\"))" generated-autoload-file)
                       (format "(update-directory-autoloads \"%s\")))" target-dir)))))
                :info nil
                :features haskell-mode-autoloads
                :autoloads nil)
         (:name emacs-mozc)
         (:name color-moccur)
         (:name helm-migemo)
         (:name helm-descbinds)
         (:name jaspace)
         (:name recentf-ext)
         (:name popwin)
         (:name anzu)
         (:name wanderlust)))))