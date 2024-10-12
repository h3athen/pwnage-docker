# Use Ubuntu 24 LTS image as the base
FROM ubuntu:24.04

# Update and install necessary tools
RUN apt-get update && apt-get install -y \
    python3 python3-pip \
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
    curl \
    tmux \
    && apt-get clean

# Set up the User pwnage
RUN useradd -m pwnage && echo "pwnage:pwnage" | chpasswd && adduser pwnage sudo
RUN echo "pwnage ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch to the pwnage
USER pwnage

# Set working directory
WORKDIR /home/pwnage

# Exporting .local/bin to the PATH
RUN echo 'PATH="$HOME/.local/bin/:$PATH"' >> ~/.bashrc

# Installing and setting up pwndbg
RUN git clone https://github.com/pwndbg/pwndbg /home/pwnage/pwndbg && \
    cd /home/pwnage/pwndbg && ./setup.sh

# Install pwntools
RUN python3 -m pip install --upgrade pip --break-system-packages && python3 -m pip install --upgrade pwntools --break-system-packages

# Neovim Setup
RUN mkdir -p ~/.config/nvim && \
    wget -O ~/.config/nvim/init.vim https://gist.githubusercontent.com/h3athen/1cdc24d07c4d6be2e84cab88f312fe7a/raw/6d56b3393aa140ae34f3231dfbb1d7381967d9ea/init.vim

# Entry point
CMD ["/bin/bash"]