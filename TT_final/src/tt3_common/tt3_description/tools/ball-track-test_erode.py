import numpy as np
import cv2
import time
import serial
from primesense import openni2
from primesense import _openni2 as c_api
import subprocess

def nothing(x):
    pass

# Create a black image, a window
resol_x = 640
resol_y = 360
img = np.zeros((resol_x,resol_y,3), np.uint8)
cv2.namedWindow('control1')

font = cv2.FONT_HERSHEY_SIMPLEX

top_h_u = 150
top_h_l = 0
top_s_u = 50
top_s_l = 0
top_v_u = 255
top_v_l = 128

top_dilate_n = 2
top_blur_n = 0

h_u = 126
h_l = 0
s_u = 52
s_l = 0
v_u = 255
v_l = 150

dilate_n = 1
blur_n = 0

h_u_d = 79
h_l_d = 43
s_u_d = 10
s_l_d = 0
v_u_d = 97
v_l_d = 87

dilate_n_d = 2
blur_n_d = 0

photo_num = 10

erode_n = 0

hist_eq = 1

cv2.createTrackbar('HistEq','control1',hist_eq,3,nothing)

cv2.createTrackbar('photo_select','control1',photo_num,6000,nothing)

cv2.createTrackbar('top_H_upper','control1',top_h_u,255,nothing)
cv2.createTrackbar('top_H_lower','control1',top_h_l,255,nothing)
cv2.createTrackbar('top_S_upper','control1',top_s_u,255,nothing)
cv2.createTrackbar('top_S_lower','control1',top_s_l,255,nothing)
cv2.createTrackbar('top_V_upper','control1',top_v_u,255,nothing)
cv2.createTrackbar('top_V_lower','control1',top_v_l,255,nothing)
cv2.createTrackbar('top_dilate_num','control1',top_dilate_n,2,nothing)
cv2.createTrackbar('top_blur_num','control1',top_blur_n,2,nothing)

cv2.createTrackbar('H_upper','control1',h_u,255,nothing)
cv2.createTrackbar('H_lower','control1',h_l,255,nothing)
cv2.createTrackbar('S_upper','control1',s_u,255,nothing)
cv2.createTrackbar('S_lower','control1',s_l,255,nothing)
cv2.createTrackbar('V_upper','control1',v_u,255,nothing)
cv2.createTrackbar('V_lower','control1',v_l,255,nothing)
cv2.createTrackbar('dilate_num','control1',dilate_n,2,nothing)
cv2.createTrackbar('blur_num','control1',blur_n,2,nothing)

