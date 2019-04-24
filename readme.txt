Mon Apr 22 15:35:28 MST 2019
----------------------------
Replicate Docker Developer Desktop, in particular the NoVNC aspects so can work out versions that 
actually work together.

Tue Apr 23 09:29:45 MST 2019
----------------------------
tigervnc and NoVNC both installed.  How does VNC server get started? 
When I run vncserver by hand, it asks me questions (interactive) and subsequent starts seem to 
come up and immediately kill the process.  Huh?

That premature death comes from $HOME/.vnc/xstartup.  The last line explicitly kills the process
it just started.  Created by running vncserver, I think.  I added a script that gets rid of the kill.

Hooray!  VNC starts now, and http://localhost:6901 resolves to NoVNC (which requires an extra button 
press to connect, for some reason), but no desktop shows up.  Xfce issue?  

DONE: get desktop to show up
TODO: figure out how to use https for encrypted link

Wed Apr 24 09:40:03 MST 2019
----------------------------
Xfce4 is in EPEL for CentOS (not clear where in RHEL), so I had to install the EPEL repo to get Xfce.
NoVNC on http://localhost:6901 resolves correctly, gets the password and the desktop appears.

Woot!
