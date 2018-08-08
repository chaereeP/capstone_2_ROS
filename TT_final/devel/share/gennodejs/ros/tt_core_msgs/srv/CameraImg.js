// Auto-generated. Do not edit!

// (in-package tt_core_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

let sensor_msgs = _finder('sensor_msgs');

//-----------------------------------------------------------

class CameraImgRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.req = null;
    }
    else {
      if (initObj.hasOwnProperty('req')) {
        this.req = initObj.req
      }
      else {
        this.req = new std_msgs.msg.Int32();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CameraImgRequest
    // Serialize message field [req]
    bufferOffset = std_msgs.msg.Int32.serialize(obj.req, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CameraImgRequest
    let len;
    let data = new CameraImgRequest(null);
    // Deserialize message field [req]
    data.req = std_msgs.msg.Int32.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'tt_core_msgs/CameraImgRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0f4c76065f5fb3257b999a50997b4d91';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    std_msgs/Int32 req
    
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
    const resolved = new CameraImgRequest(null);
    if (msg.req !== undefined) {
      resolved.req = std_msgs.msg.Int32.Resolve(msg.req)
    }
    else {
      resolved.req = new std_msgs.msg.Int32()
    }

    return resolved;
    }
};

class CameraImgResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.frame = null;
    }
    else {
      if (initObj.hasOwnProperty('frame')) {
        this.frame = initObj.frame
      }
      else {
        this.frame = new sensor_msgs.msg.CompressedImage();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CameraImgResponse
    // Serialize message field [frame]
    bufferOffset = sensor_msgs.msg.CompressedImage.serialize(obj.frame, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CameraImgResponse
    let len;
    let data = new CameraImgResponse(null);
    // Deserialize message field [frame]
    data.frame = sensor_msgs.msg.CompressedImage.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += sensor_msgs.msg.CompressedImage.getMessageSize(object.frame);
    return length;
  }

  static datatype() {
    // Returns string type for a service object
    return 'tt_core_msgs/CameraImgResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e9ab25632719e5fdab0537e1e069672c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new CameraImgResponse(null);
    if (msg.frame !== undefined) {
      resolved.frame = sensor_msgs.msg.CompressedImage.Resolve(msg.frame)
    }
    else {
      resolved.frame = new sensor_msgs.msg.CompressedImage()
    }

    return resolved;
    }
};

module.exports = {
  Request: CameraImgRequest,
  Response: CameraImgResponse,
  md5sum() { return '76e4e49f9c27975a034223a4d54fcbe4'; },
  datatype() { return 'tt_core_msgs/CameraImg'; }
};
