;; カレントバッファの強制再読込を行う
(defun revert-buffer-force ()
  (interactive)
  (revert-buffer t t))
(eval-when-compile (require 'my-macros))
(my:global-set-keys
 ((kbd "C-c C-x C-j") 'revert-buffer-force)
 ((kbd "C-c C-x j") 'revert-buffer-force)
 ((kbd "C-x C-j") 'revert-buffer)
 ((kbd "C-x j") 'revert-buffer))