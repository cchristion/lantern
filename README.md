# lantern

1. Build an image

        docker build \
            -t "$(date +%Y%m%d%H%M%S)" \
            --build-arg gid="$(id -g)" \
            --build-arg uid="$(id -u)" .

2. Running the build image

        docker run -it -v \
            -$(pwd):/home/lantern \
            --u $(id -u):$(id -g) \
            -<IMAGE ID>