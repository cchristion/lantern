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
    apk add git && \
    apk add sudo && \
    apk add openssh && \
    apk upgrade --available && \
    rm -rf /var/cache/apk/*

# Set a password for the new user (replace 'password' with your desired password)
RUN echo "${USERNAME}:${USERNAME}" | chpasswd

# Grant sudo privileges to the new user
RUN echo "${USERNAME} ALL=(ALL) ALL" >> /etc/sudoers

# Changing USER
USER ${USERNAME}
WORKDIR /home/${USERNAME}

# Generate ssh-key for git
RUN ssh-keygen -t ed25519 -f "/home/${USERNAME}/.ssh/git" -N ""

# Better git defaults
RUN git config --global init.defaultBranch main

# Creating a mount directory
RUN mkdir -p /home/${USERNAME}/lmount

# Start sh
ENTRYPOINT ["/bin/sh"]
