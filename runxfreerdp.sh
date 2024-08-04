#!/bin/bash

xfreerdp3 /u:"gnome" /p:"" /v:"localhost" /cert:ignore /bpp:32 +multitouch +gestures -compression /clipboard:direction-to:all,files-to:all /audio-mode:0
