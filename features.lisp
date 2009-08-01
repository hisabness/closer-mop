:allegro8.1
((:class-default-initargs)
 (:class-direct-default-initargs)
 (:compute-default-initargs) ; -> :compute-default-initargs-allegro
 (:default-superclass-for-funcallable-standard-class-is-funcallable-standard-object)
 (:defgeneric-calls-find-method-combination)
 (:defmethod-calls-make-method-lambda)
 (:dependent-protocol-for-generic-functions fixed)
 (:extensible-allocation fixed)
 (:function-invocation-calls-compute-applicable-methods)
 (:function-invocation-calls-compute-applicable-methods-using-classes)
 (:function-invocation-calls-compute-effective-method)
 (:generic-function-argument-precedence-order fixed)
 (:make-method-lambda)
 (:method-functions-take-processed-parameters)
 (:method-lambdas-are-processed)
 (:reinitialize-instance-calls-compute-discriminating-function fixed)
 (:setf-class-name-calls-reinitialize-instance)
 (:setf-generic-function-name-calls-reinitialize-instance)
 (:slot-makunbound-using-class-specialized-on-slot-definition fixed)
 (:standard-class-and-funcallable-standard-class-are-compatible)
 (:subclasses-of-built-in-class-do-not-inherit-exported-slots)
 (:subclasses-of-forward-referenced-class-do-not-inherit-exported-slots)
 (:subclasses-of-funcallable-standard-class-do-not-inherit-exported-slots)
 (:subclasses-of-method-combination-do-not-inherit-exported-slots)
 (:subclasses-of-standard-accessor-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-class-do-not-inherit-exported-slots)
 (:subclasses-of-standard-direct-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-effective-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-generic-function-do-not-inherit-exported-slots)
 (:subclasses-of-standard-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-reader-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-writer-method-do-not-inherit-exported-slots)
 (:t-is-always-a-valid-superclass))

:clisp2.48
((:accessor-method-initialized-with-function)
 (:add-method-calls-compute-discriminating-function)
 (:compute-slots-requested-slot-order-honoured)
 (:defmethod-calls-make-method-lambda)
 (:forward-referenced-class-changed-by-change-class)
 (:initialize-instance-calls-compute-discriminating-function)
 (:make-method-lambda)
 (:method-initialized-with-function)
 (:method-lambdas-are-processed)
 (:reinitialize-instance-calls-compute-discriminating-function)
 (:remove-method-calls-compute-discriminating-function)
 (:subclasses-of-method-combination-do-not-inherit-exported-slots))

:clozure-common-lisp1.3
((:compute-applicable-methods-using-classes)
 (:defmethod-calls-generic-function-method-class)
 (:defmethod-calls-make-method-lambda)
 (:discriminating-functions-can-be-closures)
 (:discriminating-functions-can-be-funcalled)
 (:function-invocation-calls-compute-applicable-methods)
 (:function-invocation-calls-compute-applicable-methods-using-classes)
 (:function-invocation-calls-compute-effective-method)
 (:make-method-lambda)
 (:method-functions-take-processed-parameters)
 (:method-lambdas-are-processed)
 (:reinitialize-lambda-list-reinitializes-argument-precedence-order)
; ---
 (:add-method-calls-compute-discriminating-function fixed)
 (:compute-slots-requested-slot-order-honoured)
 (:generic-functions-can-be-empty fixed)
 (:initialize-instance-calls-compute-discriminating-function fixed)
 (:reinitialize-instance-calls-compute-discriminating-function fixed)
 (:reinitialize-instance-calls-finalize-inheritance)
 (:remove-method-calls-compute-discriminating-function fixed)
 (:slot-definition-documentation fixed)
 (:subclasses-of-direct-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-effective-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-generic-function-do-not-inherit-exported-slots)
 (:subclasses-of-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-accessor-method-do-not-inherit-exported-slot)
 (:subclasses-of-standard-direct-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-effective-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-generic-function-do-not-inherit-exported-slots)
 (:subclasses-of-standard-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-reader-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-accessor-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-writer-method-do-not-inherit-exported-slots))

