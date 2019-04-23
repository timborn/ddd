#!/usr/bin/env bash
### every exit != 0 fails the script

# Jump from v0.6.2 to v1.1.0.  
# No need to use a different version of websockify any more.
# TODO: Verify env variables are set, or die.
TARBALL=https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz
SOCKBALL=https://github.com/novnc/websockify/archive/v1.1.0.tar.gz


echo "Install noVNC - HTML5 based VNC viewer"

mkdir -p $NO_VNC_HOME

wget -qO- $TARBALL | tar xz --strip 1 -C $NO_VNC_HOME
# pre-pull websockify
wget -qO- $SOCKBALL | tar xz --strip 1 -C $NO_VNC_HOME/utils/websockify
chmod +x -v $NO_VNC_HOME/utils/*.sh
## create index.html to forward automatically to `vnc_auto.html`
ln -s $NO_VNC_HOME/vnc_auto.html $NO_VNC_HOME/index.html
