; Auto-generated. Do not edit!


(cl:in-package tt_core_msgs-srv)


;//! \htmlinclude CameraImg-request.msg.html

(cl:defclass <CameraImg-request> (roslisp-msg-protocol:ros-message)
  ((req
    :reader req
    :initarg :req
    :type std_msgs-msg:Int32
    :initform (cl:make-instance 'std_msgs-msg:Int32)))
)

(cl:defclass CameraImg-request (<CameraImg-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CameraImg-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CameraImg-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tt_core_msgs-srv:<CameraImg-request> is deprecated: use tt_core_msgs-srv:CameraImg-request instead.")))

(cl:ensure-generic-function 'req-val :lambda-list '(m))
(cl:defmethod req-val ((m <CameraImg-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tt_core_msgs-srv:req-val is deprecated.  Use tt_core_msgs-srv:req instead.")
  (req m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CameraImg-request>) ostream)
  "Serializes a message object of type '<CameraImg-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'req) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CameraImg-request>) istream)
  "Deserializes a message object of type '<CameraImg-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'req) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CameraImg-request>)))
  "Returns string type for a service object of type '<CameraImg-request>"
  "tt_core_msgs/CameraImgRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CameraImg-request)))
  "Returns string type for a service object of type 'CameraImg-request"
  "tt_core_msgs/CameraImgRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CameraImg-request>)))
  "Returns md5sum for a message object of type '<CameraImg-request>"
  "76e4e49f9c27975a034223a4d54fcbe4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CameraImg-request)))
  "Returns md5sum for a message object of type 'CameraImg-request"
  "76e4e49f9c27975a034223a4d54fcbe4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CameraImg-request>)))
  "Returns full string definition for message of type '<CameraImg-request>"
  (cl:format cl:nil "std_msgs/Int32 req~%~%================================================================================~%MSG: std_msgs/Int32~%int32 data~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CameraImg-request)))
  "Returns full string definition for message of type 'CameraImg-request"
  (cl:format cl:nil "std_msgs/Int32 req~%~%================================================================================~%MSG: std_msgs/Int32~%int32 data~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CameraImg-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'req))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CameraImg-request>))
  "Converts a ROS message object to a list"
  (cl:list 'CameraImg-request
    (cl:cons ':req (req msg))
))
;//! \htmlinclude CameraImg-response.msg.html

(cl:defclass <CameraImg-response> (roslisp-msg-protocol:ros-message)
  ((frame
    :reader frame
    :initarg :frame
    :type sensor_msgs-msg:CompressedImage
    :initform (cl:make-instance 'sensor_msgs-msg:CompressedImage)))
)

(cl:defclass CameraImg-response (<CameraImg-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CameraImg-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CameraImg-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tt_core_msgs-srv:<CameraImg-response> is deprecated: use tt_core_msgs-srv:CameraImg-response instead.")))

(cl:ensure-generic-function 'frame-val :lambda-list '(m))
(cl:defmethod frame-val ((m <CameraImg-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tt_core_msgs-srv:frame-val is deprecated.  Use tt_core_msgs-srv:frame instead.")
  (frame m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CameraImg-response>) ostream)
  "Serializes a message object of type '<CameraImg-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'frame) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CameraImg-response>) istream)
  "Deserializes a message object of type '<CameraImg-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'frame) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CameraImg-response>)))
  "Returns string type for a service object of type '<CameraImg-response>"
  "tt_core_msgs/CameraImgResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CameraImg-response)))
  "Returns string type for a service object of type 'CameraImg-response"
  "tt_core_msgs/CameraImgResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CameraImg-response>)))
  "Returns md5sum for a message object of type '<CameraImg-response>"
  "76e4e49f9c27975a034223a4d54fcbe4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CameraImg-response)))
  "Returns md5sum for a message object of type 'CameraImg-response"
  "76e4e49f9c27975a034223a4d54fcbe4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CameraImg-response>)))
  "Returns full string definition for message of type '<CameraImg-response>"
  (cl:format cl:nil "sensor_msgs/CompressedImage frame~%~%~%================================================================================~%MSG: sensor_msgs/CompressedImage~%# This message contains a compressed image~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of cameara~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%~%string format        # Specifies the format of the data~%                     #   Acceptable values:~%                     #     jpeg, png~%uint8[] data         # Compressed image buffer~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CameraImg-response)))
  "Returns full string definition for message of type 'CameraImg-response"
  (cl:format cl:nil "sensor_msgs/CompressedImage frame~%~%~%================================================================================~%MSG: sensor_msgs/CompressedImage~%# This message contains a compressed image~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of cameara~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%~%string format        # Specifies the format of the data~%                     #   Acceptable values:~%                     #     jpeg, png~%uint8[] data         # Compressed image buffer~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CameraImg-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'frame))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CameraImg-response>))
  "Converts a ROS message object to a list"
  (cl:list 'CameraImg-response
    (cl:cons ':frame (frame msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'CameraImg)))
  'CameraImg-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'CameraImg)))
  'CameraImg-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CameraImg)))
  "Returns string type for a service object of type '<CameraImg>"
  "tt_core_msgs/CameraImg")