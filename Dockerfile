FROM centos:7.4.1708

ENV	DISPLAY=:1 \
	NO_VNC_PORT=6901 \
	VNC_PORT=5901 \
	SSH_PORT=22

ENV	HOME=/home/user2 \
	TERM=xterm \
	STARTUPDIR=/dockerstartup \
	NO_VNC_HOME=/headless/noVNC \
	VNC_COL_DEPTH=24 \
	VNC_RESOLUTION=1280x1024 \
	VNC_PW=vncpassword \
	VNC_VIEW_ONLY=false

WORKDIR $HOME

# RUN scripts/tigervnc.sh
RUN yum install -y tigervnc-server-1.8.0-13.el7

# CMD ["/bin/bash"]
# CMD ["tail", "-f", "/dev/null"]

ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
CMD ["--tail-log"]
