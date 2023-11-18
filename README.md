# lantern

1. Build an image
```shell
docker build \
    -t "$(date +%Y%m%d%H%M%S)" \
    --build-arg gid="$(id -g)" \
    --build-arg uid="$(id -u)" \
	-f <Dockerfile path> \
	.
```

2. Running the build image
```shell
docker run -it \
    -v $(pwd):/home/lantern \
    -u $(id -u):$(id -g) \
    <image id>