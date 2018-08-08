; Auto-generated. Do not edit!


(cl:in-package tt_core_msgs-srv)


;//! \htmlinclude MobileNetCrop-request.msg.html

(cl:defclass <MobileNetCrop-request> (roslisp-msg-protocol:ros-message)
  ((reqArray
    :reader reqArray
    :initarg :reqArray
    :type tt_core_msgs-msg:ROIPointArray
    :initform (cl:make-instance 'tt_core_msgs-msg:ROIPointArray)))
)

(cl:defclass MobileNetCrop-request (<MobileNetCrop-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MobileNetCrop-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MobileNetCrop-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tt_core_msgs-srv:<MobileNetCrop-request> is deprecated: use tt_core_msgs-srv:MobileNetCrop-request instead.")))

(cl:ensure-generic-function 'reqArray-val :lambda-list '(m))
(cl:defmethod reqArray-val ((m <MobileNetCrop-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tt_core_msgs-srv:reqArray-val is deprecated.  Use tt_core_msgs-srv:reqArray instead.")
  (reqArray m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MobileNetCrop-request>) ostream)
  "Serializes a message object of type '<MobileNetCrop-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'reqArray) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MobileNetCrop-request>) istream)
  "Deserializes a message object of type '<MobileNetCrop-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'reqArray) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MobileNetCrop-request>)))
  "Returns string type for a service object of type '<MobileNetCrop-request>"
  "tt_core_msgs/MobileNetCropRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MobileNetCrop-request)))
  "Returns string type for a service object of type 'MobileNetCrop-request"
  "tt_core_msgs/MobileNetCropRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MobileNetCrop-request>)))
  "Returns md5sum for a message object of type '<MobileNetCrop-request>"
  "ce138e689a8c9d31419375ee3f1679a9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MobileNetCrop-request)))
  "Returns md5sum for a message object of type 'MobileNetCrop-request"
  "ce138e689a8c9d31419375ee3f1679a9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MobileNetCrop-request>)))
  "Returns full string definition for message of type '<MobileNetCrop-request>"
  (cl:format cl:nil "tt_core_msgs/ROIPointArray reqArray~%~%================================================================================~%MSG: tt_core_msgs/ROIPointArray~%Header header~%int32[] id~%int32[] tag~%sensor_msgs/CompressedImage[] FrameArray~%geometry_msgs/Vector3[] Vector3DArray~%float32[] extra~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: sensor_msgs/CompressedImage~%# This message contains a compressed image~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of cameara~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%~%string format        # Specifies the format of the data~%                     #   Acceptable values:~%                     #     jpeg, png~%uint8[] data         # Compressed image buffer~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MobileNetCrop-request)))
  "Returns full string definition for message of type 'MobileNetCrop-request"
  (cl:format cl:nil "tt_core_msgs/ROIPointArray reqArray~%~%================================================================================~%MSG: tt_core_msgs/ROIPointArray~%Header header~%int32[] id~%int32[] tag~%sensor_msgs/CompressedImage[] FrameArray~%geometry_msgs/Vector3[] Vector3DArray~%float32[] extra~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: sensor_msgs/CompressedImage~%# This message contains a compressed image~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of cameara~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%~%string format        # Specifies the format of the data~%                     #   Acceptable values:~%                     #     jpeg, png~%uint8[] data         # Compressed image buffer~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MobileNetCrop-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'reqArray))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MobileNetCrop-request>))
  "Converts a ROS message object to a list"
  (cl:list 'MobileNetCrop-request
    (cl:cons ':reqArray (reqArray msg))
))
;//! \htmlinclude MobileNetCrop-response.msg.html

(cl:defclass <MobileNetCrop-response> (roslisp-msg-protocol:ros-message)
  ((resArray
    :reader resArray
    :initarg :resArray
    :type tt_core_msgs-msg:ROIPointArray
    :initform (cl:make-instance 'tt_core_msgs-msg:ROIPointArray)))
)

(cl:defclass MobileNetCrop-response (<MobileNetCrop-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MobileNetCrop-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MobileNetCrop-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tt_core_msgs-srv:<MobileNetCrop-response> is deprecated: use tt_core_msgs-srv:MobileNetCrop-response instead.")))

(cl:ensure-generic-function 'resArray-val :lambda-list '(m))
(cl:defmethod resArray-val ((m <MobileNetCrop-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tt_core_msgs-srv:resArray-val is deprecated.  Use tt_core_msgs-srv:resArray instead.")
  (resArray m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MobileNetCrop-response>) ostream)
  "Serializes a message object of type '<MobileNetCrop-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'resArray) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MobileNetCrop-response>) istream)
  "Deserializes a message object of type '<MobileNetCrop-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'resArray) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MobileNetCrop-response>)))
  "Returns string type for a service object of type '<MobileNetCrop-response>"
  "tt_core_msgs/MobileNetCropResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MobileNetCrop-response)))
  "Returns string type for a service object of type 'MobileNetCrop-response"
  "tt_core_msgs/MobileNetCropResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MobileNetCrop-response>)))
  "Returns md5sum for a message object of type '<MobileNetCrop-response>"
  "ce138e689a8c9d31419375ee3f1679a9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MobileNetCrop-response)))
  "Returns md5sum for a message object of type 'MobileNetCrop-response"
  "ce138e689a8c9d31419375ee3f1679a9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MobileNetCrop-response>)))
  "Returns full string definition for message of type '<MobileNetCrop-response>"
  (cl:format cl:nil "tt_core_msgs/ROIPointArray resArray~%~%~%================================================================================~%MSG: tt_core_msgs/ROIPointArray~%Header header~%int32[] id~%int32[] tag~%sensor_msgs/CompressedImage[] FrameArray~%geometry_msgs/Vector3[] Vector3DArray~%float32[] extra~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: sensor_msgs/CompressedImage~%# This message contains a compressed image~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of cameara~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%~%string format        # Specifies the format of the data~%                     #   Acceptable values:~%                     #     jpeg, png~%uint8[] data         # Compressed image buffer~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MobileNetCrop-response)))
  "Returns full string definition for message of type 'MobileNetCrop-response"
  (cl:format cl:nil "tt_core_msgs/ROIPointArray resArray~%~%~%================================================================================~%MSG: tt_core_msgs/ROIPointArray~%Header header~%int32[] id~%int32[] tag~%sensor_msgs/CompressedImage[] FrameArray~%geometry_msgs/Vector3[] Vector3DArray~%float32[] extra~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: sensor_msgs/CompressedImage~%# This message contains a compressed image~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of cameara~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%~%string format        # Specifies the format of the data~%                     #   Acceptable values:~%                     #     jpeg, png~%uint8[] data         # Compressed image buffer~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MobileNetCrop-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'resArray))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MobileNetCrop-response>))
  "Converts a ROS message object to a list"
  (cl:list 'MobileNetCrop-response
    (cl:cons ':resArray (resArray msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'MobileNetCrop)))
  'MobileNetCrop-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'MobileNetCrop)))
  'MobileNetCrop-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MobileNetCrop)))
  "Returns string type for a service object of type '<MobileNetCrop>"
  "tt_core_msgs/MobileNetCrop")