:cmu19f
((:accessor-method-initialized-with-function fixed)
 (:accessor-method-initialized-with-lambda-list fixed)
 (:accessor-method-initialized-with-slot-definition fixed)
 (:accessor-method-initialized-with-specializers fixed)
 (:anonymous-classes fixed)
 (:class-default-initargs)
 (:class-direct-default-initargs)
 (:class-initialization-calls-reader-method-class fixed)
 (:class-initialization-calls-writer-method-class fixed)
 (:discriminating-functions-can-be-closures)
 (:discriminating-functions-can-be-funcalled)
 (:documentation-passed-to-effective-slot-definition-class)
 (:effective-slot-definition-initialized-with-documentation)
 (:method-initialized-with-function)
 (:multiple-slot-options-passed-as-list-to-direct-slot-definition-class) ; fix with fix-slot-initargs
 (:reinitialize-instance-calls-compute-discriminating-function fixed)
 (:reinitialize-instance-calls-finalize-inheritance)
 (:setf-class-name-calls-reinitialize-instance)
 (:setf-generic-function-name-calls-reinitialize-instance)
 (:slot-definition-documentation fixed)
 (:standard-class-and-funcallable-standard-class-are-compatible)
 (:subclasses-of-built-in-class-do-not-inherit-exported-slots)
 (:subclasses-of-class-do-not-inherit-exported-slots)
 (:subclasses-of-direct-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-effective-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-eql-specializer-do-not-inherit-exported-slots)
 (:subclasses-of-forward-referenced-class-do-not-inherit-exported-slots)
 (:subclasses-of-funcallable-standard-class-do-not-inherit-exported-slots)
 (:subclasses-of-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-specializer-do-not-inherit-exported-slots)
 (:subclasses-of-standard-accessor-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-class-do-not-inherit-exported-slots)
 (:subclasses-of-standard-direct-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-effective-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-generic-function-do-not-inherit-exported-slots)
 (:subclasses-of-standard-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-reader-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-writer-method-do-not-inherit-exported-slots))

:ecl0.9i
((:accessor-method-initialized-with-function fixed)
 (:accessor-method-initialized-with-lambda-list fixed)
 (:accessor-method-initialized-with-slot-definition fixed)
 (:accessor-method-initialized-with-specializers fixed)
 (:accessor-method-slot-definition fixed)
 (:add-direct-method fixed)
 (:add-method-calls-add-direct-method fixed)
 (:add-method-calls-compute-discriminating-function)
 (:add-method-calls-remove-method fixed)
 (:add-method-updates-specializer-direct-generic-functions fixed)
 (:add-method-updates-specializer-direct-methods fixed)
 (:class-default-initargs)
 (:class-direct-default-initargs)
 (:class-initialization-calls-reader-method-class fixed)
 (:class-initialization-calls-writer-method-class fixed)
 (:class-reinitialization-calls-remove-direct-subclass fixed)
 (:classes-are-always-their-own-valid-superclasses)
 (:compute-applicable-methods-is-generic)
 (:compute-applicable-methods-using-classes)
 (:compute-effective-method-is-generic)
 (:default-superclass-for-funcallable-standard-class-is-funcallable-standard-object)
 (:default-reader-methods-are-standard-reader-methods fixed)
 (:default-writer-methods-are-standard-writer-methods fixed)
 (:defgeneric-calls-find-method-combination)
 (:defmethod-calls-generic-function-method-class)
 (:defmethod-calls-initialize-instance)
 (:defmethod-calls-make-method-lambda)
 (:dependent-protocol-for-classes)
 (:dependent-protocol-for-generic-functions)
 (:direct-slot-definition-initialized-with-type)
 (:discriminating-functions-can-be-closures)
 (:discriminating-functions-can-be-funcalled)
 (:eql-specializer)
 (:eql-specializer-object fixed)
 (:eql-specializers-are-objects)
 (:extract-lambda-list fixed)
 (:extract-specializer-names fixed)
 (:find-method-combination)
 (:find-method-is-generic fixed)
 (:funcallable-standard-class)
 (:funcallable-standard-object)
 (:function-invocation-calls-compute-applicable-methods)
 (:function-invocation-calls-compute-applicable-methods-using-classes)
 (:function-invocation-calls-compute-effective-method)
 (:generic-function-declarations)
 (:generic-function-method-class-is-generic)
 (:generic-function-method-combination)
 (:generic-functions-can-be-empty)
 (:initform-passed-to-direct-slot-definition-class)
 (:initform-passed-to-effective-slot-definition-class)
 (:initialize-instance-calls-compute-discriminating-function)
 (:intern-eql-specializer fixed)
 (:make-method-lambda)
 (:metaobject)
 (:method-functions-take-processed-parameters)
 (:method-initialized-with-documentation)
 (:method-initialized-with-function)
 (:method-initialized-with-lambda-list)
 (:method-initialized-with-qualifiers)
 (:method-initialized-with-specializers)
 (:method-lambdas-are-processed)
 (:multiple-slot-options-passed-as-list-to-direct-slot-definition-class)
 (:reader-method-class fixed)
 (:reinitialize-instance-calls-compute-discriminating-function)
 (:remove-direct-method fixed)
 (:remove-method-calls-compute-discriminating-function)
 (:remove-method-calls-remove-direct-method fixed)
 (:remove-method-is-generic fixed)
 (:setf-class-name-calls-reinitialize-instance)
 (:setf-generic-function-name)
 (:setf-generic-function-name-calls-reinitialize-instance)
 (:slot-definition-documentation)
 (:slot-definition-initform)
 (:slot-definition-initfunction)
 (:slot-definition-type)
 (:slot-reader-calls-slot-value-using-class fixed)
 (:slot-writer-calls-slot-value-using-class fixed)
 (:specializer)
 (:specializer-direct-generic-functions fixed)
 (:specializer-direct-methods fixed)
 (:standard-accessor-method fixed)
 (:standard-class-and-funcallable-standard-class-are-compatible)
 (:standard-reader-method fixed)
 (:standard-writer-method fixed)
 (:subclasses-of-built-in-class-do-not-inherit-exported-slots)
 (:subclasses-of-class-do-not-inherit-exported-slots)
 (:subclasses-of-direct-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-effective-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-forward-referenced-class-do-not-inherit-exported-slots)
 (:subclasses-of-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-class-do-not-inherit-exported-slots)
 (:subclasses-of-standard-direct-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-effective-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-generic-function-do-not-inherit-exported-slots)
 (:subclasses-of-standard-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-slot-definition-do-not-inherit-exported-slots)
 (:t-is-always-a-valid-superclass)
 (:type-passed-to-direct-slot-definition-class)
 (:validate-superclass)
 (:writer-method-class fixed))

:lispworks5.0-5.0.2
((:add-method-calls-compute-discriminating-function)
 (:add-method-updates-specializer-direct-generic-functions fixed)
 (:class-default-initargs)
 (:class-direct-default-initargs)
 (:compute-applicable-methods-using-classes)
 (:compute-default-initargs)
 (:defgeneric-calls-find-method-combination)
 (:eql-specializer) ; partially fixed
 (:eql-specializer-object fixed)
 (:eql-specializers-are-objects)
 (:extensible-allocation)
 (:finalize-inheritance-calls-compute-default-initargs)
 (:find-method-combination fixed) ; partially
 (:funcallable-standard-instance-access)
 (:function-invocation-calls-compute-applicable-methods)
 (:function-invocation-calls-compute-applicable-methods-using-classes)
 (:initialize-instance-calls-compute-discriminating-function)
 (:intern-eql-specializer fixed) ; partially
 (:make-method-lambda fixed) ; partially
 (:method-functions-take-processed-parameters)
 (:reinitialize-instance-calls-compute-discriminating-function)
 (:remove-method-calls-compute-discriminating-function)
 (:setf-slot-value-using-class-specialized-on-slot-definition fixed)
 (:slot-boundp-using-class-specialized-on-slot-definition fixed)
 (:slot-makunbound-using-class-specialized-on-slot-definition fixed)
 (:slot-reader-calls-slot-value-using-class fixed)
 (:slot-value-using-class-specialized-on-slot-definition fixed)
 (:slot-writer-calls-slot-value-using-class fixed)
 (:specializer)
 (:specializer-direct-generic-functions fixed)
 (:standard-class-and-funcallable-standard-class-are-compatible)
 (:standard-instance-access)
 (:subclasses-of-built-in-class-do-not-inherit-exported-slots fixed)
 (:subclasses-of-class-do-not-inherit-exported-slots fixed)
 (:subclasses-of-direct-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-effective-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-forward-referenced-class-do-not-inherit-exported-slots fixed)
 (:subclasses-of-funcallable-standard-class-do-not-inherit-exported-slots fixed)
 (:subclasses-of-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-accessor-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-class-do-not-inherit-exported-slots fixed)
 (:subclasses-of-standard-direct-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-effective-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-generic-function-do-not-inherit-exported-slots)
 (:subclasses-of-standard-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-reader-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-writer-method-do-not-inherit-exported-slots))

:lispworks5.1-5.1.2
((:add-method-calls-compute-discriminating-function)
 (:add-method-updates-specializer-direct-generic-functions fixed)
 (:class-default-initargs)
 (:class-direct-default-initargs)
 (:compute-applicable-methods-using-classes)
 (:compute-default-initargs)
 (:defgeneric-calls-find-method-combination)
 (:eql-specializer) ; partially fixed
 (:eql-specializer-object fixed)
 (:eql-specializers-are-objects)
 (:finalize-inheritance-calls-compute-default-initargs)
 (:find-method-combination fixed) ; partially
 (:funcallable-standard-instance-access)
 (:function-invocation-calls-compute-applicable-methods)
 (:function-invocation-calls-compute-applicable-methods-using-classes)
 (:initialize-instance-calls-compute-discriminating-function)
 (:intern-eql-specializer fixed) ; partially
 (:make-method-lambda fixed) ; partially
 (:method-functions-take-processed-parameters)
 (:reinitialize-instance-calls-compute-discriminating-function)
 (:remove-method-calls-compute-discriminating-function)
 (:setf-slot-value-using-class-specialized-on-slot-definition fixed)
 (:slot-boundp-using-class-specialized-on-slot-definition fixed)
 (:slot-makunbound-using-class-specialized-on-slot-definition fixed)
 (:slot-reader-calls-slot-value-using-class fixed)
 (:slot-value-using-class-specialized-on-slot-definition fixed)
 (:slot-writer-calls-slot-value-using-class fixed)
 (:specializer)
 (:specializer-direct-generic-functions fixed)
 (:standard-class-and-funcallable-standard-class-are-compatible)
 (:standard-instance-access)
 (:subclasses-of-built-in-class-do-not-inherit-exported-slots fixed)
 (:subclasses-of-class-do-not-inherit-exported-slots fixed)
 (:subclasses-of-direct-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-effective-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-forward-referenced-class-do-not-inherit-exported-slots fixed)
 (:subclasses-of-funcallable-standard-class-do-not-inherit-exported-slots fixed)
 (:subclasses-of-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-accessor-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-class-do-not-inherit-exported-slots fixed)
 (:subclasses-of-standard-direct-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-effective-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-generic-function-do-not-inherit-exported-slots)
 (:subclasses-of-standard-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-reader-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-writer-method-do-not-inherit-exported-slots))

:mcl
((:add-method-calls-compute-discriminating-function)
 (:compute-applicable-methods-using-classes)
 (:default-superclass-for-funcallable-standard-class-is-funcallable-standard-object)
 (:defmethod-calls-generic-function-method-class)
 (:defmethod-calls-make-method-lambda)
 (:discriminating-functions-can-be-closures)
 (:discriminating-functions-can-be-funcalled)
 (:funcallable-standard-object fixed)
 (:function-invocation-calls-compute-applicable-methods)
 (:function-invocation-calls-compute-applicable-methods-using-classes)
 (:function-invocation-calls-compute-effective-method)
 (:generic-function-declarations)
 (:generic-function-initialized-with-declarations)
 (:generic-functions-can-be-empty)
 (:initialize-instance-calls-compute-discriminating-function)
 (:make-method-lambda)
 (:method-functions-take-processed-parameters)
 (:method-lambdas-are-processed)
 (:reinitialize-instance-calls-compute-discriminating-function)
 (:reinitialize-lambda-list-reinitializes-argument-precedence-order)
 (:remove-method-calls-compute-discriminating-function)
 (:set-funcallable-instance-function)
 (:setf-generic-function-name)
 (:setf-generic-function-name-calls-reinitialize-instance)
 (:standard-class-and-funcallable-standard-class-are-compatible)
; ---
 (:compute-slots-requested-slot-order-honoured)
 (:direct-slot-definition fixed)
 (:direct-superclasses-by-default-empty) ; not fixed, but direct superclasses are automatically adjusted, not for funcallable-standard-class though
 (:effective-slot-definition fixed)
 (:eql-specializer fixed)
 (:extensible-allocation)
 (:multiple-slot-options-passed-as-list-to-direct-slot-definition-class) ; fix with fix-slot-initargs
 (:reinitialize-instance-calls-finalize-inheritance)
 (:setf-class-name-calls-reinitialize-instance)
 (:slot-definition fixed)
 (:standard-slot-definition fixed)
 (:subclasses-of-direct-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-effective-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-accessor-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-direct-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-effective-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-generic-function-do-not-inherit-exported-slots)
 (:subclasses-of-standard-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-reader-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-writer-method-do-not-inherit-exported-slots))

:openmcl
((:compute-applicable-methods-using-classes)
 (:default-superclass-for-funcallable-standard-class-is-funcallable-standard-object fixed)
 (:defmethod-calls-generic-function-method-class)
 (:defmethod-calls-make-method-lambda)
 (:discriminating-functions-can-be-closures)
 (:discriminating-functions-can-be-funcalled)
 (:funcallable-standard-object fixed)
 (:function-invocation-calls-compute-applicable-methods)
 (:function-invocation-calls-compute-applicable-methods-using-classes)
 (:function-invocation-calls-compute-effective-method)
 (:make-method-lambda)
 (:method-functions-take-processed-parameters)
 (:method-lambdas-are-processed)
 (:reinitialize-lambda-list-reinitializes-argument-precedence-order)
 (:remove-method-calls-compute-discriminating-function)
; ---
 (:add-method-calls-compute-discriminating-function fixed)
 (:compute-slots-requested-slot-order-honoured)
 (:eql-specializer fixed)
 (:generic-functions-can-be-empty fixed)
 (:initialize-instance-calls-compute-discriminating-function fixed)
 (:reinitialize-instance-calls-compute-discriminating-function fixed)
 (:reinitialize-instance-calls-finalize-inheritance)
 (:remove-method-calls-compute-discriminating-function fixed)
 (:slot-definition-documentation fixed)
 (:subclasses-of-direct-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-effective-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-generic-function-do-not-inherit-exported-slots)
 (:subclasses-of-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-accessor-method-do-not-inherit-exported-slot)
 (:subclasses-of-standard-direct-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-effective-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-generic-function-do-not-inherit-exported-slots)
 (:subclasses-of-standard-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-reader-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-slot-definition-do-not-inherit-exported-slots)
 (:subclasses-of-standard-accessor-method-do-not-inherit-exported-slots)
 (:subclasses-of-standard-writer-method-do-not-inherit-exported-slots))

:sbcl 1.0.29
#| all features implemented |#
