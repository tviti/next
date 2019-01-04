;;; search-buffer.lisp --- functions to enable searching within a webview

(in-package :next)

(define-parenstatic initialize-search-buffer
  (ps:defvar match-count)
  (defun insert (str index value)
    (+ (ps:chain str (substr 0 index)) value (ps:chain str (substr index))))
  (defun create-search-span (index)
    (ps:let ((el (ps:chain document (create-element "span"))))
      (setf (ps:@ el class-name) "next-search-hint")
      (setf (ps:@ el style display) "none")
      (setf (ps:@ el id) index)
      el))
  (defun indexes (source find)
    (let ((result (make-array)))
      (ps:dotimes (i (ps:chain source length))
        (print i)))))

(define-parenstatic remove-search-hints
  (defun qsa (context selector)
    "Alias of document.querySelectorAll"
    (ps:chain context (query-selector-all selector)))
  (defun search-hints-remove-all ()
    "Removes all the links"
    (ps:dolist (el (qsa document ".next-search-hint"))
      (ps:chain el (remove))))
  (search-hints-remove-all))

(defun document-search-completion-fn ()
  (let ((active-buffer (active-buffer *interface*)))
    (lambda (input)
      (buffer-evaluate-javascript *interface*
       active-buffer
       input
       (lambda (result)
         (setf (completions *minibuffer*) (list result))
         (update-display *minibuffer*)))
      (list "Loading..."))))

(define-command search-document ()
  "Search the current document for a word."
  (initialize-search-buffer)
  (with-result (input (read-from-minibuffer
                       *minibuffer*
                       :completion-function (document-search-completion-fn)
                       :input-prompt "Search (2+ch):"
                       :cleanup-function 'remove-search-hints))
    (print input)))
