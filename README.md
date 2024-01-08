# lantern

## Using Docker

1. Download Dockerfile
    1. Dockerfile (base)
    ```shell
    curl --proto '=https' --tlsv1.3 -sSf https://raw.githubusercontent.com/cchristion/lantern/main/base.Dockerfile -o base.Dockerfile
    ```
    2. resume.Dockerfile
    ```shell
    curl --proto '=https' --tlsv1.3 -sSf https://raw.githubusercontent.com/cchristion/lantern/main/resume.Dockerfile -o resume.Dockerfile
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

## Install Dependencies (Alpine)
```shell
apk add --upgrade --no-cache 7zip bash build-base bzip2-dev curl git libffi-dev linux-headers openssh openssl-dev readline-dev sqlite-dev sudo tk-dev tmux xz-dev zlib-dev zoxide zsh
```

## Install dotfiles
```shell
curl --proto '=https' --tlsv1.3 -sSf https://raw.githubusercontent.com/cchristion/lantern/main/install.sh | sh
```

## Install pyenv
```shell
export PYENV_ROOT="${XDG_CONFIG_HOME:-$HOME/.config}/.pyenv" && curl --proto '=https' --tlsv1.3 -sSf https://pyenv.run | bash
```

## Updating Dotfiles
```shell
# cd into lantern directory
( git pull && cp -rsvf $(pwd)/.config ~/ && cp -rsvf $(pwd)/.zshenv ~/.zshenv )
```
