# Koinos

Currently, Koinos docker images are not uploaded, you will have to build them manually. Thankfully, this is easy. In the future, images will be automatically uploaded.

Each microservice already contains a Dockerfile.

You will need to install Docker on MacOS or Windows first. You can follow their instructions for installation.

Once installed (or if you're simply running Linux), in each directory run the following command `docker build . -t koinos/MICROSERVICE_NAME` where MICROSERVICE name is the name of the current microservice (i.e. koinos-p2p). The full name of the image is then `koinos/koinos-p2p`.

When all images are built you can run Koinos with docker compose with the command `docker-compose up`.

By default, each container will use `~/.koinos` on the host as their base directory. This can be changed by setting `BASEDIR` in `.env` to a different location on the host machine.

You will find `config.yml` in the base directory, which can be modified to change config on the microservices. At present, you need to restart docker compose for the new config to be applied. (That is a future TODO)
