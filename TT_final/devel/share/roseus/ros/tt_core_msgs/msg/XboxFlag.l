;; Auto-generated. Do not edit!


(when (boundp 'tt_core_msgs::XboxFlag)
  (if (not (find-package "TT_CORE_MSGS"))
    (make-package "TT_CORE_MSGS"))
  (shadow 'XboxFlag (find-package "TT_CORE_MSGS")))
(unless (find-package "TT_CORE_MSGS::XBOXFLAG")
  (make-package "TT_CORE_MSGS::XBOXFLAG"))

(in-package "ROS")
;;//! \htmlinclude XboxFlag.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass tt_core_msgs::XboxFlag
  :super ros::object
  :slots (_header _flag _Float32MultiArray ))

(defmethod tt_core_msgs::XboxFlag
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:flag __flag) 0)
    ((:Float32MultiArray __Float32MultiArray) (instance std_msgs::Float32MultiArray :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _flag (round __flag))
   (setq _Float32MultiArray __Float32MultiArray)
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
  (:Float32MultiArray
   (&rest __Float32MultiArray)
   (if (keywordp (car __Float32MultiArray))
       (send* _Float32MultiArray __Float32MultiArray)
     (progn
       (if __Float32MultiArray (setq _Float32MultiArray (car __Float32MultiArray)))
       _Float32MultiArray)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _flag
    4
    ;; std_msgs/Float32MultiArray _Float32MultiArray
    (send _Float32MultiArray :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _flag
       (write-long _flag s)
     ;; std_msgs/Float32MultiArray _Float32MultiArray
       (send _Float32MultiArray :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _flag
     (setq _flag (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; std_msgs/Float32MultiArray _Float32MultiArray
     (send _Float32MultiArray :deserialize buf ptr-) (incf ptr- (send _Float32MultiArray :serialization-length))
   ;;
   self)
  )

(setf (get tt_core_msgs::XboxFlag :md5sum-) "cd510186c347247492df4880fbbb4d75")
(setf (get tt_core_msgs::XboxFlag :datatype-) "tt_core_msgs/XboxFlag")
(setf (get tt_core_msgs::XboxFlag :definition-)
      "Header header
int32 flag
std_msgs/Float32MultiArray Float32MultiArray

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
MSG: std_msgs/Float32MultiArray
# Please look at the MultiArrayLayout message definition for
# documentation on all multiarrays.

MultiArrayLayout  layout        # specification of data layout
float32[]         data          # array of data


================================================================================
MSG: std_msgs/MultiArrayLayout
# The multiarray declares a generic multi-dimensional array of a
# particular data type.  Dimensions are ordered from outer most
# to inner most.

MultiArrayDimension[] dim # Array of dimension properties
uint32 data_offset        # padding elements at front of data

# Accessors should ALWAYS be written in terms of dimension stride
# and specified outer-most dimension first.
# 
# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]
#
# A standard, 3-channel 640x480 image with interleaved color channels
# would be specified as:
#
# dim[0].label  = \"height\"
# dim[0].size   = 480
# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)
# dim[1].label  = \"width\"
# dim[1].size   = 640
# dim[1].stride = 3*640 = 1920
# dim[2].label  = \"channel\"
# dim[2].size   = 3
# dim[2].stride = 3
#
# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.

================================================================================
MSG: std_msgs/MultiArrayDimension
string label   # label of given dimension
uint32 size    # size of given dimension (in type units)
uint32 stride  # stride of given dimension
")



(provide :tt_core_msgs/XboxFlag "cd510186c347247492df4880fbbb4d75")


