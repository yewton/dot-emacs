(require 'google-translate)
(custom-set-variables
 '(google-translate-default-source-language "en")
 '(google-translate-default-target-language "ja"))
(global-set-key (kbd "C-x C-t") 'google-translate-at-point)
