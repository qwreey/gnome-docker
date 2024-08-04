#!/bin/bash
#-zaphod +iglx
#-screen 1200x800x24 -dpi

# Xephyr -br -ac -noreset -glamor +extension DAMAGE +extension MIT-SHM +extension RANDR +extension RENDER +extension GLX +extension DPMS -screen 1200x800 :1001
#  +xinerama +extension XINERAMA -schedInterval

Xephyr -schedInterval 16 +iglx -v -listen tcp -fakescreenfps 60 -ac -reset -glamor -noxv +extension COMPOSITE +extension RANDR +extension RENDER +extension DAMAGE +extension MIT-SHM +extension GLX +extension DPMS -screen 1200x800x24x60 :1001
