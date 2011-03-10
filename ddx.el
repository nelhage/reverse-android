(defconst ddx-dex-opcode-list
  (list
   "nop" "move" "move/from16" "move/16"
   "move-wide" "move-wide/from16" "move-wide/16" "move-object"
   "move-object/from16" "move-object/16" "move-result" "move-result-wide"
   "move-result-object" "move-exception" "return-void" "return"
   "return-wide" "return-object" "const/4" "const/16"
   "const" "const/high16" "const-wide/16" "const-wide/32"
   "const-wide" "const-wide/high16" "const-string" "const-string/jumbo"
   "const-class" "monitor-enter" "monitor-exit" "check-cast"
   "instance-of" "array-length" "new-instance" "new-array"
   "filled-new-array" "filled-new-array/range" "fill-array-data" "throw"
   "goto" "goto/16" "goto/32" "packed-switch"
   "sparse-switch" "cmpl-float"
   "cmpg-float" "cmpl-double" "cmpg-double" "cmp-long"
   "if-eq" "if-ne"
   "if-lt" "if-ge" "if-gt" "if-le"
   "if-" "z" "if-eqz" "if-nez"
   "if-ltz" "if-gez" "if-gtz" "if-lez"
   "aget" "aget-wide" "aget-object"
   "aget-boolean" "aget-byte" "aget-char" "aget-short"
   "aput" "aput-wide" "aput-object" "aput-boolean"
   "aput-byte" "aput-char" "aput-short"
   "iget" "iget-wide" "iget-object"
   "iget-boolean" "iget-byte" "iget-char" "iget-short"
   "iput" "iput-wide" "iput-object" "iput-boolean"
   "iput-byte" "iput-char" "iput-short"
   "sget" "sget-wide" "sget-object"
   "sget-boolean" "sget-byte" "sget-char" "sget-short"
   "sput" "sput-wide" "sput-object" "sput-boolean"
   "sput-byte" "sput-char" "sput-short"
   "invoke-virtual" "invoke-super" "invoke-direct"
   "invoke-static" "invoke-interface" "invoke-" "/range"
   "invoke-virtual/range" "invoke-super/range" "invoke-direct/range" "invoke-static/range"
   "invoke-interface/range" "neg-int" "not-int"
   "neg-long" "not-long" "neg-float" "neg-double"
   "int-to-long" "int-to-float" "int-to-double" "long-to-int"
   "long-to-float" "long-to-double" "float-to-int" "float-to-long"
   "float-to-double" "double-to-int" "double-to-long" "double-to-float"
   "int-to-byte" "int-to-char" "int-to-short"
   "add-int" "sub-int" "mul-int" "div-int"
   "rem-int" "and-int" "or-int" "xor-int"
   "shl-int" "shr-int" "ushr-int" "add-long"
   "sub-long" "mul-long" "div-long" "rem-long"
   "and-long" "or-long" "xor-long" "shl-long"
   "shr-long" "ushr-long" "add-float" "sub-float"
   "mul-float" "div-float" "rem-float" "add-double"
   "sub-double" "mul-double" "div-double" "rem-double"
   "/2addr" "add-int/2addr" "sub-int/2addr" "mul-int/2addr"
   "div-int/2addr" "rem-int/2addr" "and-int/2addr" "or-int/2addr"
   "xor-int/2addr" "shl-int/2addr" "shr-int/2addr" "ushr-int/2addr"
   "add-long/2addr" "sub-long/2addr" "mul-long/2addr" "div-long/2addr"
   "rem-long/2addr" "and-long/2addr" "or-long/2addr" "xor-long/2addr"
   "shl-long/2addr" "shr-long/2addr" "ushr-long/2addr" "add-float/2addr"
   "sub-float/2addr" "mul-float/2addr" "div-float/2addr" "rem-float/2addr"
   "add-double/2addr" "sub-double/2addr" "mul-double/2addr" "div-double/2addr"
   "rem-double/2addr" "/lit16" "add-int/lit16" "rsub-int"
   "mul-int/lit16" "div-int/lit16" "rem-int/lit16" "and-int/lit16"
   "or-int/lit16" "xor-int/lit16" "/lit8" "add-int/lit8"
   "rsub-int/lit8" "mul-int/lit8" "div-int/lit8" "rem-int/lit8"
   "and-int/lit8" "or-int/lit8" "xor-int/lit8" "shl-int/lit8"
   "shr-int/lit8" "ushr-int/lit8"))

