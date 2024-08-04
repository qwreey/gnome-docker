FROM archlinux AS arch-systemd

STOPSIGNAL SIGRTMIN+3
ENV container docker

RUN --mount=type=cache,target=/var/cache/pacman pacman -Suy --noconfirm
RUN systemctl mask systemd-machine-id-commit.service
RUN sed 's/#LogLevel=info/LogLevel=warning/' -i /etc/systemd/system.conf
COPY systemd-docker/root /

ENTRYPOINT /sbin/init quiet loglevel=3


FROM arch-systemd AS gnome

RUN --mount=type=cache,target=/var/cache/pacman pacman -Suy --noconfirm freerdp2 gnome gnome-remote-desktop xorg-server-xvfb

COPY etc /etc

RUN useradd -m -s /bin/bash gnome
RUN su gnome sh -c 'systemctl --user enable xvfb@:1.service xfreerdp@:1.service gnome@:1.service'

ENTRYPOINT /sbin/init quiet loglevel=3
