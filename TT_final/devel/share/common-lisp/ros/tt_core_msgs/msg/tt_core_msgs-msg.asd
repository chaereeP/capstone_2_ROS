
(cl:in-package :asdf)

(defsystem "tt_core_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :sensor_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "CompressedImagePoint" :depends-on ("_package_CompressedImagePoint"))
    (:file "_package_CompressedImagePoint" :depends-on ("_package"))
    (:file "ImagePoint" :depends-on ("_package_ImagePoint"))
    (:file "_package_ImagePoint" :depends-on ("_package"))
    (:file "MapFlag" :depends-on ("_package_MapFlag"))
    (:file "_package_MapFlag" :depends-on ("_package"))
    (:file "ROIPointArray" :depends-on ("_package_ROIPointArray"))
    (:file "_package_ROIPointArray" :depends-on ("_package"))
    (:file "Vector3DArray" :depends-on ("_package_Vector3DArray"))
    (:file "_package_Vector3DArray" :depends-on ("_package"))
    (:file "XboxFlag" :depends-on ("_package_XboxFlag"))
    (:file "_package_XboxFlag" :depends-on ("_package"))
  ))