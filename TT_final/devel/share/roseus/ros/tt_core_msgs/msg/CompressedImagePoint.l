;; Auto-generated. Do not edit!


(when (boundp 'tt_core_msgs::CompressedImagePoint)
  (if (not (find-package "TT_CORE_MSGS"))
    (make-package "TT_CORE_MSGS"))
  (shadow 'CompressedImagePoint (find-package "TT_CORE_MSGS")))
(unless (find-package "TT_CORE_MSGS::COMPRESSEDIMAGEPOINT")
  (make-package "TT_CORE_MSGS::COMPRESSEDIMAGEPOINT"))

(in-package "ROS")
;;//! \htmlinclude CompressedImagePoint.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass tt_core_msgs::CompressedImagePoint
  :super ros::object
  :slots (_header _id _frame _Vector3DArray ))

(defmethod tt_core_msgs::CompressedImagePoint
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:id __id) (make-array 0 :initial-element 0 :element-type :integer))
    ((:frame __frame) (instance sensor_msgs::CompressedImage :init))
    ((:Vector3DArray __Vector3DArray) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Vector3 :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _id __id)
   (setq _frame __frame)
   (setq _Vector3DArray __Vector3DArray)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:frame
   (&rest __frame)
   (if (keywordp (car __frame))
       (send* _frame __frame)
     (progn
       (if __frame (setq _frame (car __frame)))
       _frame)))
  (:Vector3DArray
   (&rest __Vector3DArray)
   (if (keywordp (car __Vector3DArray))
       (send* _Vector3DArray __Vector3DArray)
     (progn
       (if __Vector3DArray (setq _Vector3DArray (car __Vector3DArray)))
       _Vector3DArray)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32[] _id
    (* 4    (length _id)) 4
    ;; sensor_msgs/CompressedImage _frame
    (send _frame :serialization-length)
    ;; geometry_msgs/Vector3[] _Vector3DArray
    (apply #'+ (send-all _Vector3DArray :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32[] _id
     (write-long (length _id) s)
     (dotimes (i (length _id))
       (write-long (elt _id i) s)
       )
     ;; sensor_msgs/CompressedImage _frame
       (send _frame :serialize s)
     ;; geometry_msgs/Vector3[] _Vector3DArray
     (write-long (length _Vector3DArray) s)
     (dolist (elem _Vector3DArray)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32[] _id
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _id (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _id i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; sensor_msgs/CompressedImage _frame
     (send _frame :deserialize buf ptr-) (incf ptr- (send _frame :serialization-length))
   ;; geometry_msgs/Vector3[] _Vector3DArray
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _Vector3DArray (let (r) (dotimes (i n) (push (instance geometry_msgs::Vector3 :init) r)) r))
     (dolist (elem- _Vector3DArray)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get tt_core_msgs::CompressedImagePoint :md5sum-) "10d5623748ffddbe91d26ab58ea788f1")
(setf (get tt_core_msgs::CompressedImagePoint :datatype-) "tt_core_msgs/CompressedImagePoint")
(setf (get tt_core_msgs::CompressedImagePoint :definition-)
      "Header header
int32[] id
sensor_msgs/CompressedImage frame
geometry_msgs/Vector3[] Vector3DArray

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
# 0: no frame
# 1: global frame
string frame_id

================================================================================
MSG: sensor_msgs/CompressedImage
# This message contains a compressed image

Header header        # Header timestamp should be acquisition time of image
                     # Header frame_id should be optical frame of camera
                     # origin of frame should be optical center of cameara
                     # +x should point to the right in the image
                     # +y should point down in the image
                     # +z should point into to plane of the image

string format        # Specifies the format of the data
                     #   Acceptable values:
                     #     jpeg, png
uint8[] data         # Compressed image buffer

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
")



(provide :tt_core_msgs/CompressedImagePoint "10d5623748ffddbe91d26ab58ea788f1")


