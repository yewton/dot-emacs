(eval-after-load 'dired
  #'(progn
      (define-key ctl-x-map "d" #'diredp-dired-files)
      (define-key ctl-x-4-map "d" #'diredp-dired-files-other-window)
      (define-key dired-mode-map "r" #'wdired-change-to-wdired-mode)))
(eval-after-load 'dired+
  #'(progn
      (diredp-toggle-find-file-reuse-dir t)))