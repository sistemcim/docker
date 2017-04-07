#!/bin/bash
CLIENT_IMAGE="ansible_server_ubuntu"

docker container ls -a -f "ancestor=$CLIENT_IMAGE" --format "{{.ID}} => {{.Names}}"
echo "-------------------"
echo ""

for i in $(docker container ls -a -q -f "ancestor=$CLIENT_IMAGE")
do
	echo "Processing $i"
	echo "Stopping... "
	docker stop $i
	echo "Removing..."
	docker rm $i
	echo ""
done

echo ""
docker container ls -a -f "ancestor=$CLIENT_IMAGE" --format "{{.ID}} => {{.Names}}"
echo "-------------------"
