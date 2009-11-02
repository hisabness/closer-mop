(in-package :closer-mop)

;; Some internal utility functions.

#+cmu
(define-modify-macro nconcf (&rest lists) nconc)

;; Some utility functions.

(defun required-args (lambda-list &optional (collector #'identity))
  (loop for arg in lambda-list
        until (member arg lambda-list-keywords)
        collect (funcall collector arg)))

(defun ensure-finalized (class &optional (errorp t))
  (if (typep class 'class)
    (unless (class-finalized-p class)
      (finalize-inheritance class))
    (when errorp (error "~S is not a class." class)))
  class)

(defun subclassp (class superclass)
  (flet ((get-class (class) (etypecase class
                              (class class)
                              (symbol (find-class class)))))
    
      (loop with class = (get-class class)
            with superclass = (get-class superclass)
            
            for superclasses = (list class)
            then (set-difference 
                  (union (class-direct-superclasses current-class) superclasses)
                  seen)

            for current-class = (first superclasses)

            while current-class
            
            if (eq current-class superclass) return t
            else collect current-class into seen
            
            finally (return nil))))


;; In CMUCL, reader-method-class and writer-method-class are
;; not used during class initialization. The following definitions
;; correct this.

#-sbcl
(defun modify-accessors (class)
  (loop with reader-specializers = (list class)
        with writer-specializers = (list (find-class 't) class)
        for slotd in (class-direct-slots class) do
        (loop for reader in (slot-definition-readers slotd)
              for reader-function = (fdefinition reader)
              for reader-method = (find-method reader-function () reader-specializers)
              for initargs = (list :qualifiers ()
                                   :lambda-list '(object)
                                   :specializers reader-specializers
                                   :function (method-function reader-method)
                                   :slot-definition slotd)
              for method-class = (apply #'reader-method-class class slotd initargs)
              unless (eq method-class (class-of reader-method))
              do (add-method reader-function (apply #'make-instance method-class initargs)))
        (loop for writer in (slot-definition-writers slotd)
              for writer-function = (fdefinition writer)
              for writer-method = (find-method writer-function () writer-specializers)
              for initargs = (list :qualifiers ()
                                   :lambda-list '(new-value object)
                                   :specializers writer-specializers
                                   :function (method-function writer-method)
                                   :slot-definition slotd)
              for method-class = (apply #'writer-method-class class slotd initargs)
              unless (eq method-class (class-of writer-method))
              do (add-method writer-function (apply #'make-instance method-class initargs)))))

;; The following methods additionally create a gensym for the class name
;; unless a name is explicitly provided. AMOP requires classes to be
;; potentially anonymous.

#-sbcl
(cl:defmethod initialize-instance :around
  ((class standard-class) &rest initargs
   &key (name (gensym)))
  (declare (dynamic-extent initargs))
  (prog1 (apply #'call-next-method class :name name initargs)
    (modify-accessors class)))

#-sbcl
(cl:defmethod initialize-instance :around
  ((class funcallable-standard-class) &rest initargs
   &key (name (gensym)))
  (declare (dynamic-extent initargs))
  (prog1 (apply #'call-next-method class :name name initargs)
    (modify-accessors class)))

#-sbcl
(cl:defmethod reinitialize-instance :after
  ((class standard-class) &key)
  (modify-accessors class))

#-sbcl
(cl:defmethod reinitialize-instance :after
  ((class funcallable-standard-class) &key)
  (modify-accessors class))

;;; The following three methods ensure that the dependent protocol
;;; for generic function works.

;; The following method additionally ensures that
;; compute-discriminating-function is triggered.

; Note that for CMUCL, these methods violate the AMOP specification
; by specializing on the original standard-generic-function metaclass. However,
; this is necassary because in CMUCL, only one subclass of
; standard-generic-function can be created, and taking away that option from user
; code doesn't make a lot of sense in our context.

#-sbcl
(cl:defmethod reinitialize-instance :after
  ((gf standard-generic-function) &rest initargs)
  (declare (dynamic-extent initargs))
  (set-funcallable-instance-function
   gf (compute-discriminating-function gf))
  #-cmu
  (map-dependents
   gf (lambda (dep) (apply #'update-dependent gf dep initargs))))

#-(or cmu sbcl)
(cl:defmethod add-method :after
  ((gf standard-generic-function) method)
  (map-dependents
   gf (lambda (dep) (update-dependent gf dep 'add-method method))))

#-(or cmu sbcl)
(cl:defmethod remove-method :after
  ((gf standard-generic-function) method)
  (map-dependents
   gf (lambda (dep) (update-dependent gf dep 'remove-method method))))

#+sbcl
(progn
  (declaim (inline m-function))

  (defun m-function (m)
    (method-function m))

  (define-compiler-macro m-function (m)
    (handler-case (method-function m)
      (error () `(the function (method-function (the method ,m))))))
  
  (defclass standard-generic-function (cl:standard-generic-function)
    ((argument-order :accessor argument-order))
    (:metaclass funcallable-standard-class))

  (defun compute-argument-order (gf nof-required-args)
    (loop with specialized-count = (make-array nof-required-args :initial-element 0)
          
          for method in (generic-function-methods gf) do
          (loop for specializer in (method-specializers method)
                for index from 0
                unless (eq specializer (find-class 't))
                do (incf (svref specialized-count index)))
          
          finally
          
          (loop for arg in (generic-function-argument-precedence-order gf)
                for pos = (position arg (generic-function-lambda-list gf))
                when (> (svref specialized-count pos) 0)
                collect pos into argument-order
                finally (setf (argument-order gf) (coerce argument-order 'simple-vector)))))
  
  (cl:defmethod make-method-lambda ((gf standard-generic-function) (method standard-method)
                                    lambda-expression environment)
    (declare (ignore environment) (optimize (speed 3) (space 0) (compilation-speed 0)))
    (when (only-standard-methods gf)
      (return-from make-method-lambda (call-next-method)))
    (let ((args (gensym)) (next-methods (gensym))
          (more-args (gensym)) (method-function (gensym)))
      (values
       `(lambda (,args ,next-methods &rest ,more-args)
          (declare (dynamic-extent ,more-args)
                   (ignorable ,args ,next-methods ,more-args))
          (flet ((call-next-method (&rest args)
                   (declare (dynamic-extent args))
                   (if ,next-methods
                     (apply (method-function (first ,next-methods))
                            (if args args ,args) (rest ,next-methods) ,more-args)
                     (apply #'no-next-method
                            (getf ,more-args :generic-function)
                            (getf ,more-args :method)
                            (if args args ,args))))
                 (next-method-p () (not (null ,next-methods))))
            (declare (inline call-next-method next-method-p)
                     (ignorable #'call-next-method #'next-method-p))
            (flet ((,method-function ,@(rest lambda-expression)))
              (declare (inline ,method-function))
              (apply #',method-function ,args))))
       '())))

  (cl:defgeneric compute-effective-method-function (gf effective-method options)
    (:method ((gf generic-function) effective-method options)
     (declare (optimize (speed 3) (space 0) (compilation-speed 0)))
     (when options
       (cerror "Ignore these options."
               "This version of compute-effective-method-function does not support method combination options: ~S"
               options))
     (let ((all-t-specializers (required-args (generic-function-lambda-list gf)
                                              (constantly (find-class 't))))
           (args (gensym)))
       (labels ((transform-effective-method (form)
                  (if (atom form) form
                    (case (car form)
                      (call-method (transform-effective-method
                                    (let ((the-method (transform-effective-method (cadr form)))
                                          (method-var (gensym)))
                                      `(locally (declare (optimize (speed 3) (safety 0) (debug 0)))
                                         (let ((,method-var ,the-method))
                                           (declare (ignorable ,method-var))
                                           (funcall (m-function ,(if (typep the-method 'method)
                                                                   the-method method-var))
                                                    ,args
                                                    ,@(let ((subforms
                                                             (loop for subform in (the list (cddr form))
                                                                   collect `',subform)))
                                                        (if subforms subforms '(())))
                                                    :generic-function ,gf
                                                    :method ,(if (typep the-method 'method)
                                                               the-method method-var)))))))
                      (make-method (when (cddr form)
                                     (error "Incorrect make-method form: ~S." form))
                                   (multiple-value-bind
                                       (method-lambda method-options)
                                       (make-method-lambda
                                        gf (class-prototype (generic-function-method-class gf))
                                        `(lambda (&rest ,args)
                                           (declare (dynamic-extent ,args) (ignorable ,args))
                                           ,(transform-effective-method (cadr form))) nil)
                                     (apply #'make-instance
                                            (generic-function-method-class gf)
                                            :qualifiers '()
                                            :specializers all-t-specializers
                                            :lambda-list (generic-function-lambda-list gf)
                                            :function (compile nil method-lambda)
                                            method-options)))
                      (t (mapcar #'transform-effective-method (the list form)))))))
         (let ((emf-lambda `(lambda (&rest ,args)
                              (declare (dynamic-extent ,args) (ignorable ,args))
                              ,(transform-effective-method effective-method))))
           (multiple-value-bind (function warnings failure)
               (compile nil emf-lambda)
             (declare (ignore warnings))
             (assert (not failure))
             function))))))

  (defun get-emf (gf args nof-required-args)
    (declare (optimize (speed 3) (space 0) (compilation-speed 0)))
    (let ((applicable-methods (compute-applicable-methods gf (subseq args 0 nof-required-args))))
      (if applicable-methods
        (multiple-value-bind
            (effective-method options)
            (compute-effective-method
             gf (generic-function-method-combination gf)
             applicable-methods)
          (compute-effective-method-function gf effective-method options))
        (lambda (&rest args)
          (declare (dynamic-extent args))
          (apply #'no-applicable-method gf args)))))

  (defun get-emf-using-classes (gf args classes nof-required-args)
    (declare (type generic-function gf) (type list args classes)
             (optimize (speed 3) (space 0) (compilation-speed 0)))
    (multiple-value-bind
        (applicable-methods validp)
        (compute-applicable-methods-using-classes gf classes)
      (unless validp
        (setq applicable-methods
              (compute-applicable-methods gf (subseq args 0 nof-required-args))))
      (values
       (if applicable-methods
         (multiple-value-bind
             (effective-method options)
             (compute-effective-method
              gf (generic-function-method-combination gf)
              applicable-methods)
           (compute-effective-method-function gf effective-method options))
         (lambda (&rest args)
           (declare (dynamic-extent args))
           (apply #'no-applicable-method gf args)))
       validp)))

  (defvar *standard-gfs*
    (list #'compute-applicable-methods #'compute-applicable-methods-using-classes
          #'compute-effective-method #'compute-effective-method-function))

  (defun only-standard-methods (gf &rest other-gfs)
    (declare (dynamic-extent other-gfs) (optimize (speed 3) (space 0) (compilation-speed 0)))
    (loop for other-gf in (or other-gfs *standard-gfs*)
          always (loop for method in (generic-function-methods other-gf)
                       for specializer = (first (method-specializers method))
                       if (and (typep specializer 'class)
                               (subclassp specializer (find-class 'standard-generic-function))
                               (not (eq specializer (find-class 'standard-generic-function)))
                               (typep gf specializer))
                       return nil
                       else if (and (typep specializer 'eql-specializer)
                                    (eql (eql-specializer-object specializer) gf))
                       return nil
                       finally (return t))))

  (defun methods-all-the-same-specializers (gf)
    (declare (optimize (speed 3) (space 0) (compilation-speed 0)))
    (loop with template = (first (generic-function-methods gf))
          for method in (rest (generic-function-methods gf))
          always (loop for spec1 in (method-specializers template)
                       for spec2 in (method-specializers method)
                       always (etypecase spec1
                                (class (etypecase spec2
                                         (class (eq spec1 spec2))
                                         (eql-specializer nil)))
                                (eql-specializer
                                 (etypecase spec2
                                   (class nil)
                                   (eql-specializer
                                    (eql (eql-specializer-object spec1)
                                         (eql-specializer-object spec2)))))))))

  (cl:defmethod compute-discriminating-function ((gf standard-generic-function))
    (declare (optimize (speed 3) (space 0) (compilation-speed 0)))
    (let ((nof-required-args (length (required-args (generic-function-lambda-list gf))))
          discriminator)
      (compute-argument-order gf nof-required-args)
      (flet ((discriminate (emf-setter args &optional (classes (loop for arg in args
                                                                     repeat nof-required-args
                                                                     collect (class-of arg))))
               (declare (type list args classes) (type function emf-setter))
               (multiple-value-bind (emf validp) (get-emf-using-classes gf args classes nof-required-args)
                 (funcall emf-setter (if validp emf (lambda (&rest args)
                                                      (declare (dynamic-extent args))
                                                      (apply (the function (get-emf gf args nof-required-args)) args))))
                 (apply (the function emf) args))))
        (when (only-standard-methods gf #'compute-applicable-methods #'compute-applicable-methods-using-classes)
          (setq discriminator
                (if (only-standard-methods gf #'compute-effective-method #'compute-effective-method-function)
                  (call-next-method)
                  (cond ((null (generic-function-methods gf))
                         (lambda (&rest args)
                           (declare (dynamic-extent args))
                           (apply #'no-applicable-method gf args)))
                        ((methods-all-the-same-specializers gf)
                         (let ((specializers (method-specializers (first (generic-function-methods gf))))
                               (effective-method-function nil))
                           (declare (type list specializers))
                           (lambda (&rest args)
                             (declare (dynamic-extent args) (optimize (speed 3) (safety 0) (debug 0)
                                                                      (compilation-speed 0)))
                             (cond ((loop for arg in args
                                          for spec in specializers
                                          always (etypecase spec
                                                   (class (typep arg spec))
                                                   (eql-specializer (eql arg (eql-specializer-object spec)))))
                                    (if effective-method-function
                                      (apply (the function effective-method-function) args)
                                      (discriminate (lambda (emf) (setq effective-method-function emf)) args)))
                                   (t (apply #'no-applicable-method gf args))))))
                        ((= (length (argument-order gf)) 1)
                         (let ((dispatch-argument-index (svref (argument-order gf) 0))
                               (emfs (make-hash-table :test #'eq)))
                           (declare (type hash-table emfs) (type fixnum dispatch-argument-index))
                           (lambda (&rest args)
                             (declare (dynamic-extent args) (optimize (speed 3) (safety 0) (debug 0)
                                                                      (compilation-speed 0)))
                             (let* ((dispatch-class (class-of (nth dispatch-argument-index args)))
                                    (effective-method-function (gethash dispatch-class emfs)))
                               (if effective-method-function
                                 (apply (the function effective-method-function) args)
                                 (discriminate (lambda (emf) (setf (gethash dispatch-class emfs) emf)) args))))))))))
        (if discriminator discriminator
          (let ((emfs (make-hash-table :test #'equal)))
            (declare (type hash-table emfs))
            (lambda (&rest args)
              (declare (dynamic-extent args) (optimize (speed 3) (safety 0) (debug 0)
                                                       (compilation-speed 0)))
              (let* ((classes (loop for arg in args
                                    repeat nof-required-args
                                    collect (class-of arg)))
                     (effective-method-function (gethash (the list classes) emfs)))
                (if effective-method-function
                  (apply (the function effective-method-function) args)
                  (discriminate (lambda (emf) (setf (gethash (the list classes) emfs) emf)) args classes)))))))))

  (defmacro defgeneric (&whole form name (&rest args) &body options)
    (unless (every #'consp options)
      (error "Illegal generic function options in defgeneric form ~S." form))
    (let ((options-without-methods (remove :method options :key #'car :test #'eq)))
      `(progn
         (eval-when (:compile-toplevel)
           (cl:defgeneric ,name ,args ,@options-without-methods))
         (eval-when (:load-toplevel :execute)
           (cl:defgeneric ,name ,args ,@options)))))

  (defmacro defmethod (&whole form name &body body)
    (declare (ignore body))
    (let ((generic-function (when (fboundp name) (fdefinition name))))
      (unless generic-function
        (warn "No generic function ~S present when encountering macroexpansion of defmethod. Assuming it will be an instance of standard-generic-function." name))
      `(cl:defmethod ,@(cdr form)))))

#+sbcl
(defun ensure-method (gf lambda-expression 
                         &key (method-class (generic-function-method-class gf))
                         (qualifiers ())
                         (lambda-list (cadr lambda-expression))
                         (specializers (required-args lambda-list (constantly (find-class 't)))))
  (multiple-value-bind
      (method-lambda method-args)
      (make-method-lambda
       gf (class-prototype method-class)
       lambda-expression ())
    (let ((method (apply #'make-instance
                         method-class
                         :qualifiers qualifiers
                         :lambda-list lambda-list
                         :specializers specializers
                         :function (compile nil method-lambda)
                         method-args)))
      (add-method gf method)
      method)))


#-sbcl
(defun ensure-method (gf lambda-expression 
                         &key (qualifiers ())
                         (lambda-list (cadr lambda-expression))
                         (specializers (required-args lambda-list (constantly 't))))
  (funcall (compile nil `(lambda ()
                           (defmethod ,(generic-function-name gf) ,@qualifiers
                             ,(loop for specializer in specializers
                                    for (arg . rest) on lambda-list
                                    collect `(,arg ,specializer) into args
                                    finally (return (nconc args rest)))
                             ,@(cddr lambda-expression))))))

;; The following ensures that effective slot definitions have a documentation in CMUCL.

#+cmu
(defmethod compute-effective-slot-definition :around
  ((class standard-class) name direct-slot-definitions)
  (let ((effective-slot (call-next-method)))
    (loop for direct-slot in direct-slot-definitions
          for documentation = (documentation direct-slot 't)
          when documentation do
          (setf (documentation effective-slot 't) documentation)
          (loop-finish))
    effective-slot))

;; The following can be used in direct-slot-definition-class to get the correct initargs
;; for a slot. Use it like this:
;;
;; (defmethod direct-slot-definition-class
;;            ((class my-standard-class) &rest initargs)
;;   (declare (dynamic-extent initargs))
;;   (destructuring-bind
;;       (&key key-of-interest &allow-other-keys)
;;       (fix-slot-initargs initargs)
;;     ...))

(defvar *standard-slot-keys*
  '(:name :documentation
    :initargs :initform :initfunction
    :readers :writers))

(defun fix-slot-initargs (initargs)
  #+sbcl initargs
  #+cmu (let* ((counts (loop with counts
                             for (key nil) on initargs by #'cddr
                             do (incf (getf counts key 0))
                             finally (return counts)))
               (keys-to-fix (loop for (key value) on counts by #'cddr
                                  if (> value 1) collect key)))
          (if keys-to-fix
            (let ((multiple-standard-keys
                   (intersection keys-to-fix *standard-slot-keys*)))
              (if multiple-standard-keys
                (error "Too many occurences of ~S in slot initargs ~S."
                       multiple-standard-keys initargs)
                (loop with fixed-keys
                      for (key value) on initargs by #'cddr
                      if (member key keys-to-fix)
                      do (nconcf (getf fixed-keys key) (list value))
                      else nconc (list key value) into fixed-initargs
                      finally (return (nconc fixed-initargs fixed-keys)))))
            initargs)))

;; In CMUCL, TYPEP and SUBTYPEP don't work as expected
;; in conjunction with class metaobjects.

#-sbcl
(progn
  (defgeneric typep (object type)
    (:method (object type)
     (cl:typep object type))
    (:method (object (type class))
     (cl:typep object (class-name type))))

  (defgeneric subtypep (type1 type2)
    (:method (type1 type2)
     (cl:subtypep type1 type2))
    (:method ((type1 class) type2)
     (cl:subtypep (class-name type1) type2))
    (:method (type1 (type2 class))
     (cl:subtypep type1 (class-name type2)))
    (:method ((type1 class) (type2 class))
     (cl:subtypep (class-name type1)
                  (class-name type2)))))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (pushnew :closer-mop *features*))
