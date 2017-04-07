#!/bin/bash

CLIENT_IMAGE="ansible_client_ubuntu"
echo "-------------------"
echo "All containers list"
#docker container ls -f 'ancestor=ansible_client_ubuntu' --format "{{.ID}} => {{.Names}}"
docker container ls -f "ancestor=$CLIENT_IMAGE" --format "{{.ID}} => {{.Names}}"
echo "-------------------"
echo ""

for i in $(docker container ls -q -f "ancestor=$CLIENT_IMAGE")
do
	echo "Processing $i"
	echo "Starting sshd... "
	docker exec $i /etc/init.d/ssh start
	echo ""
done

echo "Processing done."
echo ""
echo "-------------------"
echo "All containers list"
#docker container ls -f "ancestor=$CLIENT_IMAGE" --format {{.Names}}
docker container ls -f "ancestor=$CLIENT_IMAGE" --format "{{.ID}} => {{.Names}}"
echo "-------------------"
echo ""
