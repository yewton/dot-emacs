;; Removing Killed Buffers from the History <http://www.emacswiki.org/emacs/MinibufferHistory#toc4>
(add-hook
 'kill-buffer-hook
 #'(lambda ()
     (setq buffer-name-history
           (delete
            (buffer-name)
            buffer-name-history))))
