(defvar howm-file-name-format)
(defvar howm-view-title-header)
(setq howm-file-name-format "%Y/%m/%Y_%m_%d.howm")
(setq howm-view-title-header "*")
(custom-set-variables
 '(howm-menu-lang 'ja))
(require 'howm)
(require 'outline)
(global-set-key "\C-c,," 'howm-menu)
(add-hook 'org-mode-hook
          (lambda ()
            (howm-mode)
            (iimage-mode)
            (show-all)))
(add-to-list 'auto-mode-alist '("\\.howm$" . org-mode))
(custom-set-faces
 '(howm-mode-title-face ((t (:inherit outline-1))))
 '(org-level-1 ((t (:inherit outline-1 :weight bold))))
 '(org-level-2 ((t (:inherit outline-2 :weight bold)))))