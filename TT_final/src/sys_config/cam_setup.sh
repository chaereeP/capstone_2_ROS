#!/bin/bash

echo "setting up camera param"

camera_name_all=($(v4l2-ctl --list-device | awk '/usb/ {print $1;}'))
camera_all=($(v4l2-ctl --list-device | awk '/dev/ {print $1;}'))

for i in "${!camera_name_all[@]}";
do
    if [ "${camera_name_all[$i]}" = "USB_Camera" ]
    then
        echo "setting genius param"
        v4l2-ctl -d "${camera_all[$i]}" \
            --set-ctrl=brightness=-20,\
            --set-ctrl=contrast=35,\
            --set-ctrl=saturation=8,\
            --set-ctrl=hue=-2000,\
            --set-ctrl=white_balance_temperature_auto=0,\
            --set-ctrl=gamma=123,\
            --set-ctrl=white_balance_temperature=2840,\
            --set-ctrl=sharpness=5,\
            --set-ctrl=backlight_compensation=0,\
            --set-ctrl=exposure_auto=1,\
            --set-ctrl=exposure_absolute=73
        v4l2-ctl -d "${camera_all[$i]}" -l
    elif [ "${camera_name_all[$i]}" = "Astra" ]
    then
        echo "setting astra param"
        v4l2-ctl -d "${camera_all[$i]}"\
            --set-ctrl=brightness=-64,\
            --set-ctrl=contrast=95,\
            --set-ctrl=saturation=128,\
            --set-ctrl=hue=1042
            # --set-ctrl=white_balance_temperature_auto=0,\
            # --set-ctrl=gamma=126,\
            # --set-ctrl=white_balance_temperature=3463,\
            # --set-ctrl=sharpness=2,\
            # --set-ctrl=backlight_compensation=1
        v4l2-ctl -d "${camera_all[$i]}" -l
    fi
done
