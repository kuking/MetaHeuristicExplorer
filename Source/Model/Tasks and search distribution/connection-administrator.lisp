(defparameter *default-configuration-path-possible-remote-hosts* nil)


(defclass connection-administrator (object-with-properties)
  ((name :initarg :name :accessor name)
   (local-connections :initarg :local-connections :accessor local-connections)
   (remote-connections :initarg :remote-connections :accessor remote-connections)
   (statistics :initarg :statistics :accessor statistics)
   (status-timer :accessor status-timer)
   (server :accessor server)))


(defmethod initialize-properties :after ((a connection-administrator))
  "Initializes <a> properties."
  (add-properties-from-values
   a
   (:name 'name :label "Name" :accessor-type 'accessor-accessor-type
    :data-type 'symbol :default-value nil :editor 'symbol-editor)
   (:name 'local-connections :label "Local connections" :accessor-type 'accessor-accessor-type
    :data-type 'list :default-value nil :editor 'list-editor)
   (:name 'remote-connections :label "Remote connections" :accessor-type 'accessor-accessor-type
    :data-type 'list :default-value nil :editor 'list-editor)
   (:name 'statistics :label "Statistics" :accessor-type 'accessor-accessor-type 
    :data-type 'object :editor 'button-editor :default-value nil)))

(defmethod connections ((a connection-administrator))
  "Answer all the connections of <a>."
  (append (local-connections a) (remote-connections a)))

(defmethod initialize-environment ((a connection-administrator))
  "Initializes the connection of the environment for <a>."
  (refresh-local-connections a)
  (restore-default-remote-connections a))

(defmethod active-connections ((a connection-administrator))
  "Answer a list with the active connections of <a>."
  (select 
   (connections a)
   (lambda (object) (equal (state object) 'connected))))

(defmethod local-active-connections ((a connection-administrator))
  "Answer a list with the active connections of <a>."
  (select 
   (active-connections a)
   (lambda (object) (not (is-remote object)))))

(defmethod remote-active-connections ((a connection-administrator))
  "Answer a list with the active connections of <a>."
  (select 
   (active-connections a)
   (lambda (object) (is-remote object))))

(defmethod check-connections-state ((a connection-administrator))
  "Updates connection state for each connection of <a>."
  (refresh-local-connections a)
  (dolist (i (connections a))
    (check-state i)))

(defmethod startup-image-tcp-server ((a connection-administrator))
  "Start up running image tcp server owned by <a>."
  (setf (server a) (comm:start-up-server :function (lambda (handle) (atender-mensaje handle a))
                                         :service (port (system-get 'running-image-descriptor)))))

(defun atender-mensaje (handle administrator)
  "Creates a new process to handle <handle> socket by <administrator>. "
  (let ((stream (make-instance 'comm:socket-stream :socket handle :direction :io :element-type 'base-char)))
    (mp:process-run-function (format nil "Task dispatcher ~D" handle)
                             '()
                             'message-dispatch-function
                             stream
                             administrator)))

(defun message-dispatch-function (stream administrator)
  "Executes actions for message on <stream> with <administrator>."
  (let* ((message-text (read-line stream nil nil))
         (message (eval (read-from-string message-text))))
    (dispatch-message administrator message stream)))

(defmethod descriptor-with ((a connection-administrator) ip-address port)
  "Answer the connection-descriptor of <a> with <ip-address> and <port>."
  (make-instance 'connection-descriptor :ip-address ip-address :port port))

(defmethod refresh-local-connections ((a connection-administrator))
  (setf (local-connections a) (possible-local-hosts a)))

(defmethod possible-local-hosts ((a connection-administrator))
  "Answer the possible local hosts looking for connections from port 20000 to 20010."
  (let* ((candidate-ports)
         (running-image-descriptor (system-get 'running-image-descriptor))
         (local-server-port (port running-image-descriptor)))
    (dotimes (i 10)
      (let ((candidate-port (+ 20000 i)))
        (if (not (= candidate-port local-server-port))
            (with-open-stream       
                (stream (comm:open-tcp-stream "127.0.0.1" candidate-port))
              (if stream
                  (progn
                    (appendf candidate-ports 
                             (list (make-instance 'connection-descriptor
                                                  :ip-address "localhost"
                                                  :port candidate-port
                                                  :state 'connected
                                                  :descriptor-machine-instance (machine-instance)
                                                  :is-remote nil)))
                    (format stream (make-tcp-message-string 'message-port-ping nil))
                    (force-output stream)))))))
    (append candidate-ports (list running-image-descriptor))))

(defmethod restore-default-remote-connections ((a connection-administrator))
  "Restore the remote connection list of <a> to the default."
  (if (probe-file *default-configuration-path-possible-remote-hosts*)
      (setf (remote-connections a)
            (eval (read-from-string 
                   (car (load-from-file *default-configuration-path-possible-remote-hosts*)))))))

(defmethod save-default-remote-connections ((a connection-administrator))
  "Saves the remote connections list of <a> as the default."
  (if (probe-file *default-configuration-path-possible-remote-hosts*)
      (delete-file *default-configuration-path-possible-remote-hosts*))
  (let ((hosts-list (mapcar (lambda (object) (copy object)) (remote-connections a))))
    (dolist (i hosts-list)
      (setf (state i) nil))
    (save-source-description hosts-list *default-configuration-path-possible-remote-hosts*)))

(defmethod connection-named ((a connection-administrator) name)
  "Answer the connection of <a> named <name>."
  (find (lambda (object) (equal (name object) name)) 
        (connections a)))

(defmethod add-connection ((a connection-administrator) (c connection-descriptor))
  "Adds and connects a c host to a."
  (if (is-remote c)
      (appendf (remote-connections a) (list c))
    (error "Can't add a local connection manually.")))

(defmethod has-connection-with ((a connection-administrator) ip-address port)
  "Answer whether <a> has registered a connection to <address>, <port>."
  (find-if 
   (lambda (object) 
     (and (ip-address-equal ip-address (ip-address object))
          (= port (port object))))
   (connections a)))

(defun ip-address-equal (a b)
  (let ((na a)
        (nb b))
    (if (stringp na) (setf na (ip-from-dns a)))
    (if (stringp nb) (setf nb (ip-from-dns b)))
    (if (and na nb)
        (= na nb)
      nil)))

(defmethod delete-connection ((a connection-administrator) (c connection-descriptor))
  "Removes the connection identified by connection-descriptor."
  (setf (remote-connections a) (remove c (remote-connections a))
        (local-connections a) (remove c (local-connections a))))

(defmethod disconnect-all ((a connection-administrator))
  (dolist (connection (connections a))
    (if (not (equal (system-get 'running-image-descriptor) connection))
        (setf (state connection) nil))))

(defmethod dispatch-message ((a connection-administrator) message stream)
  (dispatch-message-name (name message) message a stream))
