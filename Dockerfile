FROM centos:7.4.1708

RUN yum install -y tigervnc-server-1.8.0-13.el7 \
	wget \
	git \
	less \
	; \
	yum clean all && rm -rf /var/cache/yum

ENV	DISPLAY=:1 \
	NO_VNC_PORT=6901 \
	VNC_PORT=5901 \
	SSH_PORT=22
EXPOSE $VNC_PORT $NO_VNC_PORT $SSH_PORT

ENV	HOME=/home/user2 \
	TERM=xterm \
	STARTUPDIR=/dockerstartup \
	NO_VNC_HOME=/headless/noVNC \
	VNC_COL_DEPTH=24 \
	VNC_RESOLUTION=1280x1024 \
	VNC_PW=vncpassword \
	VNC_VIEW_ONLY=false

WORKDIR $HOME

ADD scripts scripts
# the only one missing from STARTUPDIR is generate_container_user
RUN mkdir -p $STARTUPDIR && mv scripts/vnc_startup.sh $STARTUPDIR/. \
	&& mv scripts/chrome-init.sh $STARTUPDIR/. \
	&& mv scripts/wm_startup.sh $HOME/. 

RUN scripts/no_vnc.sh

# Install xfce UI
RUN scripts/xfce_ui.sh 

ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
CMD ["--tail-log"]
