(in-package :cl-user)

(defpackage :next-hooks
  (:use :common-lisp)
  (:export
   #:*hook*
   #:add-hook
   #:remove-hook
   #:run-hooks
   #:run-hook
   #:run-hook-with-args-until-failure
   #:run-hook-with-args-until-success
   ;; #:make-handler ; Leave unexported to incite using typed handlers.
   #:default-combine-hook
   #:combine-hook-until-failure
   #:combine-hook-until-success
   #:combine-composed-hook
   #:find-handler
   #:disable-hook
   #:enable-hook
   #:define-hook
   #:find-hook
   #:define-hook-type
   ;; Handler class:
   #:handler
   #:name
   #:description
   #:handler-type
   #:place
   #:value
   ;; Hook class:
   #:hook
   #:handlers
   #:disabled-handlers
   #:combination
   ;; Pre-generated types:
   #:make-handler-void
   #:handler-void
   #:hook-void
   #:make-hook-void
   #:make-handler-string->string
   #:handler-string->string
   #:hook-string->string
   #:make-hook-string->string
   #:make-handler-number->number
   #:handler-number->number
   #:hook-number->number
   #:make-hook-number->number
   #:make-handler-any
   #:handler-any
   #:hook-any
   #:make-hook-any))
