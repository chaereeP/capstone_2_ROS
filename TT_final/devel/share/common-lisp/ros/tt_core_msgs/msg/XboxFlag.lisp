; Auto-generated. Do not edit!


(cl:in-package tt_core_msgs-msg)


;//! \htmlinclude XboxFlag.msg.html

(cl:defclass <XboxFlag> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (flag
    :reader flag
    :initarg :flag
    :type cl:integer
    :initform 0)
   (Float32MultiArray
    :reader Float32MultiArray
    :initarg :Float32MultiArray
    :type std_msgs-msg:Float32MultiArray
    :initform (cl:make-instance 'std_msgs-msg:Float32MultiArray)))
)

(cl:defclass XboxFlag (<XboxFlag>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <XboxFlag>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'XboxFlag)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tt_core_msgs-msg:<XboxFlag> is deprecated: use tt_core_msgs-msg:XboxFlag instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <XboxFlag>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tt_core_msgs-msg:header-val is deprecated.  Use tt_core_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'flag-val :lambda-list '(m))
(cl:defmethod flag-val ((m <XboxFlag>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tt_core_msgs-msg:flag-val is deprecated.  Use tt_core_msgs-msg:flag instead.")
  (flag m))

(cl:ensure-generic-function 'Float32MultiArray-val :lambda-list '(m))
(cl:defmethod Float32MultiArray-val ((m <XboxFlag>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tt_core_msgs-msg:Float32MultiArray-val is deprecated.  Use tt_core_msgs-msg:Float32MultiArray instead.")
  (Float32MultiArray m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <XboxFlag>) ostream)
  "Serializes a message object of type '<XboxFlag>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'flag)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'Float32MultiArray) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <XboxFlag>) istream)
  "Deserializes a message object of type '<XboxFlag>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'flag) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'Float32MultiArray) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<XboxFlag>)))
  "Returns string type for a message object of type '<XboxFlag>"
  "tt_core_msgs/XboxFlag")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'XboxFlag)))
  "Returns string type for a message object of type 'XboxFlag"
  "tt_core_msgs/XboxFlag")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<XboxFlag>)))
  "Returns md5sum for a message object of type '<XboxFlag>"
  "cd510186c347247492df4880fbbb4d75")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'XboxFlag)))
  "Returns md5sum for a message object of type 'XboxFlag"
  "cd510186c347247492df4880fbbb4d75")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<XboxFlag>)))
  "Returns full string definition for message of type '<XboxFlag>"
  (cl:format cl:nil "Header header~%int32 flag~%std_msgs/Float32MultiArray Float32MultiArray~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: std_msgs/Float32MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%float32[]         data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding elements at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'XboxFlag)))
  "Returns full string definition for message of type 'XboxFlag"
  (cl:format cl:nil "Header header~%int32 flag~%std_msgs/Float32MultiArray Float32MultiArray~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: std_msgs/Float32MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%float32[]         data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding elements at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <XboxFlag>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'Float32MultiArray))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <XboxFlag>))
  "Converts a ROS message object to a list"
  (cl:list 'XboxFlag
    (cl:cons ':header (header msg))
    (cl:cons ':flag (flag msg))
    (cl:cons ':Float32MultiArray (Float32MultiArray msg))
))
