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

let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class MapGenPointRequest {
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
    // Serializes a message object of type MapGenPointRequest
    // Serialize message field [reqArray]
    bufferOffset = ROIPointArray.serialize(obj.reqArray, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MapGenPointRequest
    let len;
    let data = new MapGenPointRequest(null);
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
    return 'tt_core_msgs/MapGenPointRequest';
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
    const resolved = new MapGenPointRequest(null);
    if (msg.reqArray !== undefined) {
      resolved.reqArray = ROIPointArray.Resolve(msg.reqArray)
    }
    else {
      resolved.reqArray = new ROIPointArray()
    }

    return resolved;
    }
};

class MapGenPointResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.res = null;
    }
    else {
      if (initObj.hasOwnProperty('res')) {
        this.res = initObj.res
      }
      else {
        this.res = new std_msgs.msg.Int32();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MapGenPointResponse
    // Serialize message field [res]
    bufferOffset = std_msgs.msg.Int32.serialize(obj.res, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MapGenPointResponse
    let len;
    let data = new MapGenPointResponse(null);
    // Deserialize message field [res]
    data.res = std_msgs.msg.Int32.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'tt_core_msgs/MapGenPointResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3b5a227652033bbb93d9f7ec8eba5bce';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    std_msgs/Int32 res
    
    
    ================================================================================
    MSG: std_msgs/Int32
    int32 data
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MapGenPointResponse(null);
    if (msg.res !== undefined) {
      resolved.res = std_msgs.msg.Int32.Resolve(msg.res)
    }
    else {
      resolved.res = new std_msgs.msg.Int32()
    }

    return resolved;
    }
};

module.exports = {
  Request: MapGenPointRequest,
  Response: MapGenPointResponse,
  md5sum() { return '77e9b44efbf859a31c896f22a0604ab1'; },
  datatype() { return 'tt_core_msgs/MapGenPoint'; }
};
