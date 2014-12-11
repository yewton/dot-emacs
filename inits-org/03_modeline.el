(display-battery-mode 1)
(custom-set-variables '(battery-mode-line-format " [%b%p%%]"))

(eval-when-compile (require 'cl))

(set-face-attribute 'mode-line nil :box nil)
(set-face-attribute 'mode-line-inactive nil :box nil)
;; mode-lineのモード情報をコンパクトに表示する - Life is very short
;; <http://d.hatena.ne.jp/syohex/20130131/1359646452>
(defvar mode-line-cleaner-alist)
(setq mode-line-cleaner-alist
  '( ;; For minor-mode, first char is 'space'
    (howm-mode . " Hw")
    (iimage-mode . " II")
    (yas-minor-mode . " Ys")
    (eldoc-mode . "")
    (abbrev-mode . "")
    (helm-gtags-mode . " HG")
    (flymake-mode . " Fm")
    (helm-mode . "")
    (anzu-mode . "")
    (auto-complete-mode . "")
    (action-lock-mode . "")
    ;; Major modes
    (org-mode . " Org")
    (lisp-interaction-mode . "Li")
    (python-mode . "Py")
    (ruby-mode . "Rb")
    (emacs-lisp-mode . "EL")
    (markdown-mode . "Md")))
(defun my:clean-mode-line ()
  (interactive)
  (loop for (mode . mode-str) in mode-line-cleaner-alist
        do
        (let ((old-mode-str (cdr (assq mode minor-mode-alist))))
          (when old-mode-str
            (setcar old-mode-str mode-str))
          ;; major mode
          (when (eq mode major-mode)
            (setq mode-name mode-str)))))
(add-hook 'after-change-major-mode-hook 'my:clean-mode-line)

;; emacs:個性的なモードラインを紹介 | mgrace
;; <http://mgrace.info/?p=886>

;; Extra mode line faces
(make-face 'mode-line-read-only-face)
(make-face 'mode-line-modified-face)
(make-face 'mode-line-folder-face)
(make-face 'mode-line-filename-face)
(make-face 'mode-line-mode-face)
(make-face 'mode-line-minor-mode-face)
(make-face 'mode-line-which-func-face)
(make-face 'global-mode-string-face)

(set-face-attribute 'mode-line-read-only-face nil
    :inherit 'mode-line-face
    :weight 'ultra-bold
    :foreground "DarkGreen"
    :background "LightGreen")
(set-face-attribute 'mode-line-modified-face nil
    :inherit 'mode-line-face
    :weight 'ultra-bold
    :foreground "DarkRed"
    :background "goldenrod")
(set-face-attribute 'mode-line-folder-face nil
    :inherit 'mode-line-face
    :foreground "gray60")
(set-face-attribute 'mode-line-filename-face nil
    :inherit 'mode-line-face
    :foreground "yellow"
    :weight 'ultra-bold)
(set-face-attribute 'mode-line-mode-face nil
    :inherit 'mode-line-face
    :weight 'ultra-bold
    :foreground "gray90")
(set-face-attribute 'mode-line-minor-mode-face nil
    :inherit 'mode-line-mode-face
    :weight 'normal
    :foreground "gray60")
(set-face-attribute 'mode-line-which-func-face nil
    :inherit 'mode-line-face
    :foreground "aquamarine")
(set-face-attribute 'global-mode-string-face nil
    :inherit 'mode-line-face
    :foreground "LightGoldenrod3")

;; Helper function
(defun my:shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
        (output ""))
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))
    (while (and path (< (length output) (- max-length 4)))
      (setq output (concat (car path) "/" output))
      (setq path (cdr path)))
    (when path
      (setq output (concat ".../" output)))
    output))

(setq-default mode-line-format
 '("%e"
   mode-line-mule-info
   "%4lL"
   " "
   mode-line-client
   mode-line-remote
   " "
   ;;; read-only or modified status
   (:eval
    (cond (buffer-read-only
           (propertize " RO " 'face 'mode-line-read-only-face))
          ((buffer-modified-p)
           (propertize " ** " 'face 'mode-line-modified-face))
          (t " ")))   mode-line-frame-identification
   "   "
   ;;; directory and buffer/file name
   (:propertize (:eval (my:shorten-directory default-directory 30))
                face mode-line-folder-face)
   (:propertize "%b"
                face mode-line-filename-face)
   ;;; display which-function
   (:propertize
    (:eval
     (let ((hash (gethash (selected-window) which-func-table)))
       (if hash
           (format "<%s>" (replace-regexp-in-string "%" "%%" hash))
         which-func-unknown)))
    face mode-line-which-func-face)
   ;;; print Narrow if appropriate.
   " %n "
   (vc-mode vc-mode)
   "  %["
   (:propertize mode-name
                face mode-line-mode-face)
   "%]"
   (:eval (propertize (format-mode-line minor-mode-alist)
                      'face 'mode-line-minor-mode-face))
   "  "
   (:propertize global-mode-string
                face global-mode-string-face)
   mode-line-end-spaces))
