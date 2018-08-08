import numpy as np
import cv2
import time
import serial
import subprocess

def nothing(x):
    pass

# Create a black image, a window
resol_x = 640
resol_y = 360
img = np.zeros((resol_x,resol_y,3), np.uint8)
cv2.namedWindow('control1')

font = cv2.FONT_HERSHEY_SIMPLEX

# #white filter
# self.filter1 = {"h_u":163,"h_l":0,"s_u":255,"s_l":0,"v_u":186,"v_l":132,"erode":1,"dilate":1,"blur":0}
# self.filter1 = {"h_u":100,"h_l":0,"s_u":52,"s_l":0,"v_u":225,"v_l":137,"erode":0,"dilate":1,"blur":0}
# #orange filter
# self.filter2 = {"h_u":255,"h_l":0,"s_u":102,"s_l":21,"v_u":255,"v_l":95,"erode":1,"dilate":2,"blur":0}
# #green filter
# self.filter3 = {"h_u":167,"h_l":25,"s_u":54,"s_l":21,"v_u":255,"v_l":18,"erode":1,"dilate":2,"blur":0}


h_u = 255
h_l = 0
s_u = 102
s_l = 21
v_u = 255
v_l = 95

b_min = 3
b_max = 80
b_dist_min = 5
b_param1 = 220
b_param2 = 60

canny_min = 598
canny_max = 589
canny_apperture = 3
canny_L2 = 1

photo_num = 10

erode_n = 1
dilate_n = 2
blur_n = 0

cv2.createTrackbar('photo_select','control1',photo_num,1200,nothing)

cv2.createTrackbar('H_upper','control1',h_u,255,nothing)
cv2.createTrackbar('H_lower','control1',h_l,255,nothing)
cv2.createTrackbar('S_upper','control1',s_u,255,nothing)
cv2.createTrackbar('S_lower','control1',s_l,255,nothing)
cv2.createTrackbar('V_upper','control1',v_u,255,nothing)
cv2.createTrackbar('V_lower','control1',v_l,255,nothing)

cv2.createTrackbar('ball_min','control1',b_min,1000,nothing)
cv2.createTrackbar('ball_max','control1',b_max,1000,nothing)
cv2.createTrackbar('ball_min_dist','control1',b_dist_min,500,nothing)
cv2.createTrackbar('b_param1','control1',b_param1,1000,nothing)
cv2.createTrackbar('b_param2','control1',b_param2,1000,nothing)

cv2.createTrackbar('erode_num','control1',erode_n,7,nothing)
cv2.createTrackbar('dilate_num','control1',dilate_n,7,nothing)
cv2.createTrackbar('blur_num','control1',blur_n,2,nothing)

cv2.createTrackbar('canny_min','control1',canny_min,1000,nothing)
cv2.createTrackbar('canny_max','control1',canny_max,1000,nothing)
cv2.createTrackbar('canny_ap','control1',canny_apperture,2,nothing)
cv2.createTrackbar('canny_L2','control1',canny_L2,1,nothing)

erodeElement = cv2.getStructuringElement(cv2.MORPH_RECT,(3,3))
dilateElement = cv2.getStructuringElement(cv2.MORPH_RECT,(3,3))

cap = cv2.VideoCapture(0) #webcam
cap.set(cv2.CAP_PROP_FRAME_WIDTH,resol_x*2)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT,resol_y*2)

def get_pixel(event,x,y,flags,param):
    if event == cv2.EVENT_LBUTTONDBLCLK:
        print monitor[x,y]

cv2.namedWindow('img')
cv2.setMouseCallback('img',get_pixel)

