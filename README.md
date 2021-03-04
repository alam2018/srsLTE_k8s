# srsLTE_k8s
This repository creats and starts srsLTE EPC on a docker container. All the EPC GW are running on the same container.

#Build docker image to local repository
Docker build: ./installation.sh

Docker command:
sudo docker images
sudo docker run -it --entrypoint /bin/bash image_id
sudo docker run -it --privileged image_id bash
docker exec -it <mycontainer> bash

