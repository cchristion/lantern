# Base Docker image
FROM alpine:3.18

# Metadata
LABEL project="lantern"
LABEL version="0.6"
LABEL maintainer="cchristion"

# Environment variables
ARG gid=10001
ARG uid=10000
ARG USERNAME=lantern
ARG PASSWORD=lantern

# Adding user
RUN addgroup --gid $gid --system ${USERNAME} \
    && adduser --uid $uid --system --ingroup ${USERNAME} --home /home/${USERNAME} ${USERNAME}

# Installing softwares
RUN apk update && \
    apk add xz && \
    apk add git && \
    apk add tar && \
    apk add sudo && \
    apk add openssh && \
    apk upgrade --available && \
    rm -rf /var/cache/apk/*

# Install 7zip, 7z
RUN $( cd "/usr/local/bin" && \
    wget -O - https://7-zip.org/a/7z2301-linux-x64.tar.xz | tar -xJvf - 7zzs  && \
    ln -s 7zzs 7z )

# Set a password for the USER
RUN echo "${USERNAME}:${USERNAME}" | chpasswd

# Grant sudo privileges to the USER
RUN echo "${USERNAME} ALL=(ALL) ALL" >> /etc/sudoers

# Changing USER
USER ${USERNAME}
WORKDIR /home/${USERNAME}

# Generate ssh-key for git
RUN ssh-keygen -t ed25519 -f ~/.ssh/git -N "" -C "lantern"
RUN ssh-keyscan github.com >> ~/.ssh/known_hosts

# Better git defaults
RUN git config --global init.defaultBranch main

# Creating a mount directory
RUN mkdir -p "$HOME/lmount"

# Start sh
ENTRYPOINT ["/bin/sh"]
