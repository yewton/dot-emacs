(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :weight bold))))
 '(org-level-2 ((t (:inherit outline-2 :weight bold)))))
(eval-when-compile (require 'org))
(custom-set-variables
 '(org-adapt-indentation nil))

(defun my:org-mode-hook ()
  (org-display-inline-images))

(add-hook 'org-mode-hook #'my:org-mode-hook)


;; Local Variables:
;; byte-compile-warnings: (not unresolved)
;; End:
