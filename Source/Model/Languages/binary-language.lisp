
(defclass binary-language (language)
  ((bits :initarg :bits :accessor bits)))


(defmethod initialize-properties :after ((o binary-language))
  "Initialize <o> properties."
  (add-properties-from-values
   o
   (:name 'bits :label "Bits" :accessor-type 'accessor-accessor-type :default-value 32 :data-type 'integer 
    :editor 'integer-editor)))