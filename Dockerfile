# This Dockerfile will build a binary release tarball of the hcc-dotfiles with
# all downloadable assets already installed (zsh plugins, tmux plugins, nvim
# plugins & language servers). It can be extracted into a newly created home
# directory to instantly have a fully functioning environment, even if there is
# no internet connection available (so fetching plugins from github wouldn't
# work).

FROM ubuntu:22.04

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Pre-install the set of things that the dotfiles `install` script would install.
# See that script for comments justifying some of these items.
RUN apt update && apt install -y \
    apt-utils \
    bash \
    curl \
    eatmydata \
    fuse \
    git \
    golang \
    python3 \
    python3-dev \
    python3-pip \
    python3-virtualenv \
    python3-venv \
    python3-setuptools \
    ripgrep \
    sudo \
    tmux \
    unzip \
    zsh \
    zstd \
    && true

RUN groupadd -g 1000 dotbuilder && \
    useradd -g dotbuilder -G sudo --create-home --shell=/bin/bash dotbuilder && \
    echo '%dotbuilder ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER dotbuilder:dotbuilder
WORKDIR /home/dotbuilder

# Needed to be able to run nvim AppImage inside Docker, where FUSE isn't allowed for security reasons
ENV APPIMAGE_EXTRACT_AND_RUN=1

CMD /home/dotbuilder/src/hcc-dotfiles/inside-docker-install-and-make-tarballs
