(eval-after-load "calendar"
  #'(progn
     (require 'japanese-holidays)
     ;;(add-to-list 'holiday-other-holidays japanese-holidays)
     (custom-set-variables
      '(holiday-local-holidays japanese-holidays)
      '(calendar-holidays holiday-local-holidays)
      '(mark-holidays-in-calendar t))
     (add-hook 'calendar-today-visible-hook #'japanese-holiday-mark-weekend)
     (add-hook 'calendar-today-invisible-hook #'japanese-holiday-mark-weekend)))
