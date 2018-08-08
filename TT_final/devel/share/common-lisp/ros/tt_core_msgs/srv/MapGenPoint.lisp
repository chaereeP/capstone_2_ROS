; Auto-generated. Do not edit!


(cl:in-package tt_core_msgs-srv)


;//! \htmlinclude MapGenPoint-request.msg.html

(cl:defclass <MapGenPoint-request> (roslisp-msg-protocol:ros-message)
  ((reqArray
    :reader reqArray
    :initarg :reqArray
    :type tt_core_msgs-msg:ROIPointArray
    :initform (cl:make-instance 'tt_core_msgs-msg:ROIPointArray)))
)

(cl:defclass MapGenPoint-request (<MapGenPoint-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MapGenPoint-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MapGenPoint-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tt_core_msgs-srv:<MapGenPoint-request> is deprecated: use tt_core_msgs-srv:MapGenPoint-request instead.")))

(cl:ensure-generic-function 'reqArray-val :lambda-list '(m))
(cl:defmethod reqArray-val ((m <MapGenPoint-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tt_core_msgs-srv:reqArray-val is deprecated.  Use tt_core_msgs-srv:reqArray instead.")
  (reqArray m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MapGenPoint-request>) ostream)
  "Serializes a message object of type '<MapGenPoint-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'reqArray) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MapGenPoint-request>) istream)
  "Deserializes a message object of type '<MapGenPoint-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'reqArray) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MapGenPoint-request>)))
  "Returns string type for a service object of type '<MapGenPoint-request>"
  "tt_core_msgs/MapGenPointRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MapGenPoint-request)))
  "Returns string type for a service object of type 'MapGenPoint-request"
  "tt_core_msgs/MapGenPointRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MapGenPoint-request>)))
  "Returns md5sum for a message object of type '<MapGenPoint-request>"
  "77e9b44efbf859a31c896f22a0604ab1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MapGenPoint-request)))
  "Returns md5sum for a message object of type 'MapGenPoint-request"
  "77e9b44efbf859a31c896f22a0604ab1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MapGenPoint-request>)))
  "Returns full string definition for message of type '<MapGenPoint-request>"
  (cl:format cl:nil "tt_core_msgs/ROIPointArray reqArray~%~%================================================================================~%MSG: tt_core_msgs/ROIPointArray~%Header header~%int32[] id~%int32[] tag~%sensor_msgs/CompressedImage[] FrameArray~%geometry_msgs/Vector3[] Vector3DArray~%float32[] extra~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: sensor_msgs/CompressedImage~%# This message contains a compressed image~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of cameara~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%~%string format        # Specifies the format of the data~%                     #   Acceptable values:~%                     #     jpeg, png~%uint8[] data         # Compressed image buffer~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MapGenPoint-request)))
  "Returns full string definition for message of type 'MapGenPoint-request"
  (cl:format cl:nil "tt_core_msgs/ROIPointArray reqArray~%~%================================================================================~%MSG: tt_core_msgs/ROIPointArray~%Header header~%int32[] id~%int32[] tag~%sensor_msgs/CompressedImage[] FrameArray~%geometry_msgs/Vector3[] Vector3DArray~%float32[] extra~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: sensor_msgs/CompressedImage~%# This message contains a compressed image~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of cameara~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%~%string format        # Specifies the format of the data~%                     #   Acceptable values:~%                     #     jpeg, png~%uint8[] data         # Compressed image buffer~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MapGenPoint-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'reqArray))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MapGenPoint-request>))
  "Converts a ROS message object to a list"
  (cl:list 'MapGenPoint-request
    (cl:cons ':reqArray (reqArray msg))
))
;//! \htmlinclude MapGenPoint-response.msg.html

(cl:defclass <MapGenPoint-response> (roslisp-msg-protocol:ros-message)
  ((res
    :reader res
    :initarg :res
    :type std_msgs-msg:Int32
    :initform (cl:make-instance 'std_msgs-msg:Int32)))
)

(cl:defclass MapGenPoint-response (<MapGenPoint-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MapGenPoint-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MapGenPoint-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tt_core_msgs-srv:<MapGenPoint-response> is deprecated: use tt_core_msgs-srv:MapGenPoint-response instead.")))

(cl:ensure-generic-function 'res-val :lambda-list '(m))
(cl:defmethod res-val ((m <MapGenPoint-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tt_core_msgs-srv:res-val is deprecated.  Use tt_core_msgs-srv:res instead.")
  (res m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MapGenPoint-response>) ostream)
  "Serializes a message object of type '<MapGenPoint-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'res) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MapGenPoint-response>) istream)
  "Deserializes a message object of type '<MapGenPoint-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'res) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MapGenPoint-response>)))
  "Returns string type for a service object of type '<MapGenPoint-response>"
  "tt_core_msgs/MapGenPointResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MapGenPoint-response)))
  "Returns string type for a service object of type 'MapGenPoint-response"
  "tt_core_msgs/MapGenPointResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MapGenPoint-response>)))
  "Returns md5sum for a message object of type '<MapGenPoint-response>"
  "77e9b44efbf859a31c896f22a0604ab1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MapGenPoint-response)))
  "Returns md5sum for a message object of type 'MapGenPoint-response"
  "77e9b44efbf859a31c896f22a0604ab1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MapGenPoint-response>)))
  "Returns full string definition for message of type '<MapGenPoint-response>"
  (cl:format cl:nil "std_msgs/Int32 res~%~%~%================================================================================~%MSG: std_msgs/Int32~%int32 data~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MapGenPoint-response)))
  "Returns full string definition for message of type 'MapGenPoint-response"
  (cl:format cl:nil "std_msgs/Int32 res~%~%~%================================================================================~%MSG: std_msgs/Int32~%int32 data~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MapGenPoint-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'res))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MapGenPoint-response>))
  "Converts a ROS message object to a list"
  (cl:list 'MapGenPoint-response
    (cl:cons ':res (res msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'MapGenPoint)))
  'MapGenPoint-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'MapGenPoint)))
  'MapGenPoint-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MapGenPoint)))
  "Returns string type for a service object of type '<MapGenPoint>"
  "tt_core_msgs/MapGenPoint")