(defvar ddx-mode-font-lock-keywords
  (list
   (cons "\\(^\\|\\s \\);.*" font-lock-comment-face)
   (cons (concat "\\<" (regexp-opt ddx-dex-opcode-list) "\\>")
         font-lock-builtin-face)
   (cons (concat "\\<" (regexp-opt '("private" "public" "static" "final")) "\\>")
         font-lock-keyword-face)
   (cons (concat "\\.\\<" (regexp-opt '("field" "method" "limit"
                                        "throws" "catch" "class"
                                        "super" "var" "line"
                                        "registers" "annotation"
                                        "end" "source" "inner"
                                        "local" "parameter"
                                        "catchall")) "\\>")
         font-lock-preprocessor-face)
   (cons "\\<[vp][[:digit:]]+\\>" font-lock-variable-name-face)))

(defvar ddx-mode-map
  (let ((ddx-mode-map (make-sparse-keymap)))
    (define-key ddx-mode-map (kbd "M-.") 'ddx-goto-label)
    (define-key ddx-mode-map (kbd "M-n") 'ddx-label-goto-next-reference)
    (define-key ddx-mode-map (kbd "M-p") 'ddx-label-goto-prev-reference)
    ddx-mode-map)
  "Keymap for DDX major mode")

(defvar smali-mode-map
  (let ((smali-mode-map (make-sparse-keymap)))
    (set-keymap-parent smali-mode-map ddx-mode-map)
    (define-key smali-mode-map (kbd "M-.") 'ddx-smali-goto-label)
    smali-mode-map)
  "Keymap for smali major mode")

(defvar ddx-mode-syntax-table
  (let ((ddx-mode-syntax-table (make-syntax-table)))
    (modify-syntax-entry ?_ "w" ddx-mode-syntax-table)
    (modify-syntax-entry ?\# "<" ddx-mode-syntax-table)
    (modify-syntax-entry ?\n ">" ddx-mode-syntax-table)
    ddx-mode-syntax-table))

(defun ddx-indent-line ()
  "Indent the current line as DDX code"
  (interactive)
  )

(defun ddx-goto-label (&optional label)
  (interactive)
  (if (not label)
      (setq label (thing-at-point 'word)))
  (beginning-of-buffer)
  (re-search-forward (concat "^" label ":")))

(defun ddx-smali-goto-label (&optional label)
  (interactive)
  (if (not label)
      (setq label (thing-at-point 'word)))
  (beginning-of-buffer)
  (re-search-forward (concat "^\\s +:" label "\\>")))

(defface ddx-label-highlight
  '((t :background "#003"))
  "Face to highlabel selected label in ddx-mode")

(set-face-background 'ddx-label-highlight "#33a")

(defun ddx-highlight-label (label)
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((marks ()))
      (while (re-search-forward (concat "\\<" label "\\>") nil t)
        (let ((start (match-beginning 0))
              (end   (match-end 0)))
          (let ((ov (make-overlay start end)))
            (setq marks (cons (copy-marker start) marks))
            (overlay-put ov 'ddx-label-highlight t)
            (overlay-put ov 'face 'ddx-label-highlight))))
      (setq ddx-highlighted-label-marks (vconcat (reverse marks)))))
  (let ((i 0))
    (while (and (< i (length ddx-highlighted-label-marks))
                (< (point)
                   (aref ddx-highlighted-label-marks i)))
      (setq i (+ 1 i)))))

(defun ddx-label-goto-next-reference ()
  (interactive)
  (ddx-label-move-reference 1))

(defun ddx-label-goto-prev-reference ()
  (interactive)
  (ddx-label-move-reference -1))

(defun ddx-label-move-reference (delta)
  (when ddx-highlighted-label-marks
    (setq ddx-highlighted-label-index
          (mod (+ ddx-highlighted-label-index delta)
               (length ddx-highlighted-label-marks)))
    (goto-char (aref ddx-highlighted-label-marks
                     ddx-highlighted-label-index))))

(defun ddx-remove-highlights ()
  (interactive)
  (remove-overlays (point-min) (point-max) 'ddx-label-highlight t)
  (setq ddx-highlighted-label-marks nil))

(defvar ddx-highlighted-label nil
  "The currently-highlighted label")

(defvar ddx-highlighted-label-marks nil
  "A vector of marks for each highlighted label")
(defvar ddx-highlighted-label-index 0
  "The index in `ddx-highlighted-label-marks` of the current label.")

(defvar ddx-all-labels nil
  "All labels in the current buffer")

(defvar ddx-label-re "^\\(\\sw+\\):"
  "A regular expression for the definition site of a label")

(defun ddx-collect-labels ()
  (set (make-local-variable 'ddx-all-labels)
       (make-hash-table :test 'equal))
  (save-excursion
    (beginning-of-buffer)
     (while (re-search-forward ddx-label-re nil t)
       (let ((l (match-string-no-properties 1)))
         (puthash l t ddx-all-labels)))))

(defun ddx-label-at-point ()
  (let ((l (thing-at-point 'word)))
    (set-text-properties 0 (length l) nil l)
    (if (gethash l ddx-all-labels) l nil)))

(defun ddx-highlight-current-label ()
  (let ((l (ddx-label-at-point)))
    (when (not (equal l ddx-highlighted-label))
      (ddx-remove-highlights)
      (if l (ddx-highlight-label l))
      (setq ddx-highlighted-label l))))

(defun ddx-timer-highlight ()
  (save-match-data
    (ddx-highlight-current-label)))

(defvar ddx-idle-timer nil)

(defun ddx-reset-timer ()
  (if ddx-idle-timer (cancel-timer ddx-idle-timer))
  (setq ddx-idle-timer
        (run-with-idle-timer 0.1 t 'ddx-timer-highlight)))

(define-derived-mode ddx-mode fundamental-mode "DDX"
   "Major mode to edit decompiled DEX files."
   (set (make-local-variable 'font-lock-defaults)
        '(ddx-mode-font-lock-keywords))
   (font-lock-add-keywords nil (list (cons ddx-label-re font-lock-constant-face)))
   (use-local-map ddx-mode-map)
   (set-syntax-table ddx-mode-syntax-table)
   (set (make-local-variable 'ddx-highlighted-label) nil)
   (set (make-local-variable 'ddx-highlighted-label-marks) nil)
   (set (make-local-variable 'ddx-highlighted-label-index) 0)
   (ddx-collect-labels)
   (ddx-reset-timer))

(define-derived-mode smali-mode ddx-mode "smali"
  "Major mode to edit .smali assembly files"
  (set (make-local-variable 'ddx-label-re)
       "\\s :\\([a-zA-Z0-9_]+\\)")
  (ddx-collect-labels)
  (font-lock-add-keywords nil (list (cons ddx-label-re font-lock-constant-face)))
  (use-local-map smali-mode-map))

(add-to-list 'auto-mode-alist (cons "\\.ddx$" 'ddx-mode))
(add-to-list 'auto-mode-alist (cons "\\.smali$" 'smali-mode))

(defmacro save-match-data (&rest body)
  "Execute BODY, preserving any pre-existing match data"
  (let ((v (gensym)))
    `(let ((,v (match-data)))
       (unwind-protect
           (progn ,@body)
         (set-match-data ,v)))))

(provide 'ddx)
