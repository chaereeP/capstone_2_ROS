#! /usr/bin/env python3
import os
import sys
import numpy as np
import torch
import torch.nn as nn
import roslib
import torchvision
from torchvision import datasets, models, transforms


from std_msgs.msg import String
from sensor_msgs.msg import CompressedImage

import cv2
import rospy, roslib, rospkg
from PIL import Image



device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")


data_T= transforms.Compose([
        transforms.Resize(256),
        transforms.CenterCrop(224),
        transforms.ToTensor(),
        transforms.Normalize([0.485, 0.456, 0.406], [0.229, 0.224, 0.225])])

rospack = rospkg.RosPack()
root = rospack.get_path('cnn_for_jetson')
path = root+"/src/nuelnetwork/CNN_dogcat0810.pt"

test_model = torch.load(path)
print('CNN_dogcat0810.pt was loaded')



class catdog_cnn_network:
    def __init__(self):
        self.image_sub = rospy.Subscriber("catdog/image",CompressedImage,self.callback)

    def callback(self,data):
        np_arr = np.fromstring(data.data, np.uint8)
        cv_image = cv2.imdecode(np_arr ,cv2.IMREAD_COLOR )
        cv2.imshow("Image window", cv_image)
        cv2.waitKey(3)

        cv_image=Image.fromarray(cv_image)
        input_transform=data_T(cv_image)
        input_tensor=torch.zeros([1,3, 224, 224]).to(device)
        input_tensor[0]=input_transform

        outputs = test_model(input_tensor)
        _, preds = torch.max(outputs, 1)
        # print(preds)
        pub = rospy.Publisher('catdog/String', String, queue_size=1)
        for x in ['cat','dog']:
            if x ==['cat','dog'][preds]:
                pub.publish(x)
                print(x)


def main(args):

    rospy.init_node('catdog_cnn_network', anonymous=False)
    cnn = catdog_cnn_network()
    rospy.spin()

if __name__ == '__main__':
    main(sys.argv)
