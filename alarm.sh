#!/bin/bash

# Cron doesn't support notify-send directly. Need to export dbus session bus address
# eval "export $(env | grep DBUS_SESSION_BUS_ADDRESS)";
eval "export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $LOGNAME gnome-session)/environ)";
NOTIFIER=/usr/bin/notify-send;
SUMMARY="Time's Up!";
MESSAGE="";
HOURS=$(date +"%H");
MINUTES=$(date +"%M");

# Remove '0' from the front from the output of hours and minutes
HOURS=${HOURS##0};
MINUTES=${MINUTES##0};
SLOT="";
/bin/echo "Hours $HOURS MINUTES $MINUTES";
if (( $MINUTES >= 30 )); then
    SLOT="First";
    MESSAGE="$HOURS:00 - $HOURS:30"
else
    SLOT="Second";
    MESSAGE="$(( $HOURS - 1 )):30 - $HOURS:00"
fi

SUMMARY="$SUMMARY - $SLOT Slot";
# Send desktop notification;
$NOTIFIER -u critical " $SUMMARY " " $MESSAGE ";
