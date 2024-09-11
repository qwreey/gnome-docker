# Options

All options accept blank string.

## DISPLAY

Xorg display for gnome-shell
If XVFB_ENABLE is true, create new X for it
Default: :0

## XVFB_ENABLE

Enable xvfb. If you plan to use host Xorg socket, you can disable this
Default: true

## XVFB_SCREEN_WIDTH

Width of screen.
Default: 1200

## XVFB_SCREEN_HEIGHT

Height of screen.
Default: 800

## XVFB_SCREEN_FRAMERATE

Framerate of screen.
Default: 60

## XVFB_FBDIR

xvfb fb dir
Default: /tmp/xvfb

## XVFB_GPU

Use '+extension GLX +render' option
Default: true

## GNOME_SESSION_CMDLINE

Command-line option for gnome-session
Default: --disable-acceleration-check

## RDP_ENABLE

Whether to use rdp
Default: true

## RDP_OPTION

Command-line option for freerdp-shadow-cli3
See freerdp-shadow-cli3 --help 
Default: -auth /monitors:0

## VNC_ENABLE

Whether to use vnc
Default: true

## VNC_OPTION

Command-line option for x0vncserver
See x0vncserver --help
Default: -SecurityTypes=None

## DEBUG

Verbose mode for session manager
Default: false

## SYSTEMD_CMDLINE

Command-line option for /sbin/init (systemd)
Default: quiet

## BEFORE_GNOME

Command before gnome execution
Default: ""

## AUTO_RESTART

Auto restart gnome when logout gnome. when gnome restarting, BEFORE_GNOME will re-executed
Default: true

## XRANDR_FIX_ENABLED

Gnome thinks the xvfb screen has a refresh rate of 0, so we do an xrandr to fix that
Default: true

## ROOTMODE

Run gnome under root. if disable this, gnome will running under 'gnome' account
Default: true
