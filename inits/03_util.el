(defun my:insert-current-time ()
  (interactive)
  (insert (format-time-string "%Y/%m/%d %H:%M:%S")))
(global-set-key [f5] #'my:insert-current-time)
