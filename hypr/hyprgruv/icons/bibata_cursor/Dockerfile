FROM archlinux:latest

RUN pacman -Syu --noconfirm \
      bash \
      git \
      make \
      nodejs \
      npm \
      python \
      python-pip \
      rsync \
    && pacman -Scc --noconfirm

# clickgen provides ctgen.
RUN python -m pip install --break-system-packages clickgen

COPY build-bibata-cursor.sh /usr/local/bin/build-bibata-cursor
RUN chmod +x /usr/local/bin/build-bibata-cursor

ENTRYPOINT ["/usr/local/bin/build-bibata-cursor"]
