;; EmacsでMozcを使うための設定 | ユービックログ研究所 <http://www.ubiqlog.com/archives/8538>
(global-set-key (kbd "M-`") 'toggle-input-method)
(global-set-key (kbd "C-\\") 'toggle-input-method)
(customize-set-value 'default-input-method "japanese-mozc")