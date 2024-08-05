#!/bin/sh
#-nego /gfx +dynamic-resolution /gfx:frame-ack:on,progressive:on
xfreerdp3 /gfx:frame-ack:on,progressive:off,AVC420:off,AVC444:off,thin-client:off +menu-anims /cache:bitmap -encryption +async-update +async-channels +aero /gdi:hw /network:lan /u:"gnome" /p:"" /v:"localhost" /cert:ignore /bpp:24 +multitouch +gestures -compression /clipboard:direction-to:all,files-to:all /audio-mode:0

#/cache: [bitmap[:on|off],codec[:rfx|nsc],glyph[:on|off],offscreen[:on|off],
#            persist,persist-file:<filename>]
#+async-update +async-channels +aero
