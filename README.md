# Lantern
This repository contains a collection of configurations that I manage for various tools and applications. The purpose of this project is to simplify setup and maintenance tasks across different environments.

## Docker

1. Docker Image
   1. Download
      ```shell
      curl --proto '=https' --tlsv1.3 -sSf https://raw.githubusercontent.com/cchristion/lantern/main/Dockerfile -o Dockerfile
      ```
   2. Build an image
      ```shell
      docker build \
      -t "$(date +%Y%m%d%H%M%S)" \
      --build-arg gid="$(id -g)" \
      --build-arg uid="$(id -u)" \
      -f <Dockerfile path> \
      .
      ```
   3. Running built image
      ```shell
      docker run -it \
      -v $(pwd):/home/lantern \
      -u $(id -u):$(id -g) \
      <image id>
      ```
   4. Base Installation
      ```shell
      curl --proto '=https' --tlsv1.3 -sSf https://raw.githubusercontent.com/cchristion/lantern/main/config.sh | sh
      ```
   5. Pyenv Installation
      ```shell
      export PYENV_ROOT="${XDG_CONFIG_HOME:-$HOME/.config}/.pyenv" && curl --proto '=https' --tlsv1.3 -sSf https://pyenv.run | bash
      ```

## Installation

1. Base
   1.  Prerequisites
       ```shell
       7zip curl git sudo tmux zoxide zsh
       ```
   2. Installation
      ```shell
      curl --proto '=https' --tlsv1.3 -sSf https://raw.githubusercontent.com/cchristion/lantern/main/config.sh | sh
      ```
2. Pyenv
   1. Prerequisites
      ```shell
      7zip bash build-base bzip2-dev curl git libffi-dev linux-headers openssh openssl-dev readline-dev sqlite-dev sudo tk-dev tmux xz-dev zlib-dev zoxide zsh
      ```
   2. Installation
      ```shell
      export PYENV_ROOT="${XDG_CONFIG_HOME:-$HOME/.config}/.pyenv" && curl --proto '=https' --tlsv1.3 -sSf https://pyenv.run | bash
      ```

## Updating Configs
```shell
# cd into lantern directory
( git pull && cp -rsvf $(pwd)/.config ~/ && cp -rsvf $(pwd)/.zshenv ~/.zshenv )
```