cv2.createTrackbar('H_upper_d','control1',h_u_d,255,nothing)
cv2.createTrackbar('H_lower_d','control1',h_l_d,255,nothing)
cv2.createTrackbar('S_upper_d','control1',s_u_d,255,nothing)
cv2.createTrackbar('S_lower_d','control1',s_l_d,255,nothing)
cv2.createTrackbar('V_upper_d','control1',v_u_d,255,nothing)
cv2.createTrackbar('V_lower_d','control1',v_l_d,255,nothing)
cv2.createTrackbar('dilate_num_d','control1',dilate_n_d,2,nothing)
cv2.createTrackbar('blur_num_d','control1',blur_n_d,2,nothing)

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
    hist_eq = cv2.getTrackbarPos('HistEq','control1')
    photo_num = cv2.getTrackbarPos('photo_select','control1')

    top_h_u = cv2.getTrackbarPos('top_H_upper','control1')
    top_h_l = cv2.getTrackbarPos('top_H_lower','control1')
    top_s_u = cv2.getTrackbarPos('top_S_upper','control1')
    top_s_l = cv2.getTrackbarPos('top_S_lower','control1')
    top_v_u = cv2.getTrackbarPos('top_V_upper','control1')
    top_v_l = cv2.getTrackbarPos('top_V_lower','control1')
    top_dilate_n = cv2.getTrackbarPos('top_dilate_num','control1')
    top_blur_n = cv2.getTrackbarPos('top_blur_num','control1')

    h_u = cv2.getTrackbarPos('H_upper','control1')
    h_l = cv2.getTrackbarPos('H_lower','control1')
    s_u = cv2.getTrackbarPos('S_upper','control1')
    s_l = cv2.getTrackbarPos('S_lower','control1')
    v_u = cv2.getTrackbarPos('V_upper','control1')
    v_l = cv2.getTrackbarPos('V_lower','control1')
    dilate_n = cv2.getTrackbarPos('dilate_num','control1')
    blur_n = cv2.getTrackbarPos('blur_num','control1')

    h_u_d = cv2.getTrackbarPos('H_upper_d','control1')
    h_l_d = cv2.getTrackbarPos('H_lower_d','control1')
    s_u_d = cv2.getTrackbarPos('S_upper_d','control1')
    s_l_d = cv2.getTrackbarPos('S_lower_d','control1')
    v_u_d = cv2.getTrackbarPos('V_upper_d','control1')
    v_l_d = cv2.getTrackbarPos('V_lower_d','control1')
    dilate_n_d = cv2.getTrackbarPos('dilate_num_d','control1')
    blur_n_d = cv2.getTrackbarPos('blur_num_d','control1')

    # ret,frame = cap.read()
    # frame = cv2.pyrDown(frame)
    frame = cv2.imread("/home/ghryou/workspace/NL_TT2/data/ball_0528_dark/"+str(photo_num)+".png", 1)
    output = frame.copy()

    ##Apply Histogram Equalization
    #print "Histogram Equalization"
    #img_eq = cv2.cvtColor(frame, cv2.COLOR_BGR2HLS)
    if hist_eq == 1:
        output =  cv2.erode(output,erodeElement,iterations = 2)
        # output[:,:,1] =  cv2.erode(output[:,:,1],erodeElement,iterations = 2)
        # output[:,:,2] =  cv2.erode(output[:,:,2],erodeElement,iterations = 2)

    # cv2.imshow("eroded", output)

    if hist_eq == 3:
        hlseq = cv2.cvtColor(frame, cv2.COLOR_BGR2HLS)
        hlseq[:,:,1] = cv2.equalizeHist(hlseq[:,:,1])
        img_temp = cv2.cvtColor(hlseq, cv2.COLOR_HLS2BGR)

    img = cv2.cvtColor(output, cv2.COLOR_RGB2HSV)
    if hist_eq == 2:
        #img[:,:,0] = cv2.equalizeHist(img[:,:,0])
        img[:,:,1] = cv2.equalizeHist(img[:,:,1])
        img[:,:,2] = cv2.equalizeHist(img[:,:,2])


    hsv_lower_mask = np.array([h_l,s_l,v_l])
    hsv_upper_mask = np.array([h_u,s_u,v_u])
    mask_up = cv2.inRange(img, hsv_lower_mask, hsv_upper_mask)
    #Erode & Dilate
    if erode_n != 0:
        mask_up = cv2.erode(mask_up,erodeElement,iterations = erode_n)
    if blur_n == 1:
        mask_up = cv2.GaussianBlur(mask_up,(5,5),0)
    elif blur_n == 2:
        mask_up = cv2.medianBlur(mask_up,5)
    if dilate_n != 0:
        mask_up = cv2.dilate(mask_up,dilateElement,iterations = dilate_n)
    # cv2.rectangle(mask_up, (0,resol_y/2), (resol_x,resol_y-1), 0, -1);

    print "filter upper part dark"
    img_d = cv2.cvtColor(output, cv2.COLOR_RGB2HSV)
    hsv_lower_mask_d = np.array([h_l_d,s_l_d,v_l_d])
    hsv_upper_mask_d = np.array([h_u_d,s_u_d,v_u_d])
    mask_up_d = cv2.inRange(img_d, hsv_lower_mask_d, hsv_upper_mask_d)
    #Erode & Dilate
    if erode_n != 0:
        mask_up_d = cv2.erode(mask_up_d,erodeElement,iterations = erode_n)
    if blur_n_d == 1:
        mask_up_d = cv2.GaussianBlur(mask_up_d,(5,5),0)
    elif blur_n_d == 2:
        mask_up_d = cv2.medianBlur(mask_up_d,5)
    if dilate_n != 0:
        mask_up_d = cv2.dilate(mask_up_d,dilateElement,iterations = dilate_n_d)
    mask_filter = cv2.bitwise_or(mask_up,mask_up_d)
    cv2.rectangle(mask_filter, (0,0), (resol_x,49), 0, -1);


    ##Filtering Top Part
    print "filter top part"
    img_top = cv2.cvtColor(frame, cv2.COLOR_RGB2HSV)
    top_lower_mask = np.array([top_h_l,top_s_l,top_v_l])
    top_upper_mask = np.array([top_h_u,top_s_u,top_v_u])
    mask_top = cv2.inRange(img_top, top_lower_mask, top_upper_mask)
    if top_blur_n == 1:
        mask_top = cv2.GaussianBlur(mask_top,(5,5),0)
    elif top_blur_n == 2:
        mask_top = cv2.medianBlur(mask_top,5)
        dilateElement = cv2.getStructuringElement(cv2.MORPH_RECT,(3,3))
    if top_dilate_n != 0:
        mask_top = cv2.dilate(mask_top,dilateElement,iterations = top_dilate_n)
    cv2.rectangle(mask_top, (0,50), (resol_x,resol_y-1), 0, -1);

    mask_filter = cv2.bitwise_or(mask_filter, mask_top)
    out_mask = np.hstack((mask_filter, mask_top))
    cv2.imshow( 'rgb and hsv mask', out_mask )

    # mask_filter = mask_up.copy()

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
    params.minConvexity = 0.5

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


    monitor = np.hstack((frame,output))
    cv2.imshow('img', monitor)

    keyChar = cv2.waitKey(30);

capture.release()
cv2.destroyAllWindows()
