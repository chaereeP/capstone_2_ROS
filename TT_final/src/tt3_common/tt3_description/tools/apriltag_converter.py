import cv2
import numpy as np

root = "./tag/"
resol_x = 80
resol_y = 80
size = resol_x*10, resol_y*10

for tag in range(0,30):
    frame_resized = np.zeros(size, dtype=np.uint8)
    if tag < 10:
        frame = cv2.imread(root+"tag36_11_0000"+str(tag)+".png", 2)
    elif tag < 100:
        frame = cv2.imread(root+"tag36_11_000"+str(tag)+".png", 2)
    else:
        frame = cv2.imread(root+"tag36_11_00"+str(tag)+".png", 2)

    for i in range(0,10):
        for j in range(0,10):
            frame_resized[i*resol_x:(i+1)*resol_x,j*resol_y:(j+1)*resol_y] = frame[i,j]

    frame_resized[0,0:10*resol_y] = 0
    frame_resized[0:10*resol_x,0] = 0
    frame_resized[10*resol_x-1,0:10*resol_y] = 0
    frame_resized[0:10*resol_x,10*resol_y-1] = 0

    cv2.imwrite("./resized/tag_"+str(tag)+".png",frame_resized)
