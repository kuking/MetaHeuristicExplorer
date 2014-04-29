
(defclass pane-tasks (base-pane)
  ((tasks :initarg :tasks :accessor tasks)
   (timer :initarg :timer :accessor timer)))


(defmethod initialize-timer ((p pane-tasks))
  "Initialize <p> timer."
  (setf (timer p) (mp:make-timer (lambda () (safe-refresh-tasks p))))
  (mp:schedule-timer-milliseconds (timer p) 100 400))

(defmethod initialize-interface :after ((p pane-tasks))
  (initialize-timer p))

(defmethod safe-refresh-tasks ((p pane-tasks))
  "Refresh <p> tasks in another mp:process."
  (mp:process-run-function "Refresh tasks" nil (lambda () (refresh-tasks p))))

(defmethod interface-class ((p pane-tasks))
  "Answer <p> interface class."
  'interface-pane-tasks)

(capi:define-interface interface-pane-tasks (base-interface)
  ()
  (:panes
   (tasks capi:multi-column-list-panel
          :items nil
          :selection-callback nil
          :action-callback nil
          :accessor tasks
          :header-args (list :print-function 'string-capitalize)
          :keep-selection-p t
          :pane-menu nil
          :columns '((:title "Name" :adjust :left :width (character 20)) 
                     (:title "Status" :adjust :right :visible-min-width (character 10))
                     (:title "Time" :adjust :right :visible-min-width (character 10))))
   (button-create capi:push-button :text "Create" :callback 'menu-create-task :callback-type :interface-data)
   (button-create-n capi:push-button :text "Create N" :callback 'menu-create-task-n :callback-type :interface-data)
   (button-delete-all capi:push-button :text "Delete all" :callback 'menu-delete-all-tasks :callback-type :interface-data)
   (simple-toolbar
    capi:toolbar
    :items
    (list (make-instance
           'capi:toolbar-component
           :items
           (list (make-instance 'capi:toolbar-button :image 2 :selected-image 2
                                :help-key "Create task"
                                :selection-callback 'menu-create-task
                                :callback-type :interface-data)
                 (make-instance 'capi:toolbar-button :image 1 :selected-image 1
                                :help-key "Delete all tasks"
                                :selection-callback 'menu-clean
                                :callback-type :interface-data))
           :selection nil))
    :callback-type :interface-data
    :title "Actions"
    :title-position :frame
    :default-image-set (capi:make-general-image-set :id 'global-button-icons-images :image-count 6)))
  (:layouts
   (main-layout capi:column-layout '(tasks toolbar))
   (toolbar capi:column-layout '(simple-toolbar)))
  (:default-initargs 
   :best-width 250 :best-height 150 
   :visible-min-width 100 :visible-min-height 100
   :title "Tasks"
   :destroy-callback 'destroy))


(defmethod initialize-instance :after ((i interface-pane-tasks) &key)
  (setf (capi::multi-column-list-panel-column-function (tasks i))
        (lambda (descriptor)
          (get-task-info descriptor i))))

(defun get-task-info (task pane)
  "Answer a list with <task> information."
  (list (name task) (value task)))

(defun menu-create-task (interface data)
  "Create and register a new task on <interface>."
  (declare (ignore data))
  (let* ((pane (pane interface))
         (task (make-instance 'task)))
    ;; Add task to global tasks list
    (appendf (tasks pane) (list task))
    ;; Update interface
    (capi:apply-in-pane-process
     (tasks interface) 
     #'(setf capi:collection-items) 
     (tasks pane)
     (tasks interface))
    ;; Execute task
    (execute-task task)))

(defun execute-task (task)
  "Executes a task using planifier to determine where to execute it.
   #NOTE: Execution is done into a mp:process-run-function with low priority."
  (setf (process task) 
        (mp:process-run-function
         "Process task"
         (list :priority (priority task))
         (lambda () 
           (let ((result-task))
             (appendf *tasks* (list task))
             (setf result-task (execute-task-local task)))))))

(defun execute-task-local (task)
  "Executes <task> on <planifier>.
  #NOTE: Answer <task> because in remote execution instance a copy is returned"
  (execute-search task)
  task)

(defun menu-clean (interface data)
  "Ask user for number of tasks to create and run."
  (setf *tasks* nil)
  (reset-task-environment-settings))

(defun reset-task-environment-settings ()
  (dolist (process (mp:list-all-processes))
    (if (or (equal "Process task" (mp:process-name process))
            (and (>= (length (mp:process-name process)) (length "Task dispatcher "))
                 (equal "Task dispatcher " (subseq (mp:process-name process) 0 16))))
        (mp:process-kill process))))

(defmethod refresh-tasks ((p pane-tasks))
  "Callback to refresh <p> tasks."
  (when (interface p)
    (let* ((interface (interface p))
           (tasks (tasks interface))
           (elements (tasks p)))
      (capi:execute-with-interface
       interface
       (lambda ()
         (if (equals (to-list (capi:collection-items tasks)) elements)
             (refresh-tasks-redraw tasks)
           (refresh-tasks-items elements tasks)))))))

(defun refresh-tasks-items (elements tasks)
  (let ((old-selection (capi:choice-selected-item tasks)))
    (setf (capi:collection-items tasks) elements
          (capi:choice-selected-item tasks) old-selection)))

(defun refresh-tasks-redraw (tasks)
  (capi:map-collection-items 
   tasks
   (lambda (item) (capi:redisplay-collection-item tasks item))))

(defmethod destroy ((i interface-pane-tasks))
  "Perform actions when destroying <p>."
  (destroy (pane i)))

(defmethod destroy ((p pane-tasks))
  "Perform actions when destroying <p>."
  (mp:unschedule-timer (timer p)))

