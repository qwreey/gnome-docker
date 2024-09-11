#!/bin/bash

read -d '' INNER << EOF
trap 'int' SIGINT

docker compose -f docker-compose.yml up -d 2> /dev/null

docker compose -f docker-compose.yml exec --no-TTY gnome-docker journalctl -f &
LOG="\$!"

while [ -e ./host/running ]; do
    sleep 1
done

docker compose -f docker-compose.yml down --timeout 10 2> /dev/null
wait \$LOG
EOF

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

touch ./host/running

sudo bash -c "$INNER" &
DOCKERPID="$!"

while [ ! -e ./host/vncsocket ]; do
    sleep 0.1
done

vncviewer NoJPEG=1 CompressLevel=0 PreferredEncoding=Raw SecurityTypes=None ./host/vncsocket &
VNCPID="$!"

wait "$VNCPID"
VNCPID=""

rm ./host/running
wait "$DOCKERPID"

exit 0
