
(defun query-running-image-port ()
  "Determines and answer the port number for the running image.
   Starts scanning for por 20000 to next 10 ports."
  (dotimes (i 10)
    (let ((candidate-port (+ 20000 i)))
      (with-open-stream       
          (stream (comm:open-tcp-stream "127.0.0.1" candidate-port))
        (if (null stream)
            (return-from query-running-image-port candidate-port)
          (progn 
            (format stream (make-tcp-message-string 'message-port-ping nil))
            (force-output stream))))))
  (error "No port to start TCP server."))

(defun initialize-distributed-environment ()
  (let ((administrator (system-get 'main-connection-administrator)))
    ;; Add and set up the running image connection descriptor
    (system-add (make-instance 'connection-descriptor 
                               :port (query-running-image-port)
                               :name 'running-image-descriptor
                               :descriptor-machine-instance (machine-instance)
                               :is-remote nil
                               :state 'CONNECTED))
    ;; Add and create the distributed-environment instance to the system
    (system-add (make-instance 'distributed-environment 
                               :name 'local-distributed-environment))
    ;; Initialize main connection administrator
    (initialize-environment administrator)
    ;; Start local TCP server
    (startup-image-tcp-server (system-get 'main-connection-administrator))
    ;; Add global task assignment strategies
    (system-add
     (make-instance 'running-image-planifier 
                    :name 'global-running-image-planifier 
                    :connection-administrator administrator)
     (make-instance 'local-planifier 
                    :name 'global-local-planifier
                    :connection-administrator administrator)
     (make-instance 'remote-planifier 
                    :name 'global-remote-planifier
                    :connection-administrator administrator)
     (make-instance 'equitative-planifier
                    :name 'global-equitative-planifier
                    :connection-administrator administrator)
     (make-instance 'balanced-planifier
                    :name 'global-balanced-planifier
                    :connection-administrator administrator))
    ;; Extra initialization of task assignment strategies
    (initialize-equitative-planifier)
    (initialize-balanced-planifier)))

(defun system-global-task-planifiers ()
  (list (system-get 'global-running-image-planifier)
        (system-get 'global-local-planifier)
        (system-get 'global-remote-planifier)
        (system-get 'global-equitative-planifier)
        (system-get 'global-balanced-planifier)))

(defun initialize-equitative-planifier ()
  nil)

(defun initialize-balanced-planifier ()
  nil)
