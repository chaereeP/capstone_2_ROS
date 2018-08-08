// Auto-generated. Do not edit!

// (in-package tt_core_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ROIPointArray = require('../msg/ROIPointArray.js');

//-----------------------------------------------------------


//-----------------------------------------------------------

class MobileNetCropRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.reqArray = null;
    }
    else {
      if (initObj.hasOwnProperty('reqArray')) {
        this.reqArray = initObj.reqArray
      }
      else {
        this.reqArray = new ROIPointArray();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MobileNetCropRequest
    // Serialize message field [reqArray]
    bufferOffset = ROIPointArray.serialize(obj.reqArray, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MobileNetCropRequest
    let len;
    let data = new MobileNetCropRequest(null);
    // Deserialize message field [reqArray]
    data.reqArray = ROIPointArray.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += ROIPointArray.getMessageSize(object.reqArray);
    return length;
  }

  static datatype() {
    // Returns string type for a service object
    return 'tt_core_msgs/MobileNetCropRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7811b1e6cacefd422cfb0c1497a07655';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    tt_core_msgs/ROIPointArray reqArray
    
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
    float64 z
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MobileNetCropRequest(null);
    if (msg.reqArray !== undefined) {
      resolved.reqArray = ROIPointArray.Resolve(msg.reqArray)
    }
    else {
      resolved.reqArray = new ROIPointArray()
    }

    return resolved;
    }
};

class MobileNetCropResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.resArray = null;
    }
    else {
      if (initObj.hasOwnProperty('resArray')) {
        this.resArray = initObj.resArray
      }
      else {
        this.resArray = new ROIPointArray();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MobileNetCropResponse
    // Serialize message field [resArray]
    bufferOffset = ROIPointArray.serialize(obj.resArray, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MobileNetCropResponse
    let len;
    let data = new MobileNetCropResponse(null);
    // Deserialize message field [resArray]
    data.resArray = ROIPointArray.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += ROIPointArray.getMessageSize(object.resArray);
    return length;
  }

  static datatype() {
    // Returns string type for a service object
    return 'tt_core_msgs/MobileNetCropResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6f77acffcd254437b0746fa3647a8257';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    float64 z
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MobileNetCropResponse(null);
    if (msg.resArray !== undefined) {
      resolved.resArray = ROIPointArray.Resolve(msg.resArray)
    }
    else {
      resolved.resArray = new ROIPointArray()
    }

    return resolved;
    }
};

module.exports = {
  Request: MobileNetCropRequest,
  Response: MobileNetCropResponse,
  md5sum() { return 'ce138e689a8c9d31419375ee3f1679a9'; },
  datatype() { return 'tt_core_msgs/MobileNetCrop'; }
};
