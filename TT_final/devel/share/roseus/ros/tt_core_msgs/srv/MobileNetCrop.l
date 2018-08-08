;; Auto-generated. Do not edit!


(when (boundp 'tt_core_msgs::MobileNetCrop)
  (if (not (find-package "TT_CORE_MSGS"))
    (make-package "TT_CORE_MSGS"))
  (shadow 'MobileNetCrop (find-package "TT_CORE_MSGS")))
(unless (find-package "TT_CORE_MSGS::MOBILENETCROP")
  (make-package "TT_CORE_MSGS::MOBILENETCROP"))
(unless (find-package "TT_CORE_MSGS::MOBILENETCROPREQUEST")
  (make-package "TT_CORE_MSGS::MOBILENETCROPREQUEST"))
(unless (find-package "TT_CORE_MSGS::MOBILENETCROPRESPONSE")
  (make-package "TT_CORE_MSGS::MOBILENETCROPRESPONSE"))

(in-package "ROS")





(defclass tt_core_msgs::MobileNetCropRequest
  :super ros::object
  :slots (_reqArray ))

(defmethod tt_core_msgs::MobileNetCropRequest
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

(defclass tt_core_msgs::MobileNetCropResponse
  :super ros::object
  :slots (_resArray ))

(defmethod tt_core_msgs::MobileNetCropResponse
  (:init
   (&key
    ((:resArray __resArray) (instance tt_core_msgs::ROIPointArray :init))
    )
   (send-super :init)
   (setq _resArray __resArray)
   self)
  (:resArray
   (&rest __resArray)
   (if (keywordp (car __resArray))
       (send* _resArray __resArray)
     (progn
       (if __resArray (setq _resArray (car __resArray)))
       _resArray)))
  (:serialization-length
   ()
   (+
    ;; tt_core_msgs/ROIPointArray _resArray
    (send _resArray :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; tt_core_msgs/ROIPointArray _resArray
       (send _resArray :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; tt_core_msgs/ROIPointArray _resArray
     (send _resArray :deserialize buf ptr-) (incf ptr- (send _resArray :serialization-length))
   ;;
   self)
  )

(defclass tt_core_msgs::MobileNetCrop
  :super ros::object
  :slots ())

(setf (get tt_core_msgs::MobileNetCrop :md5sum-) "ce138e689a8c9d31419375ee3f1679a9")
(setf (get tt_core_msgs::MobileNetCrop :datatype-) "tt_core_msgs/MobileNetCrop")
(setf (get tt_core_msgs::MobileNetCrop :request) tt_core_msgs::MobileNetCropRequest)
(setf (get tt_core_msgs::MobileNetCrop :response) tt_core_msgs::MobileNetCropResponse)

(defmethod tt_core_msgs::MobileNetCropRequest
  (:response () (instance tt_core_msgs::MobileNetCropResponse :init)))

(setf (get tt_core_msgs::MobileNetCropRequest :md5sum-) "ce138e689a8c9d31419375ee3f1679a9")
(setf (get tt_core_msgs::MobileNetCropRequest :datatype-) "tt_core_msgs/MobileNetCropRequest")
(setf (get tt_core_msgs::MobileNetCropRequest :definition-)
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
tt_core_msgs/ROIPointArray resArray


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
")

(setf (get tt_core_msgs::MobileNetCropResponse :md5sum-) "ce138e689a8c9d31419375ee3f1679a9")
(setf (get tt_core_msgs::MobileNetCropResponse :datatype-) "tt_core_msgs/MobileNetCropResponse")
(setf (get tt_core_msgs::MobileNetCropResponse :definition-)
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
tt_core_msgs/ROIPointArray resArray


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
")



(provide :tt_core_msgs/MobileNetCrop "ce138e689a8c9d31419375ee3f1679a9")


