(require 'helm-gtags)
;;; Enable helm-gtags-mode
(add-hook 'php-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)
;; customize
(setq helm-gtags-path-style 'relative)
(setq helm-gtags-ignore-case t)
(setq helm-gtags-read-only t)
;; key bindings
(add-hook 'helm-gtags-mode-hook
          '(lambda ()
              (local-set-key (kbd "C-c t") 'helm-gtags-find-tag)
              (local-set-key (kbd "M-.")   'helm-gtags-find-tag)
              (local-set-key (kbd "C-c r") 'helm-gtags-find-rtag)
              (local-set-key (kbd "C-c s") 'helm-gtags-find-symbol)
              (local-set-key (kbd "C-t")   'helm-gtags-pop-stack)
              (local-set-key (kbd "M-*")   'helm-gtags-pop-stack)))
