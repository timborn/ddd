#!/bin/bash
### every exit != 0 fails the script
set -e
 
echo "### executing $0"

# should also source $STARTUPDIR/generate_container_user
[ -f $HOME/.bashrc ] && source $HOME/.bashrc
 
# add `--skip` to startup args, to skip the VNC startup procedure
if [[ $1 =~ --skip ]]; then
    echo -e "\n\n------------------ SKIP VNC STARTUP -----------------"
    echo -e "\n\n------------------ EXECUTE COMMAND ------------------"
    echo "Executing command: '${@:2}'"
    exec "${@:2}"
fi
 
## write correct window size to chrome properties
$STARTUPDIR/chrome-init.sh
 
## resolve_vnc_connection
VNC_IP=$(hostname -i)
 
## change vnc password
echo -e "\n------------------ change VNC password  ------------------"
# first entry is control, second is view (if only one is valid for both)
mkdir -p "$HOME/.vnc"
PASSWD_PATH="$HOME/.vnc/passwd"
if [[ $VNC_VIEW_ONLY == "true" ]]; then
    echo "start VNC server in VIEW ONLY mode!"
    #create random pw to prevent access
    echo $(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20) | vncpasswd -f > $PASSWD_PATH
fi
echo "$VNC_PW" | vncpasswd -f >> $PASSWD_PATH
chmod 600 $PASSWD_PATH
 
 
## start vncserver and noVNC webclient
$NO_VNC_HOME/utils/launch.sh --vnc localhost:$VNC_PORT --listen $NO_VNC_PORT &
vncserver -kill $DISPLAY || rm -rfv /tmp/.X*-lock /tmp/.X11-unix || echo "remove old vnc locks to be a reattachable container"
### 190423 TDB - vncserver generates ~/.vnc/xstartup that includes a line to kill the process just started
### stop it from generating and use a sanitized version instead
### vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION 
vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION -xstartup $HOME/scripts/xstartup
### $HOME/scripts/fix-xstartup.sh  # TDB 190423 - stinky hack for bug in vncserver xstartup
# TDB 180210 - HOME was set to /headless when vnc was installed, but something else when container starts, so we were missing wm_startup.sh
echo "Do we need to configure HOME=$HOME for vnc?"
if [ ! -f $HOME/wm_startup.sh ] ; then
        echo "Installing $HOME/wm_startup.sh"
        cp /headless/wm_startup.sh $HOME/wm_startup.sh
fi
if [ ! -d $HOME/noVNC ] ; then
        echo "Installing $HOME/noVNC/"
        cp -r /headless/noVNC $HOME/.
fi
$HOME/wm_startup.sh
 
## log connect options
echo -e "\n\n------------------ VNC environment started ------------------"
echo -e "\nVNCSERVER started on DISPLAY= $DISPLAY \n\t=> connect via VNC viewer with $VNC_IP:$VNC_PORT"
echo -e "\nnoVNC HTML client started:\n\t=> connect via http://$VNC_IP:$NO_VNC_PORT/?password=...\n"
 
if [ -z "$1" ] || [[ $1 =~ -t|--tail-log ]]; then
    # if option `-t` or `--tail-log` block the execution and tail the VNC log
    echo -e "\n------------------ $HOME/.vnc/*$DISPLAY.log ------------------"
    tail -f $HOME/.vnc/*$DISPLAY.log
else
    # unknown option ==> call command
    echo -e "\n\n------------------ EXECUTE COMMAND ------------------"
    echo "Executing command: '$@'"
    exec "$@"
fi
