
;; #TODO: Refactor
(defparameter *search-subtasks* '(nil))
(defparameter *search-subtasks-remote* '())
(defparameter *search-tasks* '(nil))

;; Global texture manager
(defparameter *texture-manager* nil)

;; Default mp:process priority values
(defparameter *default-search-task-process-priority* -50000)
(defparameter *default-search-task-min-process-priority* -50000)
(defparameter *default-search-task-max-process-priority* 1000000)
(defparameter *default-updater-process-priority* -500000)

;; Other 
(defparameter *open-gui-on-startup* t)


(defun register-capi-button-icons ()
  (gp:register-image-translation
   'global-button-icons-images
   #.(gp:read-external-image (current-pathname "Interface\\Resources\\global-button-icons.bmp")
                             :transparent-color-index 1))
  (gp:register-image-translation
   'global-button-icons-images-24
   #.(gp:read-external-image (current-pathname "Interface\\Resources\\global-button-icons-24.bmp")
                             :transparent-color-index 1))
  (gp:register-image-translation
   'global-button-icons-images-32
   #.(gp:read-external-image (current-pathname "Interface\\Resources\\global-button-icons-32.bmp")
                             :transparent-color-index 1)))

