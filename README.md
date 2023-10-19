# lantern

1. Build an image

        docker build \
            -t "$(date +%Y%m%d%H%M%S)" \
            --build-arg gid="$(id -g)" \
            --build-arg uid="$(id -u)" \
            .
