(defvar my:wl-dir (concat user-emacs-directory "wl/"))
(custom-set-variables
 `(wl-temporary-file-directory ,(concat user-emacs-directory "temp/"))
 `(wl-init-file ,(concat my:wl-dir "init.el"))
 `(wl-folders-file ,(concat my:wl-dir "folders.conf"))
 `(wl-address-file ,(concat my:wl-dir "addresses"))
 `(wl-address-file ,(concat my:wl-dir "aliases")))
(when (boundp 'mail-user-agent)
    (customize-set-value 'mail-user-agent 'wl-user-agent))
(when (boundp 'read-mail-command)
  (customize-set-value 'read-mail-command 'wl))
(when (fboundp 'define-mail-user-agent)
  (define-mail-user-agent
    'wl-user-agent
    'wl-user-agent-compose
    'wl-draft-send
    'wl-draft-kill
    'mail-send-hook))
