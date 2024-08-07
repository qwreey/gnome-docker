# Options

All options accept blank string.

## DISPLAY

Xorg display for gnome-shell
If XVFB_ENABLE is true, create new X for it
Default: :0

## XVFB_ENABLE

Enable xvfb. If you plan to use host Xorg socket, you can disable this
Default: true

## XVFB_SCREEN

Size of screen. value format is WxHxCOLORxFRAME
Default: 1200x800x24x60

## XVFB_FBDIR

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
