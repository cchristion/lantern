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
    adduser --uid $uid --system --ingroup ${USERNAME} --home /home/${USERNAME} ${USERNAME}

# Installing softwares
RUN apk add --upgrade --no-cache \
    git sudo openssh

# Set a password for the USER
RUN echo "${USERNAME}:${USERNAME}" | chpasswd

# Grant sudo privileges to the USER
RUN echo "${USERNAME} ALL=(ALL) ALL" >> /etc/sudoers

# Changing USER
USER ${USERNAME}
WORKDIR /home/${USERNAME}

# Generate ssh-key for git
RUN ssh-keygen -t ed25519 -f ~/.ssh/git -N "" -C "lantern"  && \
    ssh-keyscan github.com >> ~/.ssh/known_hosts && \
    eval $(ssh-agent) && ssh-add ~/.ssh/git

# Better git defaults
RUN git config --global init.defaultBranch main

# Start sh
ENTRYPOINT ["/bin/sh"]
