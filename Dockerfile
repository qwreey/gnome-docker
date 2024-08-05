FROM archlinux AS arch-systemd

STOPSIGNAL SIGRTMIN+3
ENV container docker

RUN --mount=type=cache,target=/var/cache/pacman pacman -Suy --noconfirm
RUN systemctl mask systemd-machine-id-commit.service
# RUN sed 's/#LogLevel=info/LogLevel=warning/' -i /etc/systemd/system.conf
COPY systemd-docker/root /

FROM arch-systemd AS gnome

RUN --mount=type=cache,target=/var/cache/pacman pacman -Suy --noconfirm firefox xorg-xrandr tigervnc freerdp2 gnome gnome-remote-desktop xorg-server-xvfb

COPY --chown=root:root root /

RUN systemctl mask rtkit-daemon.service
RUN useradd -m -s /bin/bash gnome
RUN su gnome sh -c 'systemctl --user enable session-manager.service'

ENTRYPOINT /usr/local/bin/entrypoint
