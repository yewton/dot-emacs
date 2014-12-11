(eval-after-load "calendar"
  #'(progn
      (defun my:calendar-insert-date (&optional format-string time command)
        "Insert current cursor date string to previous buffer."
        (interactive
         (if current-prefix-arg
             (list
              (read-string "Format: " "[%d-%02d-%02d %s]%s")
              (read-string "Time: " (concat " " (format-time-string "%H:%M")))
              (read-string "Command(+@!):" "@"))
           (list "[%d-%02d-%02d%s]%s" "" "@")))
        (let*
            ((date (calendar-cursor-to-date))
             (month (calendar-extract-month date))
             (day (calendar-extract-day date))
             (year (calendar-extract-year date)))
          (calendar-exit)
          (insert (format format-string year month day time command))))
      (defun my:calendar-load-hook ()
        ;; 月
        (custom-set-variables
         '(calendar-month-name-array
           (vconcat
            (mapcar (lambda (n) (concat n "月"))
                    (mapcar 'number-to-string (number-sequence 1 12)))))
         ;; 曜日
         '(calendar-day-name-array
           (vconcat
            (mapcar (lambda (n) (concat (char-to-string n) "曜日")) "日月火水木金土"))))
        (define-key calendar-mode-map "l" #'calendar-forward-day)
        (define-key calendar-mode-map "h" #'calendar-backward-day)
        (define-key calendar-mode-map "j" #'calendar-forward-week)
        (define-key calendar-mode-map "k" #'calendar-backward-week)
        (define-key calendar-mode-map (kbd "<return>") #'my:calendar-insert-date)
        (define-key calendar-mode-map (kbd "<f7>") #'calendar-exit))
      (global-set-key (kbd "<f7>") #'calendar)
      (add-hook 'calendar-mode-hook #'my:calendar-load-hook)
      (add-hook 'calendar-today-visible-hook #'calendar-mark-today)))

;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
