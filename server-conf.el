(require 'server)
(when (and (>= emacs-major-version 23)
           (equal window-system 'w32))
  (defun server-ensure-safe-dir (dir) "Noop" t))
(custom-set-variables
 '(server-auth-dir "~/.emacs.d/server"))
(unless (server-running-p)
  (server-start))
