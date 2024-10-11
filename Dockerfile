# Use Ubuntu 24 LTS image as the base
FROM ubuntu:24.04

# Update and install necessary tools
RUN apt-get update && apt-get install -y \
    python3 python3-pip python-dev \
    gdb \
    neovim \
    git \
    build-essential \
    libffi-dev \
    libssl-dev \
    libc6-dev-i386 \
    wget \
    tmux \
    sudo \
    && apt-get clean

# Install pwntools
RUN python3 -m pip install --upgrade pip && python3 -m pip install --upgrade pwntools