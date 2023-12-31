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
    sudo 7zip curl git openssh zsh

# Installing texlive
RUN apk add --upgrade --no-cache \
    texlive-full

# Changing USER
USER ${USERNAME}
WORKDIR /home/${USERNAME}

RUN curl --proto '=https' --tlsv1.3 -sSf https://raw.githubusercontent.com/cchristion/watermelon/main/install.sh -o /tmp/install.sh && sh /tmp/install.sh

# Start zsh
ENTRYPOINT ["/bin/zsh"]
