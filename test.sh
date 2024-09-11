#!/bin/bash

if [ -e ./host/running ]; then
    echo "Dev docker already running!"
    exit 1
fi

if [ -z "$COMPOSEFILE" ]; then
    COMPOSEFILE="docker-compose.dev.yml"
fi

# Catch ctrl+c
sigint() {
    [ -e "./host/running" ] && rm ./host/running
    if [ ! -z "$VNCPID" ]; then
        kill -INT "$VNCPID"
        wait $VNCPID
    fi
    wait "$DOCKERPID"
    exit 0
}
trap 'sigint' SIGINT

# Run docker compose
read -d '' INNER << EOF
# docker up and show journal
docker compose -f $COMPOSEFILE up -d 2> /dev/null
setsid docker compose -f $COMPOSEFILE logs --no-log-prefix --follow gnome-docker 2> /dev/null
setsid docker compose -f $COMPOSEFILE exec --no-TTY gnome-docker journalctl -f 2> /dev/null

# take own vnc socket
while [ ! -e ./host/vncsocket ]; do
    sleep 0.1
done
chown $(whoami) ./host/vncsocket
touch ./host/vncready

# wait for killing...
while [ -e ./host/running ]; do
    sleep 1
done

# down
rm ./host/vncready
docker compose -f $COMPOSEFILE down --timeout 10 2> /dev/null
EOF
touch ./host/running
sudo bash -c "$INNER" &
DOCKERPID="$!"

# wait for vnc ready, then show viewer
while [ ! -e ./host/vncready ]; do
    sleep 0.1
done
vncviewer NoJPEG=1 CompressLevel=0 PreferredEncoding=Raw SecurityTypes=None ./host/vncsocket &
VNCPID="$!"
wait "$VNCPID"
VNCPID=""

# cleanup
rm ./host/running
wait "$DOCKERPID"
exit 0
