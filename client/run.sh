#!/bin/bash
#docker container ls -f 'ancestor=ansible_client_ubuntu' --format {{.Names}}

CLIENT_IMAGE="ansible_client_ubuntu"
CLIENT_COUNT=$(docker container ls -f "ancestor=$CLIENT_IMAGE"|wc -l)
CONTAINER_NAME="ansible_client$CLIENT_COUNT"

docker run \
	-d \
       --name $CONTAINER_NAME \
 	-v /usr/local/docker/ansible/server/ssh/id_rsa.pub:/root/.ssh/authorized_keys:ro \
       ansible_client_ubuntu 

#docker container ls -f "ancestor=$CLIENT_IMAGE" --format {{.Names}}
#docker cp "../server/server_with_sshkey/ssh/id_rsa.pub" "$CONTAINER_NAME:/root/.ssh/authorized_keys"
