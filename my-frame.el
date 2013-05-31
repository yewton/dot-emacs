;; frame
(defvar default-frame-top 0)
(defvar default-frame-left 0)
(defvar default-frame-width 100)
(defvar default-frame-height 48)
(defvar default-frame-alpha 90)

(setq initial-frame-alist
      (append
       (list
        (cons 'top default-frame-top)
        (cons 'left default-frame-left)
        (cons 'width default-frame-width)
        (cons 'height default-frame-height)
        (cons 'alpha default-frame-alpha))
       initial-frame-alist))
(setq default-frame-alist
      (append
       (list
        (cons 'width default-frame-width)
        (cons 'height default-frame-height)
        (cons 'alpha default-frame-alpha))
       default-frame-alist))

(require 'maxframe)
(defvar my-frame-max-flag nil)
(defun my-toggle-frame-size ()
  (interactive)
  (if my-frame-max-flag
      (progn
        (restore-frame)
        (setq my-frame-max-flag nil))
    (maximize-frame)
    (setq my-frame-max-flag t)))
(add-hook 'window-setup-hook 'maximize-frame t)
(global-set-key [f11] 'my-toggle-frame-size)
