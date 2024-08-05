#!/bin/sh
exec vncviewer NoJPEG=1 CompressLevel=0 PreferredEncoding=Raw SecurityTypes=None ./host/vncsocket
