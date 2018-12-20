;;; command.lisp --- command definition functions
;;; This file is licensed under license documents/external/LICENSE1

(in-package :next)

(defclass command ()
  ((name :initarg :name :accessor name)
   (implementation :initarg :impl :accessor impl)
   (documentation :initarg :doc :accessor doc)))

(define-condition documentation-style-warning (style-warning)
  ((name :initarg :name :reader name)
   (subject-type :initarg :subject-type :reader subject-type))
  (:report
   (lambda (condition stream)
     (format stream
             "~:(~A~) ~A doesn't have a documentation string"
             (subject-type condition)
             (name condition)))))

(define-condition command-documentation-style-warning
    (documentation-style-warning)
  ((subject-type :initform 'command)))

(defmacro define-command (name arglist &body body)
  (let ((documentation (if (stringp (first body))
                           (first body)
                           (warn (make-condition
                                  'command-documentation-style-warning
                                  :name name))))
        (body (if (stringp (first body))
                  (rest body)
                  body))
        (keyword-symbol (intern (symbol-name name) :keyword)))
    `(progn
       (defun ,name ,arglist
         (run-hook ,keyword-symbol)
         (echo-dismiss *minibuffer*)
         ,@body)
       (make-instance 'command
                      :name (symbol-name ',name)
                      :impl #',name
                      :doc ,documentation))))

(defmethod initialize-instance :after ((command command) &key)
  (setf (gethash (name command) *available-commands*) command))

(defun command-p (name)
  (gethash name *available-commands*))

(defun run-named-command (name)
  (let ((command (command-p name)))
    (when command
      (with-slots (implementation) command
        (funcall implementation)))))

(defun complete-command (command-list input)
  (fuzzy-match input command-list))

(define-command execute-extended-command ()
  "Execute a command by name"
  (let ((mode (mode (active-buffer *interface*)))
        (command-key-map (make-hash-table :test #'equal))
        command-list)
    (maphash (lambda (key command)
               (setf (gethash (string-downcase (princ-to-string command)) command-key-map)
                     (stringify key)))
             (keymap mode))
    (map 'list (lambda (command)
                 (push
                  (format nil "~a~a"
                          (string-downcase command)
                          (let ((key (gethash (string-downcase command) command-key-map)))
                            (if key
                                (format nil " (~a)" key)
                                "")))
                  command-list))
         (alexandria:hash-table-keys *available-commands*))
    (with-result (command (read-from-minibuffer
                           *minibuffer*
                           :input-prompt "Execute command:"
                           :completion-function (lambda (input)
                                                  (complete-command command-list input))))
      (funcall (impl (gethash
                      (first (cl-strings:split command))
                      *available-commands*))))))
