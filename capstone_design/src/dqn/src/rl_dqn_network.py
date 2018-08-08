#! /usr/bin/env python3
import os
import sys
import numpy as np
import torch
import torch.nn as nn
import roslib
import cv2
from std_msgs.msg import String
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError

import cv2
import rospy, roslib, rospkg

input_number=4
img_w=93
img_h=93

dtype = torch.cuda.FloatTensor if torch.cuda.is_available() else torch.FloatTensor



rospack = rospkg.RosPack()
root = rospack.get_path('dqn')
path = root+"/src/nuelnetwork/DQN_net0729.pt"

test_model = torch.load(path)
print('DQN_net0729.pt was loaded')

input_image = np.zeros((input_number,img_w,img_h), np.uint8)


class rl_dqn_network:
    def __init__(self):
        self.bridge = CvBridge()
        self.image_sub = rospy.Subscriber("RL_state/image",Image,self.callback)

    def callback(self,data):
        try:
            cv_image = self.bridge.imgmsg_to_cv2(data, "mono8")
        except CvBridgeError as e:
            print(e)

        cv2.imshow("Image window", cv_image)
        cv2.waitKey(3)
        input_image[0]=input_image[1]
        input_image[1]=input_image[2]
        input_image[2]=input_image[3]
        input_image[3]=cv_image
        image = torch.from_numpy(input_image).type(dtype).unsqueeze(0)/255.0
        action =torch.IntTensor([[test_model(image).data.max(1)[1].cpu()]])[0,0]
        print(test_model(image).data)


def main(args):
    rl = rl_dqn_network()
    rospy.init_node('rl_dqn_network', anonymous=False)
    try:
        rospy.spin()
    except KeyboardInterrupt:
        print("Shutting down")
        cv2.destroyAllWindows()

if __name__ == '__main__':
    main(sys.argv)
