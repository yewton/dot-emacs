(require 'jaspace)
(custom-set-variables
 '(jaspace-alternate-jaspace-string nil) ;; 　　全角スペース　　
 '(jaspace-alternate-eol-string nil)     ;; 改行文字   
 '(jaspace-highlight-tabs t)             ;; 	タブ文字
 '(show-trailing-whitespace t))
(set-face-background 'jaspace-highlight-jaspace-face "gray30")
(set-face-background 'jaspace-highlight-tab-face "gray15")
(custom-set-faces
 '(trailing-whitespace
   ((t (:foreground "SteelBlue" :background nil :underline t :inverse-video nil)))))