;; win32

;;;; emacsのmagitの性能を改善した - さくらんぼのlambda日記 <http://lambdasakura.hatenablog.com/entry/2013/03/22/000211>
(eval-when-compile
  (require 'magit))
(defvar magit-git-log-options)
(declare-function view-mode &optional ARG)
;; フォーマットを変えないと実行失敗するので修正
(setq magit-git-log-options
      (list
       "--pretty=format:\"* %h %s\""
       (format "--abbrev=%s" magit-sha1-abbrev-length)))

;; magit-cmd-outputとmagit-run*をこんな感じに書き換えた
(defun magit-cmd-output (cmd args)
  (let* ((arg (apply #'concatenate 'string (mapcar #'(lambda (x) (concatenate 'string " " x)) args)))
         ;; execute git command
         (cmd-output  (shell-command-to-string (concatenate 'string cmd arg))))
    (replace-regexp-in-string "\e\\[.*?m" "" cmd-output)))

(defun magit-run* (cmd-and-args
                   &optional logline noerase noerror nowait input)
  (if (and magit-process
           (get-buffer magit-process-buffer-name))
      (error "Git is already running"))
  (let ((cmd (car cmd-and-args))
        (args (cdr cmd-and-args))
        (dir default-directory)
        (buf (get-buffer-create magit-process-buffer-name))
        (successp nil))
    (magit-set-mode-line-process
     (magit-process-indicator-from-command cmd-and-args))
    (setq magit-process-client-buffer (current-buffer))
    (with-current-buffer buf
      (view-mode 1)
      (set (make-local-variable 'view-no-disable-on-exit) t)
      (setq view-exit-action
            (lambda (buffer)
              (with-current-buffer buffer
                (bury-buffer))))
      (setq buffer-read-only t)
      (let ((inhibit-read-only t))
        (setq default-directory dir)
        (if noerase
            (goto-char (point-max))
          (erase-buffer))
        (insert "$ " (or logline
                         (mapconcat 'identity cmd-and-args " "))
                "\n")
        (cond (nowait
               (setq magit-process
                     (let ((process-connection-type magit-process-connection-type))
                       (apply 'magit-start-process cmd buf cmd args)))
               (set-process-sentinel magit-process 'magit-process-sentinel)
               (set-process-filter magit-process 'magit-process-filter)
               (when input
                 (with-current-buffer input
                   (process-send-region magit-process
                                        (point-min) (point-max)))
                 (process-send-eof magit-process)
                 (sit-for 0.1 t))
               (cond ((= magit-process-popup-time 0)
                      (pop-to-buffer (process-buffer magit-process)))
                     ((> magit-process-popup-time 0)
                      (run-with-timer
                       magit-process-popup-time nil
                       (function
                        (lambda (buf)
                          (with-current-buffer buf
                            (when magit-process
                              (display-buffer (process-buffer magit-process))
                              (goto-char (point-max))))))
                       (current-buffer))))
               (setq successp t))
              (input
               (with-current-buffer input
                 (setq default-directory dir)
                 (setq magit-process
                       ;; Don't use a pty, because it would set icrnl
                       ;; which would modify the input (issue #20).
                       (let ((process-connection-type nil))
                         (apply 'magit-start-process cmd buf cmd args)))
                 (set-process-filter magit-process 'magit-process-filter)
                 (process-send-region magit-process
                                      (point-min) (point-max))
                 (process-send-eof magit-process)
                 (while (equal (process-status magit-process) 'run)
                   (sit-for 0.1 t))
                 (setq successp
                       (equal (process-exit-status magit-process) 0))
                 (setq magit-process nil))
               (magit-set-mode-line-process nil)
               (magit-need-refresh magit-process-client-buffer))
              (t
               (let* ((exec-cmd (apply #'concatenate 'string 
                                       (mapcar #'(lambda (x) (concatenate 'string " " x)) args)))
                      (exec-cmd-output (shell-command-to-string (concatenate 'string "git " exec-cmd))))
                 (insert exec-cmd-output))
               (setq successp (equal "0" (shell-command-to-string "echo $?")))
               (magit-set-mode-line-process nil)
               (magit-need-refresh magit-process-client-buffer))))
      (or successp
          noerror
          (error
           "%s ... [Hit %s or see buffer %s for details]"
           (or (with-current-buffer (get-buffer magit-process-buffer-name)
                 (when (re-search-backward
                        (concat "^error: \\(.*\\)" paragraph-separate) nil t)
                   (match-string 1)))
               "Git failed")
           (with-current-buffer magit-process-client-buffer
             (key-description (car (where-is-internal
                                    'magit-display-process))))
           magit-process-buffer-name))
      successp)))
