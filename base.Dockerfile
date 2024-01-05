# Base Docker image
FROM alpine:3.18

# Metadata
LABEL project="lantern"
LABEL maintainer="cchristion"

# Environment variables
ARG gid=10001
ARG uid=10000
ARG USERNAME=lantern
ARG PASSWORD=lantern

# Adding user
RUN addgroup --gid $gid --system ${USERNAME} && \
    adduser --uid $uid --system \
    --ingroup ${USERNAME} --home /home/${USERNAME} \
    --shell /bin/zsh ${USERNAME}

# Set a password for the USER
RUN echo "${USERNAME}:${PASSWORD}" | chpasswd

# Grant sudo privileges to the USER
RUN echo "${USERNAME} ALL=(ALL) ALL" >> /etc/sudoers

# Installing softwares
RUN apk add --upgrade --no-cache \
    7zip bash curl git openssh sudo zsh

# Changing USER
USER ${USERNAME}
WORKDIR /home/${USERNAME}

# Install watermelon
RUN curl --proto '=https' --tlsv1.3 -sSf https://raw.githubusercontent.com/cchristion/watermelon/main/install.sh | sh

# Install pyenv
RUN export PYENV_ROOT="${XDG_CONFIG_HOME:-$HOME/.config}/.pyenv" && curl --proto '=https' --tlsv1.3 -sSf https://pyenv.run | bash

# Start zsh
ENTRYPOINT ["/bin/zsh"]
