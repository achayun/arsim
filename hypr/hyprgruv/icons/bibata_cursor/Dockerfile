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

WORKDIR /src

# Install dependencies. Ignore yarn, install directly via npm
# Ignore puppeteer: 2024-02-24: cbmp now uses @resvg/resvg-js as its default rendering engine. See discussion#24022024 for details.
COPY Bibata_Cursor/package.json ./
RUN PUPPETEER_SKIP_DOWNLOAD=1 npm install ful1e5/cbmp

COPY Bibata_Cursor Bibata_Cursor
COPY build-bibata-cursor.sh ./
RUN chmod +x ./build-bibata-cursor.sh

ENTRYPOINT ["./build-bibata-cursor.sh"]
