#!/usr/bin/env bash
set -e

echo "### executing $0"

# modeled on src/rhel/install/xfce_ui.sh

echo -e "\n------------------ Installing Xfce4 UI components and disable xfce-polkit ------------"

## errors:
## There is no installed groups file.
## Maybe run: yum groups mark convert (see man yum)
## yum groups mark convert 

yum install -y epel-release	### CentOS has xfce in EPEL

echo -e "\n----------------- yum groups list ---------------------"
yum groups list
echo -e "---------------------------------------------------------"

yum -y -x gnome-ring groups install "Xfce"
yum -y groups install "Fonts"
yum erase -y *power* *screensaver*
yum clean all && rm -rf /var/cache/yum
rm /etc/xdg/autostart/xfce-polkit*
/bin/dbus-uuidgen > /etc/machine-id