while(1):
    photo_num = cv2.getTrackbarPos('photo_select','control1')

    h_u = cv2.getTrackbarPos('H_upper','control1')
    h_l = cv2.getTrackbarPos('H_lower','control1')
    s_u = cv2.getTrackbarPos('S_upper','control1')
    s_l = cv2.getTrackbarPos('S_lower','control1')
    v_u = cv2.getTrackbarPos('V_upper','control1')
    v_l = cv2.getTrackbarPos('V_lower','control1')

    b_min = cv2.getTrackbarPos('ball_min','control1')
    b_max = cv2.getTrackbarPos('ball_max','control1')
    b_dist_min = cv2.getTrackbarPos('ball_min_dist','control1')
    b_param1 = cv2.getTrackbarPos('b_param1','control1')
    b_param2 = cv2.getTrackbarPos('b_param2','control1')

    erode_n = cv2.getTrackbarPos('erode_num','control1')
    dilate_n = cv2.getTrackbarPos('dilate_num','control1')
    blur_n = cv2.getTrackbarPos('blur_num','control1')

    canny_min = cv2.getTrackbarPos('canny_min','control1')
    canny_max = cv2.getTrackbarPos('canny_max','control1')
    canny_apperture = cv2.getTrackbarPos('canny_ap','control1')
    canny_L2 = cv2.getTrackbarPos('canny_L2','control1')

    ret,frame = cap.read()
    frame = cv2.pyrDown(frame)
    # frame = cv2.imread("/home/ghryou/workspace/NL_TT2/data/ball_mix/"+str(photo_num)+".png", 1)

    output = frame.copy()

    img_down = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
    hsv_lower_mask = np.array([h_l,s_l,v_l])
    hsv_upper_mask = np.array([h_u,s_u,v_u])
    mask = cv2.inRange(img_down, hsv_lower_mask, hsv_upper_mask)
    #Erode & Dilate
    if erode_n != 0:
        mask = cv2.erode(mask,erodeElement,iterations = erode_n)
    if blur_n == 1:
        mask = cv2.GaussianBlur(mask,(5,5),0)
    elif blur_n == 2:
        mask = cv2.medianBlur(mask,5)
    if dilate_n != 0:
        mask = cv2.dilate(mask,dilateElement,iterations = dilate_n)

    cv2.imshow( 'hsv mask', mask )

    mask_filter = mask

    print "blob detect"
    params = cv2.SimpleBlobDetector_Params()

    # Change thresholds
    params.minThreshold = 10
    params.maxThreshold = 200

    params.filterByColor = False
    params.blobColor = 255

    params.minDistBetweenBlobs = 5

    # Filter by Circularity
    params.filterByCircularity = False
    params.minCircularity = 0.7

    # Filter by Convexity
    params.filterByConvexity = False
    params.minConvexity = 0.9

    # Filter by Inertia
    params.filterByInertia = False
    params.minInertiaRatio = 0.01

    # Create a detector with the parameters
    ver = (cv2.__version__).split('.')
    if int(ver[0]) < 3 :
    	detector = cv2.SimpleBlobDetector(params)
    else :
    	detector = cv2.SimpleBlobDetector_create(params)

    # Detect blobs.
    keypoints = detector.detect(mask_filter)
    output = cv2.drawKeypoints(output, keypoints, np.array([]), (0,0,255), cv2.DRAW_MATCHES_FLAGS_DRAW_RICH_KEYPOINTS)

    #HCT
    # mask3 = cv2.bitwise_and(frame,frame, mask= mask)  #masking
    # overlap = cv2.cvtColor(mask3, cv2.COLOR_BGR2GRAY)
    #
    # if select_mask == 1:
    #     edges = cv2.Canny(overlap, canny_min,canny_max)
    # else:
    #     edges = cv2.Canny(mask, canny_min,canny_max)
    #
    # out2 = np.hstack((overlap,edges))
    # # cv2.imshow('overlapped_and_edges',out2)
    #
    # circles = cv2.HoughCircles(edges, cv2.HOUGH_GRADIENT, 2, b_dist_min,param1 = b_param1, param2=b_param2, minRadius=b_min, maxRadius=b_max)
    #
    # goal_pos = (-1,-1)
    # max_r = 0
    # if circles is not None:
    #     # convert the (x, y) coordinates and radius of the circles to integers
    #     circles = np.round(circles[0, :]).astype("int")
    #
    #     # loop over the (x, y) coordinates and radius of the circles
    #     i = 1
    #     for (x, y, r) in circles:
    #         cv2.circle(output, (x, y), r, (0, 255, 0), 4)
    #         cv2.rectangle(output, (x - 5, y - 5), (x + 5, y + 5), (0, 128, 255), -1)
    #         cv2.putText(output,'circle radius '+str(r) ,(x-60,y+20), font, 0.6,(0,0,200),2)
    #         i = i+1
    #         if r > max_r:
    #             max_r = r
    #             goal_pos = (x,y)

    monitor = np.hstack((frame,output))
    cv2.imshow('img', monitor)

    keyChar = cv2.waitKey(30);

capture.release()
cv2.destroyAllWindows()
