;; Configuring Emacs on Mac OS X <http://korewanetadesu.com/software/emacs-on-os-x.html>
(when (featurep 'ns)
  (defun ns-raise-emacs ()
    "Raise Emacs."
    (ns-do-applescript "tell application \"Emacs\" to activate"))

  (when (display-graphic-p)
    (add-hook 'server-visit-hook 'ns-raise-emacs)
    (add-hook 'before-make-frame-hook 'ns-raise-emacs)
    (ns-raise-emacs)))

;; Local Variables:
;; byte-compile-warnings: (not unresolved)
;; End: