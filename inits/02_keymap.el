(eval-when-compile (require 'my-macros))
(keyboard-translate ?\C-h ?\C-?)
(my:global-set-keys
 ;; 指定行ジャンプ
 ((kbd "M-g") 'goto-line)
 ;; なにもしなくていい
 ((kbd "C-\\") 'ignore)
 ([M-kanji] 'ignore)
 ;; EmacsWiki: Backspace Key
 ;; http://www.emacswiki.org/emacs/BackspaceKey
 ((kbd "C-h") 'delete-backward-char)
 ((kbd "M-h") 'backward-kill-word)
 ((kbd "C-c h") 'help-command)
 ([backspace] 'help-command)) ;; 矯正用
