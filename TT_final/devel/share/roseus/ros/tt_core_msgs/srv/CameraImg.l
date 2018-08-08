;; Auto-generated. Do not edit!


(when (boundp 'tt_core_msgs::CameraImg)
  (if (not (find-package "TT_CORE_MSGS"))
    (make-package "TT_CORE_MSGS"))
  (shadow 'CameraImg (find-package "TT_CORE_MSGS")))
(unless (find-package "TT_CORE_MSGS::CAMERAIMG")
  (make-package "TT_CORE_MSGS::CAMERAIMG"))
(unless (find-package "TT_CORE_MSGS::CAMERAIMGREQUEST")
  (make-package "TT_CORE_MSGS::CAMERAIMGREQUEST"))
(unless (find-package "TT_CORE_MSGS::CAMERAIMGRESPONSE")
  (make-package "TT_CORE_MSGS::CAMERAIMGRESPONSE"))

(in-package "ROS")

(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))


(defclass tt_core_msgs::CameraImgRequest
  :super ros::object
  :slots (_req ))

(defmethod tt_core_msgs::CameraImgRequest
  (:init
   (&key
    ((:req __req) (instance std_msgs::Int32 :init))
    )
   (send-super :init)
   (setq _req __req)
   self)
  (:req
   (&rest __req)
   (if (keywordp (car __req))
       (send* _req __req)
     (progn
       (if __req (setq _req (car __req)))
       _req)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Int32 _req
    (send _req :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Int32 _req
       (send _req :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Int32 _req
     (send _req :deserialize buf ptr-) (incf ptr- (send _req :serialization-length))
   ;;
   self)
  )

(defclass tt_core_msgs::CameraImgResponse
  :super ros::object
  :slots (_frame ))

(defmethod tt_core_msgs::CameraImgResponse
  (:init
   (&key
    ((:frame __frame) (instance sensor_msgs::CompressedImage :init))
    )
   (send-super :init)
   (setq _frame __frame)
   self)
  (:frame
   (&rest __frame)
   (if (keywordp (car __frame))
       (send* _frame __frame)
     (progn
       (if __frame (setq _frame (car __frame)))
       _frame)))
  (:serialization-length
   ()
   (+
    ;; sensor_msgs/CompressedImage _frame
    (send _frame :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; sensor_msgs/CompressedImage _frame
       (send _frame :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; sensor_msgs/CompressedImage _frame
     (send _frame :deserialize buf ptr-) (incf ptr- (send _frame :serialization-length))
   ;;
   self)
  )

(defclass tt_core_msgs::CameraImg
  :super ros::object
  :slots ())

(setf (get tt_core_msgs::CameraImg :md5sum-) "76e4e49f9c27975a034223a4d54fcbe4")
(setf (get tt_core_msgs::CameraImg :datatype-) "tt_core_msgs/CameraImg")
(setf (get tt_core_msgs::CameraImg :request) tt_core_msgs::CameraImgRequest)
(setf (get tt_core_msgs::CameraImg :response) tt_core_msgs::CameraImgResponse)

(defmethod tt_core_msgs::CameraImgRequest
  (:response () (instance tt_core_msgs::CameraImgResponse :init)))

(setf (get tt_core_msgs::CameraImgRequest :md5sum-) "76e4e49f9c27975a034223a4d54fcbe4")
(setf (get tt_core_msgs::CameraImgRequest :datatype-) "tt_core_msgs/CameraImgRequest")
(setf (get tt_core_msgs::CameraImgRequest :definition-)
      "std_msgs/Int32 req

================================================================================
MSG: std_msgs/Int32
---
sensor_msgs/CompressedImage frame


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
")

(setf (get tt_core_msgs::CameraImgResponse :md5sum-) "76e4e49f9c27975a034223a4d54fcbe4")
(setf (get tt_core_msgs::CameraImgResponse :datatype-) "tt_core_msgs/CameraImgResponse")
(setf (get tt_core_msgs::CameraImgResponse :definition-)
      "std_msgs/Int32 req

================================================================================
MSG: std_msgs/Int32
---
sensor_msgs/CompressedImage frame


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
")



(provide :tt_core_msgs/CameraImg "76e4e49f9c27975a034223a4d54fcbe4")


