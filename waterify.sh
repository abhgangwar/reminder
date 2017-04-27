#!/bin/bash

# Cron doesn't support notify-send directly. Need to export dbus session bus address
eval "export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $LOGNAME gnome-session)/environ)";
NOTIFIER=/usr/bin/notify-send;

SUMMARY="Drink Water !";
MESSAGE="Keeping yourself hydrated has its advantages :)"

# Send desktop notification;
$NOTIFIER -u normal -t 1000 " $SUMMARY " " $MESSAGE ";
