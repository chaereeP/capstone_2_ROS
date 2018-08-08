
(cl:in-package :asdf)

(defsystem "tt_core_msgs-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :sensor_msgs-msg
               :std_msgs-msg
               :tt_core_msgs-msg
)
  :components ((:file "_package")
    (:file "CameraCrop" :depends-on ("_package_CameraCrop"))
    (:file "_package_CameraCrop" :depends-on ("_package"))
    (:file "CameraImg" :depends-on ("_package_CameraImg"))
    (:file "_package_CameraImg" :depends-on ("_package"))
    (:file "MapGenPoint" :depends-on ("_package_MapGenPoint"))
    (:file "_package_MapGenPoint" :depends-on ("_package"))
    (:file "MobileNetCrop" :depends-on ("_package_MobileNetCrop"))
    (:file "_package_MobileNetCrop" :depends-on ("_package"))
  ))