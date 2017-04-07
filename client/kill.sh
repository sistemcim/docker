#!/bin/bash
CLIENT_IMAGE="ansible_client_ubuntu"

echo "All containers list"
echo "-------------------"
#docker container ls -f 'ancestor=ansible_client_ubuntu' --format "{{.ID}} => {{.Names}}"
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

echo "Processing done."
echo ""
echo "-------------------"
echo "All containers list"
#docker container ls -f "ancestor=$CLIENT_IMAGE" --format {{.Names}}
docker container ls -a -f "ancestor=$CLIENT_IMAGE" --format "{{.ID}} => {{.Names}}"
echo "-------------------"
echo ""
