(defun check-font-lock (fpath)
  "check font lock"
  (let ((ret1 (gather-all-property-change 'haskell-mode fpath 'face))
        (ret2 (gather-all-property-change 'haskell-mode fpath 'face)))
    (equal ret1 ret2)))
;;    ret2))

(defun gather-all-property-change (mode fpath prop)
  "return the alist of positions and property values of propety changes."
  (with-temp-buffer
    (insert-file-contents fpath)
    (widen)
    (setq font-lock-extend-after-change-region-function (cons (point-min) (point-max)))
    (setq default-major-mode mode)
    (set-buffer-major-mode (current-buffer))
    (font-lock-fontify-buffer)
    (setq ret1 (gather-buffer-all-property-change 'face))))
  

(defun gather-buffer-all-property-change (prop)
  "return the alist of positions and property values of propety changes."
  (interactive)
  (let ((p 1) val ret)
    (while p
      (goto-char p)
      (setq val (get-text-property p prop))
      (setq ret (cons (cons p val) ret))
      (setq p (next-single-property-change p prop)))
    (nreverse ret)))
