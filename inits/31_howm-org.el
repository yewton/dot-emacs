(eval-after-load "howm"
  #'(progn
      (defun my:org-mode-hook ()
        (howm-mode)
        (iimage-mode)
        (show-all))
      (add-hook 'org-mode-hook #'my:org-mode-hook)
      (add-to-list 'auto-mode-alist '("\\.howm$" . org-mode))))
