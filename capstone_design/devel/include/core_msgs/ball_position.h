// Generated by gencpp from file core_msgs/ball_position.msg
// DO NOT EDIT!


#ifndef CORE_MSGS_MESSAGE_BALL_POSITION_H
#define CORE_MSGS_MESSAGE_BALL_POSITION_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <std_msgs/Header.h>

namespace core_msgs
{
template <class ContainerAllocator>
struct ball_position_
{
  typedef ball_position_<ContainerAllocator> Type;

  ball_position_()
    : header()
    , size(0)
    , img_x()
    , img_y()  {
    }
  ball_position_(const ContainerAllocator& _alloc)
    : header(_alloc)
    , size(0)
    , img_x(_alloc)
    , img_y(_alloc)  {
  (void)_alloc;
    }



   typedef  ::std_msgs::Header_<ContainerAllocator>  _header_type;
  _header_type header;

   typedef int32_t _size_type;
  _size_type size;

   typedef std::vector<float, typename ContainerAllocator::template rebind<float>::other >  _img_x_type;
  _img_x_type img_x;

   typedef std::vector<float, typename ContainerAllocator::template rebind<float>::other >  _img_y_type;
  _img_y_type img_y;





  typedef boost::shared_ptr< ::core_msgs::ball_position_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::core_msgs::ball_position_<ContainerAllocator> const> ConstPtr;

}; // struct ball_position_

typedef ::core_msgs::ball_position_<std::allocator<void> > ball_position;

typedef boost::shared_ptr< ::core_msgs::ball_position > ball_positionPtr;
typedef boost::shared_ptr< ::core_msgs::ball_position const> ball_positionConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::core_msgs::ball_position_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::core_msgs::ball_position_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace core_msgs

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': True}
// {'sensor_msgs': ['/opt/ros/kinetic/share/sensor_msgs/cmake/../msg'], 'geometry_msgs': ['/opt/ros/kinetic/share/geometry_msgs/cmake/../msg'], 'core_msgs': ['/home/naverlabs/ros/capstone_design/src/core_msgs/msg'], 'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::core_msgs::ball_position_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::core_msgs::ball_position_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::core_msgs::ball_position_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::core_msgs::ball_position_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::core_msgs::ball_position_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::core_msgs::ball_position_<ContainerAllocator> const>
  : TrueType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::core_msgs::ball_position_<ContainerAllocator> >
{
  static const char* value()
  {
    return "757a1931a6c8745932637f2569d72982";
  }

  static const char* value(const ::core_msgs::ball_position_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x757a1931a6c87459ULL;
  static const uint64_t static_value2 = 0x32637f2569d72982ULL;
};

template<class ContainerAllocator>
struct DataType< ::core_msgs::ball_position_<ContainerAllocator> >
{
  static const char* value()
  {
    return "core_msgs/ball_position";
  }

  static const char* value(const ::core_msgs::ball_position_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::core_msgs::ball_position_<ContainerAllocator> >
{
  static const char* value()
  {
    return "Header header\n\
int32 size\n\
float32[] img_x\n\
float32[] img_y\n\
\n\
================================================================================\n\
MSG: std_msgs/Header\n\
# Standard metadata for higher-level stamped data types.\n\
# This is generally used to communicate timestamped data \n\
# in a particular coordinate frame.\n\
# \n\
# sequence ID: consecutively increasing ID \n\
uint32 seq\n\
#Two-integer timestamp that is expressed as:\n\
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')\n\
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')\n\
# time-handling sugar is provided by the client library\n\
time stamp\n\
#Frame this data is associated with\n\
# 0: no frame\n\
# 1: global frame\n\
string frame_id\n\
";
  }

  static const char* value(const ::core_msgs::ball_position_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::core_msgs::ball_position_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.header);
      stream.next(m.size);
      stream.next(m.img_x);
      stream.next(m.img_y);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct ball_position_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::core_msgs::ball_position_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::core_msgs::ball_position_<ContainerAllocator>& v)
  {
    s << indent << "header: ";
    s << std::endl;
    Printer< ::std_msgs::Header_<ContainerAllocator> >::stream(s, indent + "  ", v.header);
    s << indent << "size: ";
    Printer<int32_t>::stream(s, indent + "  ", v.size);
    s << indent << "img_x[]" << std::endl;
    for (size_t i = 0; i < v.img_x.size(); ++i)
    {
      s << indent << "  img_x[" << i << "]: ";
      Printer<float>::stream(s, indent + "  ", v.img_x[i]);
    }
    s << indent << "img_y[]" << std::endl;
    for (size_t i = 0; i < v.img_y.size(); ++i)
    {
      s << indent << "  img_y[" << i << "]: ";
      Printer<float>::stream(s, indent + "  ", v.img_y[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // CORE_MSGS_MESSAGE_BALL_POSITION_H
