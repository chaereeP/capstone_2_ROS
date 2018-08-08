; Auto-generated. Do not edit!


(cl:in-package tt_core_msgs-srv)


;//! \htmlinclude CameraCrop-request.msg.html

(cl:defclass <CameraCrop-request> (roslisp-msg-protocol:ros-message)
  ((reqArray
    :reader reqArray
    :initarg :reqArray
    :type tt_core_msgs-msg:Vector3DArray
    :initform (cl:make-instance 'tt_core_msgs-msg:Vector3DArray)))
)

(cl:defclass CameraCrop-request (<CameraCrop-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CameraCrop-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CameraCrop-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tt_core_msgs-srv:<CameraCrop-request> is deprecated: use tt_core_msgs-srv:CameraCrop-request instead.")))

(cl:ensure-generic-function 'reqArray-val :lambda-list '(m))
(cl:defmethod reqArray-val ((m <CameraCrop-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tt_core_msgs-srv:reqArray-val is deprecated.  Use tt_core_msgs-srv:reqArray instead.")
  (reqArray m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CameraCrop-request>) ostream)
  "Serializes a message object of type '<CameraCrop-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'reqArray) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CameraCrop-request>) istream)
  "Deserializes a message object of type '<CameraCrop-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'reqArray) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CameraCrop-request>)))
  "Returns string type for a service object of type '<CameraCrop-request>"
  "tt_core_msgs/CameraCropRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CameraCrop-request)))
  "Returns string type for a service object of type 'CameraCrop-request"
  "tt_core_msgs/CameraCropRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CameraCrop-request>)))
  "Returns md5sum for a message object of type '<CameraCrop-request>"
  "c59f6f4ab593dbb46a0ee41e6151c029")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CameraCrop-request)))
  "Returns md5sum for a message object of type 'CameraCrop-request"
  "c59f6f4ab593dbb46a0ee41e6151c029")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CameraCrop-request>)))
  "Returns full string definition for message of type '<CameraCrop-request>"
  (cl:format cl:nil "tt_core_msgs/Vector3DArray reqArray~%~%================================================================================~%MSG: tt_core_msgs/Vector3DArray~%Header header~%int32[] id~%geometry_msgs/Vector3[] Vector3DArray~%float32[] extra~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CameraCrop-request)))
  "Returns full string definition for message of type 'CameraCrop-request"
  (cl:format cl:nil "tt_core_msgs/Vector3DArray reqArray~%~%================================================================================~%MSG: tt_core_msgs/Vector3DArray~%Header header~%int32[] id~%geometry_msgs/Vector3[] Vector3DArray~%float32[] extra~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CameraCrop-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'reqArray))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CameraCrop-request>))
  "Converts a ROS message object to a list"
  (cl:list 'CameraCrop-request
    (cl:cons ':reqArray (reqArray msg))
))
;//! \htmlinclude CameraCrop-response.msg.html

(cl:defclass <CameraCrop-response> (roslisp-msg-protocol:ros-message)
  ((resArray
    :reader resArray
    :initarg :resArray
    :type tt_core_msgs-msg:ROIPointArray
    :initform (cl:make-instance 'tt_core_msgs-msg:ROIPointArray)))
)

(cl:defclass CameraCrop-response (<CameraCrop-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CameraCrop-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CameraCrop-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tt_core_msgs-srv:<CameraCrop-response> is deprecated: use tt_core_msgs-srv:CameraCrop-response instead.")))

(cl:ensure-generic-function 'resArray-val :lambda-list '(m))
(cl:defmethod resArray-val ((m <CameraCrop-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tt_core_msgs-srv:resArray-val is deprecated.  Use tt_core_msgs-srv:resArray instead.")
  (resArray m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CameraCrop-response>) ostream)
  "Serializes a message object of type '<CameraCrop-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'resArray) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CameraCrop-response>) istream)
  "Deserializes a message object of type '<CameraCrop-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'resArray) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CameraCrop-response>)))
  "Returns string type for a service object of type '<CameraCrop-response>"
  "tt_core_msgs/CameraCropResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CameraCrop-response)))
  "Returns string type for a service object of type 'CameraCrop-response"
  "tt_core_msgs/CameraCropResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CameraCrop-response>)))
  "Returns md5sum for a message object of type '<CameraCrop-response>"
  "c59f6f4ab593dbb46a0ee41e6151c029")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CameraCrop-response)))
  "Returns md5sum for a message object of type 'CameraCrop-response"
  "c59f6f4ab593dbb46a0ee41e6151c029")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CameraCrop-response>)))
  "Returns full string definition for message of type '<CameraCrop-response>"
  (cl:format cl:nil "tt_core_msgs/ROIPointArray resArray~%~%~%================================================================================~%MSG: tt_core_msgs/ROIPointArray~%Header header~%int32[] id~%int32[] tag~%sensor_msgs/CompressedImage[] FrameArray~%geometry_msgs/Vector3[] Vector3DArray~%float32[] extra~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: sensor_msgs/CompressedImage~%# This message contains a compressed image~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of cameara~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%~%string format        # Specifies the format of the data~%                     #   Acceptable values:~%                     #     jpeg, png~%uint8[] data         # Compressed image buffer~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CameraCrop-response)))
  "Returns full string definition for message of type 'CameraCrop-response"
  (cl:format cl:nil "tt_core_msgs/ROIPointArray resArray~%~%~%================================================================================~%MSG: tt_core_msgs/ROIPointArray~%Header header~%int32[] id~%int32[] tag~%sensor_msgs/CompressedImage[] FrameArray~%geometry_msgs/Vector3[] Vector3DArray~%float32[] extra~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: sensor_msgs/CompressedImage~%# This message contains a compressed image~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of cameara~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%~%string format        # Specifies the format of the data~%                     #   Acceptable values:~%                     #     jpeg, png~%uint8[] data         # Compressed image buffer~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CameraCrop-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'resArray))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CameraCrop-response>))
  "Converts a ROS message object to a list"
  (cl:list 'CameraCrop-response
    (cl:cons ':resArray (resArray msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'CameraCrop)))
  'CameraCrop-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'CameraCrop)))
  'CameraCrop-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CameraCrop)))
  "Returns string type for a service object of type '<CameraCrop>"
  "tt_core_msgs/CameraCrop")