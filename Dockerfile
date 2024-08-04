FROM archlinux

ENV container docker

RUN pacman -Suy --noconfirm gnome gnome-remote-desktop

RUN systemctl mask systemd-machine-id-commit.service
RUN useradd -m -s /bin/bash gnome
RUN systemctl enable gdm.service

RUN sed 's/#LogLevel=info/LogLevel=warning/' -i /etc/systemd/system.conf
COPY etc /etc

# RUN systemctl enable --user --now gnome-remote-desktop
STOPSIGNAL SIGRTMIN+3

ENTRYPOINT /sbin/init quiet loglevel=3
