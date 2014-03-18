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
                :checkout "6209019149ba50b05ce0bed5fa77cf90d33c9f71")
         (:name migemo
                :checkout "b6fd088296")
         (:name apel)
         (:name auto-async-byte-compile)
         (:name cl-lib)
         (:name howm)
         (:name magit
                :checkout "c775f3d96a"
                :build/windows-nt
                (let* ((target-dir (concat el-get-dir "magit/"))
                       (autoloads-file "magit-autoloads.el")
                       (generated-autoload-file (concat target-dir autoloads-file)))
                  `((,el-get-emacs
                     "--batch" "-q" "--no-site-file" "--eval"
                     ,(concat
                       "(progn (add-to-list (quote load-path) \".\") (ignore-errors (byte-recompile-directory \".\" 0))"
                       (format "(let ((generated-autoload-file \"%s\"))" generated-autoload-file)
                       (format "(update-directory-autoloads \"%s\")))" target-dir)))))
                :info nil
                :features magit-autoloads
                :autoloads nil)
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
         (:name yasnippet
                :checkout "refs/tags/0.8.0"
                :submodule ,(if (or (eq window-system 'w32) (null window-system)) nil t))
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
                       (generated-autoload-file (concat target-dir autoloads-file)))
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
         (:name wanderlust)
         (:name japanese-holidays)
         (:name ag)
         (:name wikitext-mode
                :before
                (autoload 'wikitext-mode
                  "wikitext-mode.el"
                  "Major mode for editing wiki-documents." t))
         (:name web-mode
                :before
                (autoload 'web-mode
                  "web-mode.el"
                  "Major mode for editing web templates:
HTML files embedding parts (CSS/JavaScript)
and blocks (PHP, Erb, Django/Twig, Smarty, JSP, ASP, etc.)" t))
         (:name rainbow-mode)
         (:name rainbow-delimiters)
         (:name js2-mode)
         (:name pig-mode)
         (:name auto-highlight-symbol)
         (:name dired+)
         (:name lispxmp)
         (:name google-translate)
         (:name plantuml-mode)
         (:name coffee-mode)))))
