;; Auto-generated. Do not edit!


(when (boundp 'tt_core_msgs::MapGenPoint)
  (if (not (find-package "TT_CORE_MSGS"))
    (make-package "TT_CORE_MSGS"))
  (shadow 'MapGenPoint (find-package "TT_CORE_MSGS")))
(unless (find-package "TT_CORE_MSGS::MAPGENPOINT")
  (make-package "TT_CORE_MSGS::MAPGENPOINT"))
(unless (find-package "TT_CORE_MSGS::MAPGENPOINTREQUEST")
  (make-package "TT_CORE_MSGS::MAPGENPOINTREQUEST"))
(unless (find-package "TT_CORE_MSGS::MAPGENPOINTRESPONSE")
  (make-package "TT_CORE_MSGS::MAPGENPOINTRESPONSE"))

(in-package "ROS")



(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass tt_core_msgs::MapGenPointRequest
  :super ros::object
  :slots (_reqArray ))

(defmethod tt_core_msgs::MapGenPointRequest
  (:init
   (&key
    ((:reqArray __reqArray) (instance tt_core_msgs::ROIPointArray :init))
    )
   (send-super :init)
   (setq _reqArray __reqArray)
   self)
  (:reqArray
   (&rest __reqArray)
   (if (keywordp (car __reqArray))
       (send* _reqArray __reqArray)
     (progn
       (if __reqArray (setq _reqArray (car __reqArray)))
       _reqArray)))
  (:serialization-length
   ()
   (+
    ;; tt_core_msgs/ROIPointArray _reqArray
    (send _reqArray :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; tt_core_msgs/ROIPointArray _reqArray
       (send _reqArray :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; tt_core_msgs/ROIPointArray _reqArray
     (send _reqArray :deserialize buf ptr-) (incf ptr- (send _reqArray :serialization-length))
   ;;
   self)
  )

(defclass tt_core_msgs::MapGenPointResponse
  :super ros::object
  :slots (_res ))

(defmethod tt_core_msgs::MapGenPointResponse
  (:init
   (&key
    ((:res __res) (instance std_msgs::Int32 :init))
    )
   (send-super :init)
   (setq _res __res)
   self)
  (:res
   (&rest __res)
   (if (keywordp (car __res))
       (send* _res __res)
     (progn
       (if __res (setq _res (car __res)))
       _res)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Int32 _res
    (send _res :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Int32 _res
       (send _res :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Int32 _res
     (send _res :deserialize buf ptr-) (incf ptr- (send _res :serialization-length))
   ;;
   self)
  )

(defclass tt_core_msgs::MapGenPoint
  :super ros::object
  :slots ())

(setf (get tt_core_msgs::MapGenPoint :md5sum-) "77e9b44efbf859a31c896f22a0604ab1")
(setf (get tt_core_msgs::MapGenPoint :datatype-) "tt_core_msgs/MapGenPoint")
(setf (get tt_core_msgs::MapGenPoint :request) tt_core_msgs::MapGenPointRequest)
(setf (get tt_core_msgs::MapGenPoint :response) tt_core_msgs::MapGenPointResponse)

(defmethod tt_core_msgs::MapGenPointRequest
  (:response () (instance tt_core_msgs::MapGenPointResponse :init)))

(setf (get tt_core_msgs::MapGenPointRequest :md5sum-) "77e9b44efbf859a31c896f22a0604ab1")
(setf (get tt_core_msgs::MapGenPointRequest :datatype-) "tt_core_msgs/MapGenPointRequest")
(setf (get tt_core_msgs::MapGenPointRequest :definition-)
      "tt_core_msgs/ROIPointArray reqArray

================================================================================
MSG: tt_core_msgs/ROIPointArray
Header header
int32[] id
int32[] tag
sensor_msgs/CompressedImage[] FrameArray
geometry_msgs/Vector3[] Vector3DArray
float32[] extra

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
---
std_msgs/Int32 res


================================================================================
MSG: std_msgs/Int32
")

(setf (get tt_core_msgs::MapGenPointResponse :md5sum-) "77e9b44efbf859a31c896f22a0604ab1")
(setf (get tt_core_msgs::MapGenPointResponse :datatype-) "tt_core_msgs/MapGenPointResponse")
(setf (get tt_core_msgs::MapGenPointResponse :definition-)
      "tt_core_msgs/ROIPointArray reqArray

================================================================================
MSG: tt_core_msgs/ROIPointArray
Header header
int32[] id
int32[] tag
sensor_msgs/CompressedImage[] FrameArray
geometry_msgs/Vector3[] Vector3DArray
float32[] extra

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
---
std_msgs/Int32 res


================================================================================
MSG: std_msgs/Int32
")



(provide :tt_core_msgs/MapGenPoint "77e9b44efbf859a31c896f22a0604ab1")


