;; Auto-generated. Do not edit!


(when (boundp 'tt_core_msgs::ROIPointArray)
  (if (not (find-package "TT_CORE_MSGS"))
    (make-package "TT_CORE_MSGS"))
  (shadow 'ROIPointArray (find-package "TT_CORE_MSGS")))
(unless (find-package "TT_CORE_MSGS::ROIPOINTARRAY")
  (make-package "TT_CORE_MSGS::ROIPOINTARRAY"))

(in-package "ROS")
;;//! \htmlinclude ROIPointArray.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass tt_core_msgs::ROIPointArray
  :super ros::object
  :slots (_header _id _tag _FrameArray _Vector3DArray _extra ))

(defmethod tt_core_msgs::ROIPointArray
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:id __id) (make-array 0 :initial-element 0 :element-type :integer))
    ((:tag __tag) (make-array 0 :initial-element 0 :element-type :integer))
    ((:FrameArray __FrameArray) (let (r) (dotimes (i 0) (push (instance sensor_msgs::CompressedImage :init) r)) r))
    ((:Vector3DArray __Vector3DArray) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Vector3 :init) r)) r))
    ((:extra __extra) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _id __id)
   (setq _tag __tag)
   (setq _FrameArray __FrameArray)
   (setq _Vector3DArray __Vector3DArray)
   (setq _extra __extra)
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
  (:tag
   (&optional __tag)
   (if __tag (setq _tag __tag)) _tag)
  (:FrameArray
   (&rest __FrameArray)
   (if (keywordp (car __FrameArray))
       (send* _FrameArray __FrameArray)
     (progn
       (if __FrameArray (setq _FrameArray (car __FrameArray)))
       _FrameArray)))
  (:Vector3DArray
   (&rest __Vector3DArray)
   (if (keywordp (car __Vector3DArray))
       (send* _Vector3DArray __Vector3DArray)
     (progn
       (if __Vector3DArray (setq _Vector3DArray (car __Vector3DArray)))
       _Vector3DArray)))
  (:extra
   (&optional __extra)
   (if __extra (setq _extra __extra)) _extra)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32[] _id
    (* 4    (length _id)) 4
    ;; int32[] _tag
    (* 4    (length _tag)) 4
    ;; sensor_msgs/CompressedImage[] _FrameArray
    (apply #'+ (send-all _FrameArray :serialization-length)) 4
    ;; geometry_msgs/Vector3[] _Vector3DArray
    (apply #'+ (send-all _Vector3DArray :serialization-length)) 4
    ;; float32[] _extra
    (* 4    (length _extra)) 4
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
     ;; int32[] _tag
     (write-long (length _tag) s)
     (dotimes (i (length _tag))
       (write-long (elt _tag i) s)
       )
     ;; sensor_msgs/CompressedImage[] _FrameArray
     (write-long (length _FrameArray) s)
     (dolist (elem _FrameArray)
       (send elem :serialize s)
       )
     ;; geometry_msgs/Vector3[] _Vector3DArray
     (write-long (length _Vector3DArray) s)
     (dolist (elem _Vector3DArray)
       (send elem :serialize s)
       )
     ;; float32[] _extra
     (write-long (length _extra) s)
     (dotimes (i (length _extra))
       (sys::poke (elt _extra i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
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
   ;; int32[] _tag
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _tag (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _tag i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; sensor_msgs/CompressedImage[] _FrameArray
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _FrameArray (let (r) (dotimes (i n) (push (instance sensor_msgs::CompressedImage :init) r)) r))
     (dolist (elem- _FrameArray)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; geometry_msgs/Vector3[] _Vector3DArray
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _Vector3DArray (let (r) (dotimes (i n) (push (instance geometry_msgs::Vector3 :init) r)) r))
     (dolist (elem- _Vector3DArray)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; float32[] _extra
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _extra (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _extra i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get tt_core_msgs::ROIPointArray :md5sum-) "6a90b51aaad299305e57af7d9a114865")
(setf (get tt_core_msgs::ROIPointArray :datatype-) "tt_core_msgs/ROIPointArray")
(setf (get tt_core_msgs::ROIPointArray :definition-)
      "Header header
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
float64 z
")



(provide :tt_core_msgs/ROIPointArray "6a90b51aaad299305e57af7d9a114865")


