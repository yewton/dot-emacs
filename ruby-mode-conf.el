(add-hook
 'ruby-mode-hook
 '(lambda ()
    ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
    (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
        (flymake-mode 1))
    (c-set-offset 'case-label' 4)
    (c-set-offset 'arglist-intro' 4)
    (c-set-offset 'arglist-cont-nonempty' 4)
    (c-set-offset 'arglist-close' 0)
    (setq tab-width 4)
    (setq indent-tabs-mode nil)
    (setq c-recognize-knr-p nil)
    (setq ruby-deep-indent-paren nil)))

(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

(autoload 'ruby-mode "ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
