#!/vendor/bin/sh
#
# Copyright (c) 2013-2025, Motorola LLC  All rights reserved.
#

export PATH=/vendor/bin:$PATH

scriptname=${0##*/}
notice()
{
    echo "$*"
    echo "$scriptname: $*" > /dev/kmsg
}

# Output destination and permissions
OUT_PATH=/data/vendor/hardware_status

OUT_USR=system
OUT_GRP=system
OUT_PERM=0644
OUT_PATH_PERM=0755

# PATH_TOUCH_CLASS="/sys/class/touchscreen/"`cd /sys/class/touchscreen && ls */ic_ver | sed 's/ic_ver//g'`
PATH_TOUCH_MMI="/sys/class/touchscreen/"

#
# Append one piece of status data to a given file. If a value is blank,
# then nothing will be written.
#
# $1 - tag
# $2 - value
# $3 - file to write
write_one_status_data()
{
    if [ -n "${2}" ]; then
        VALUE="${2}"
        echo "${1}=${VALUE}" >> ${3}
    fi
}

#
# Applies the appropriate file permissions to the
# hardware status data file.
#
# $1 - file to write to
apply_status_data_perms()
{
    chown ${OUT_USR}.${OUT_GRP} "${1}"
    chmod ${OUT_PERM} "${1}"
}
# Wait for fingerrprint HAL to initialize sensor before reading status
#
# copy fingerprint data
# persist.vendor.hardware.fingerprint is used to store fps vendor
# vendor.hw.fingerprint.status stores whether FPS sensor is started successfully
#
copy_fps_hw_status_data()
{
    FILE="${OUT_PATH}/fps"
    sid_na=
    FPSSTS=
    fps_status_property=vendor.hw.fingerprint.status
    fps_vendor_property=persist.vendor.hardware.fingerprint
    FPSSTS=$(getprop $fps_status_property 2> /dev/null)
    if [ "$FPSSTS" = "ok" ]; then
        VEND=$(getprop $fps_vendor_property 2> /dev/null)
        #Fingerprint sensor is detected
        sid_na=1
    else
        #Fingerprint sensor is not available
        sid_na=0
    fi
    notice "fps_status = ${FPSSTS}  fps_vendor= ${VEND}"
    write_one_status_data "sid_na" "${sid_na}" "${FILE}"
    apply_status_data_perms "${FILE}"
}

# collecting audio hw status like speaker and receiver status
#
copy_audio_hw_status_data()
{
    FILE="${OUT_PATH}/audio"
    spk_na=
    rcv_na=
    spk_na_property=persist.vendor.mot_audio.speaker_status
    rcv_na_property=persist.vendor.mot_audio.receiver_status
    spk_na=$(getprop $spk_na_property 2> /dev/null)
    rcv_na=$(getprop $rcv_na_property 2> /dev/null)

    notice "spk_na = ${spk_na}  rcv_na= ${rcv_na}"
    if [ -z "$spk_na" ]; then
        notice "spk_na is null or unset"
        spk_na=0x80
    fi
    if [ -z "$rcv_na" ]; then
        notice "rcv_na is null or unset"
        rcv_na=0x80
    fi
    write_one_status_data "spk_na" "${spk_na}" "${FILE}"
    write_one_status_data "rcv_na" "${rcv_na}" "${FILE}"
    apply_status_data_perms "${FILE}"
}
# collecting touch hw status to see if touch is open
#
copy_touch_hw_status_data()
{
    FILE="${OUT_PATH}/touch"
    tp_open=
    if [ -e "${PATH_TOUCH_MMI}" ]; then
        cd ${PATH_TOUCH_MMI}
        for i in $(ls */ic_ver); do
            class_name=`echo $i|sed 's/ic_ver//g'`
            PATH_TOUCH_CLASS=${PATH_TOUCH_MMI}${class_name}
            if [ -e "${PATH_TOUCH_CLASS}/vendor" ]; then
                tp_open=`cat ${PATH_TOUCH_CLASS}/hardware_status`
                notice "tp_open = ${tp_open}"
                if [ -z "$tp_open" ]; then
                    notice "tp_open is null or unset"
                    tp_open=0
                fi
                notice "tp_open = ${tp_open}"
                write_one_status_data "tp_open"  "${tp_open}" "${FILE}"
                apply_status_data_perms "${FILE}"
            fi
        done
    fi
}

#
# Clear out all status data in this directory. If in the future we decide
# to remove a component, we want to make sure any old files are not present.
rm -f /data/vendor/hardware_status/*
mkdir -p ${OUT_PATH}
chown ${OUT_USR}.${OUT_GRP} ${OUT_PATH}
chmod ${OUT_PATH_PERM} ${OUT_PATH}

# Wait 10s for fingerprint sensor to be ready before reading fingerprint status
sleep 10
#get fingerprint sensor data
copy_fps_hw_status_data
#get audio hal status  data
copy_audio_hw_status_data
#get touch sysfs data
copy_touch_hw_status_data
