#!/bin/bash

# Environment
if [ -z "$HOSTPATH" ]; then
    HOSTPATH="./host"
fi
if [ -z "$COMPOSEFILE" ]; then
    COMPOSEFILE="docker-compose.dev.yml"
fi

# Check running
if [ -e "$HOSTPATH/vncready" ]; then
    echo "Dev docker already running!"
    exit 1
fi

# Catch ctrl+c
sigint() {
    if [ ! -z "$VNCPID" ]; then
        kill -INT "$VNCPID"
    fi
}
trap 'sigint' SIGINT

mkfifo $HOSTPATH/vncready
mkfifo $HOSTPATH/stopped
mkfifo $HOSTPATH/stopping

# Run docker compose
read -d '' INNER_LOGS_PERL << EOF
use Term::ANSIColor;
\$coloredstr=colored("docker", "blue") . ": ";
while(<>){
    print \$coloredstr,\$_ if \$_ ne "\\\\e[0m";
    select()->flush();
}
EOF
read -d '' INNER << EOF
# docker up and show journal
docker compose -f "$COMPOSEFILE" up -d
setsid docker compose -f "$COMPOSEFILE" --ansi=always logs --no-log-prefix --follow gnome-docker 2> /dev/null > >(perl -e "\$1") &
setsid docker compose -f "$COMPOSEFILE" --ansi=always exec --no-TTY gnome-docker showlog &

# take own vnc socket
while [ ! -e $HOSTPATH/vncsocket ]; do
    sleep 0.1
done
chown $(whoami) $HOSTPATH/vncsocket
echo > $HOSTPATH/vncready

# wait for killing...
cat $HOSTPATH/stopping > /dev/null

# down
docker compose -f $COMPOSEFILE down --timeout 10 2> /dev/null
echo > $HOSTPATH/stopped
EOF
sudo bash -c "$INNER" -- "$INNER_LOGS_PERL" &

# wait for vnc ready, then show viewer
cat $HOSTPATH/vncready > /dev/null
vncviewer \
    NoJPEG=1 \
    CompressLevel=0 \
    PreferredEncoding=Raw \
    SecurityTypes=None \
    ./host/vncsocket 2> >(perl -e "use Term::ANSIColor;\$coloredstr=colored(\"vnc\", \"blue\") . \": \";while(<>){print \$coloredstr,\$_;select()->flush();}") &
VNCPID="$!"
wait "$VNCPID"
VNCPID=""
echo > $HOSTPATH/stopping

# cleanup
echo -e "\e[2K\r\e[0;35mTry graceful shutdown. CTRL+C once more to force shutdown\e[0m"
cat $HOSTPATH/stopped > /dev/null
rm $HOSTPATH/vncready $HOSTPATH/stopped $HOSTPATH/stopping
exit 0
