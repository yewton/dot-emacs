(when (display-graphic-p)
  (eval-and-compile (require 'maxframe))
  (defvar my:frame-max-flag nil)
  (defun my:toggle-frame-size ()
    (interactive)
    (if my:frame-max-flag
        (progn
          (restore-frame)
          (setq my:frame-max-flag nil))
      (maximize-frame)
      (setq my:frame-max-flag t)))
  (add-hook 'window-setup-hook 'maximize-frame t)
  (global-set-key [f11] 'my:toggle-frame-size))
