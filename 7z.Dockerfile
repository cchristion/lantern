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
    xz tar sudo

# Install 7zip, 7z
RUN wget -O - https://7-zip.org/a/7z2301-linux-x64.tar.xz | tar -C "/usr/local/bin" -xvJf - 7zzs

# Set a password for the USER
RUN echo "${USERNAME}:${USERNAME}" | chpasswd

# Grant sudo privileges to the USER
RUN echo "${USERNAME} ALL=(ALL) ALL" >> /etc/sudoers

# Changing USER
USER ${USERNAME}
WORKDIR /home/${USERNAME}

# Start sh
ENTRYPOINT ["/bin/sh"]