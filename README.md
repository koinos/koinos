# Koinos

The Koinos Blockchain consists of multiple interdependent microservices that communicate via AMQP. Each microserive has been dockerized and can easily be ran as a unit with Docker Compose.

Images are automatically uploaded to [Docker Hub](https://hub.docker.com/u/koinos). `latest` tracks `master` on each microservice repo. Feature branches are uploaded with their branch name as the image tag.

You will need to install Docker on MacOS or Windows first . You can follow their instructions for installation [here](https://www.docker.com/products/docker-desktop).

Once installed (or if you're simply running Linux), run `docker-compose up` to start a Koinos node.

By default, each container will use `~/.koinos` on the host as their base directory. This can be changed by setting `BASEDIR` in `.env`, or exporting `BASEDIR`, to a different location on the host machine.

You will find `config.yml` in the base directory, which can be modified to change config on the microservices. At present, you need to restart docker compose for the new config to be applied. (That is a future TODO)

Different images can be ran by setting environment variables or setting them in `.env`. For each microservice, append `_TAG` (e.g. `export P2P_TAG=64-auto-gossip`).
