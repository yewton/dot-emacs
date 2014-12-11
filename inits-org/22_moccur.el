(require 'color-moccur)
(require 'moccur-edit)
(custom-set-variables
 '(*moccur-buffer-name-exclusion-list*
   '("TAGS" "^*.*" "^[ ].+"))
 '(moccur-use-migemo t))
(global-set-key (kbd "C-M-o") #'moccur)

;; Local Variables:
;; byte-compile-warnings: (not unresolved)
;; End:
