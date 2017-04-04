#!/bin/bash

CLIENT_IMAGE="ansible_client_ubuntu"
HOSTS_FILE="/usr/local/docker/ansible/server/ansible/hosts"

rm -f $HOSTS_FILE

docker-compose up -d
docker-compose scale client=3

echo ""
echo "--------------------------------------------------------------------"
echo "Listing client containers..."
echo "--------------------------------------------------------------------"
for i in $(docker container ls -q -f "ancestor=$CLIENT_IMAGE")
do
	CONTAINER_NAME=$(docker inspect $i -f \{\{.Name\}\}|sed -e 's/\///g')
	CONTAINER_IP=$(docker inspect $i -f {{.NetworkSettings.Networks.compose_default.IPAddress}})
        
	echo "$CONTAINER_IP" >> $HOSTS_FILE
	echo "$i => $CONTAINER_NAME => $CONTAINER_IP"
done
#docker container ls -f "ancestor=$CLIENT_IMAGE" --format "{{.ID}} => {{.Names}}"
echo ""

echo "--------------------------------------------------------------------"
echo "Starting ssh services in clients"
echo "--------------------------------------------------------------------"
#for i in $(docker container ls -q -f "name=compose_client*")
for i in $(docker container ls -q -f "ancestor=$CLIENT_IMAGE")
do
	echo "Processing $i"
	echo "Starting sshd... "
	docker exec $i /etc/init.d/ssh start
	echo ""
done

echo ""
echo "--------------------------------------------------------------------"
echo "Rebuilding known_hosts file of the server..."
echo "--------------------------------------------------------------------"

docker exec ansible_server /bin/bash -c "/root/.ssh/rebuild_known_hosts.sh"

echo ""
echo "Rebuilding done..."

echo ""
echo "Processing done..."
echo ""
