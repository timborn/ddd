#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "### executing $0"

# Jump from v0.6.2 to v1.1.0 (noVNC)
# No need to use a different version of websockify any more.
# Websockify v0.8.0 is current with NoVNC v1.1.0
# TODO: Verify env variables are set, or die.
TARBALL=https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz
SOCKBALL=https://github.com/novnc/websockify/archive/v0.8.0.tar.gz


echo "Install noVNC - HTML5 based VNC viewer"

mkdir -p $NO_VNC_HOME/utils/websockify

wget -qO- $TARBALL | tar xz --strip 1 -C $NO_VNC_HOME
# pre-pull websockify
wget -qO- $SOCKBALL | tar xz --strip 1 -C $NO_VNC_HOME/utils/websockify
chmod +x -v $NO_VNC_HOME/utils/*.sh
## create index.html to forward automatically to `vnc_lite.html`
## USED TO link to vnc_auto.html but that disappeared in version upgrade
ln -s $NO_VNC_HOME/vnc_lite.html $NO_VNC_HOME/index.html
