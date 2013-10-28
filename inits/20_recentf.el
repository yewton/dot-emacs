(custom-set-variables
 `(recentf-save-file ,(concat user-emacs-directory "recentf/history"))
 '(recentf-max-saved-items 50))
(require 'recentf-ext)
(defadvice recentf-open-files (after recentf-set-overlay-directory-adv activate)
  (set-buffer "*Open Recent*")
  (save-excursion
    (while (re-search-forward "\\(^ \\[[0-9]\\] \\|^ \\)\\(.*/\\)$" nil t nil)
      (overlay-put (make-overlay (match-beginning 2) (match-end 2))
                   'face `((:foreground ,"#F1266F"))))))
