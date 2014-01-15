(custom-set-variables
 '(scala-interpreter "scala -Dfile.encoding=UTF-8"))
(require 'ensime)
(add-hook 'scala-mode-hook #'ensime-scala-mode-hook)
