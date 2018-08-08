import cv2
import rospkg
import yaml
import numpy as np

rospack = rospkg.RosPack()
path = rospack.get_path('tt3_description')
param_path = path + "/config/camera-genius-640x360.yaml"
image_path = path + "/tools/homography/homography.jpg"

stream = open(param_path, 'r')
params = yaml.load(stream)

resol_x = params["Camera.width"]
resol_y = params["Camera.height"]
fx = params["Camera.fx"]
fy = params["Camera.fy"]
cx = params["Camera.cx"]
cy = params["Camera.cy"]

objPts = []
srcPts = []

def getPoints(event,x,y,flags,param):
    if event == cv2.EVENT_LBUTTONDOWN:
        srcPts.append([(x-cx)/fx,(y-cy)/fy])
        print len(srcPts)
        print "x = "+str((x-cx)/fx)+", y = "+str((y-cy)/fy)
        print objPts[len(srcPts)-1]

if __name__ == '__main__':
    frame = cv2.imread(image_path,1)

    tag_dist = 0.375

    for i in range(-3,4):
        objPts.append([5*tag_dist,i*tag_dist])

    for i in range(-3,4):
        objPts.append([4*tag_dist,i*tag_dist])

    for i in range(-3,4):
        objPts.append([3*tag_dist,i*tag_dist])

    for i in range(-2,3):
        objPts.append([2*tag_dist,i*tag_dist])

    for i in range(-1,2):
        objPts.append([1*tag_dist,i*tag_dist])

    # srcPts = [[-1,1],[1,1],[1,-1],[-1,-1]]
    # srcPts = np.load(path+"/tools/astra-320x240-4l.npy").tolist()

    cv2.namedWindow("image")
    cv2.setMouseCallback("image",getPoints)

    while(1):
        cv2.imshow("image", frame)
        key = cv2.waitKey(10)&0xFF
        if key == ord('q'):
            break;

    H = cv2.findHomography(np.float32(srcPts),np.float32(objPts))
    print H[0]
    np.save(path+"/tools/srcPts",srcPts)

    cv2.destroyAllWindows()
