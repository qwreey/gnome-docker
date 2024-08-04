FROM archlinux

ENV container docker

STOPSIGNAL SIGRTMIN+3

RUN systemctl mask systemd-machine-id-commit.service
RUN pacman -Suy --noconfirm gnome gnome-remote-desktop

ENTRYPOINT /sbin/init

