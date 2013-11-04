(eval-after-load "calendar"
  #'(progn
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
        (define-key calendar-mode-map "l" 'calendar-forward-day)
        (define-key calendar-mode-map "h" 'calendar-backward-day)
        (define-key calendar-mode-map "j" 'calendar-forward-week)
        (define-key calendar-mode-map "k" 'calendar-backward-week))
      (add-hook 'calendar-mode-hook #'my:calendar-load-hook)
      (add-hook 'calendar-today-visible-hook 'calendar-mark-today)))

;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
