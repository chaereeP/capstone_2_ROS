;; Auto-generated. Do not edit!


(when (boundp 'tt_core_msgs::MapFlag)
  (if (not (find-package "TT_CORE_MSGS"))
    (make-package "TT_CORE_MSGS"))
  (shadow 'MapFlag (find-package "TT_CORE_MSGS")))
(unless (find-package "TT_CORE_MSGS::MAPFLAG")
  (make-package "TT_CORE_MSGS::MAPFLAG"))

(in-package "ROS")
;;//! \htmlinclude MapFlag.msg.html
(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass tt_core_msgs::MapFlag
  :super ros::object
  :slots (_header _flag _track_state _frame ))

(defmethod tt_core_msgs::MapFlag
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:flag __flag) 0)
    ((:track_state __track_state) 0)
    ((:frame __frame) (instance sensor_msgs::Image :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _flag (round __flag))
   (setq _track_state (round __track_state))
   (setq _frame __frame)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:flag
   (&optional __flag)
   (if __flag (setq _flag __flag)) _flag)
  (:track_state
   (&optional __track_state)
   (if __track_state (setq _track_state __track_state)) _track_state)
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
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _flag
    4
    ;; int32 _track_state
    4
    ;; sensor_msgs/Image _frame
    (send _frame :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _flag
       (write-long _flag s)
     ;; int32 _track_state
       (write-long _track_state s)
     ;; sensor_msgs/Image _frame
       (send _frame :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _flag
     (setq _flag (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _track_state
     (setq _track_state (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; sensor_msgs/Image _frame
     (send _frame :deserialize buf ptr-) (incf ptr- (send _frame :serialization-length))
   ;;
   self)
  )

(setf (get tt_core_msgs::MapFlag :md5sum-) "ba6bf033f4a4f9846496e69db130ddf3")
(setf (get tt_core_msgs::MapFlag :datatype-) "tt_core_msgs/MapFlag")
(setf (get tt_core_msgs::MapFlag :definition-)
      "Header header
int32 flag
int32 track_state
sensor_msgs/Image frame

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
MSG: sensor_msgs/Image
# This message contains an uncompressed image
# (0, 0) is at top-left corner of image
#

Header header        # Header timestamp should be acquisition time of image
                     # Header frame_id should be optical frame of camera
                     # origin of frame should be optical center of cameara
                     # +x should point to the right in the image
                     # +y should point down in the image
                     # +z should point into to plane of the image
                     # If the frame_id here and the frame_id of the CameraInfo
                     # message associated with the image conflict
                     # the behavior is undefined

uint32 height         # image height, that is, number of rows
uint32 width          # image width, that is, number of columns

# The legal values for encoding are in file src/image_encodings.cpp
# If you want to standardize a new string format, join
# ros-users@lists.sourceforge.net and send an email proposing a new encoding.

string encoding       # Encoding of pixels -- channel meaning, ordering, size
                      # taken from the list of strings in include/sensor_msgs/image_encodings.h

uint8 is_bigendian    # is this data bigendian?
uint32 step           # Full row length in bytes
uint8[] data          # actual matrix data, size is (step * rows)

")



(provide :tt_core_msgs/MapFlag "ba6bf033f4a4f9846496e69db130ddf3")


