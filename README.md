# lantern

1. Download Dockerfile
   1. base.Dockerfile
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

3. Running the build image
   ```shell
   docker run -it \
   -v $(pwd):/home/lantern \
   -u $(id -u):$(id -g) \
   <image id>
   ```