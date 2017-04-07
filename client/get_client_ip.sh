IMAGE_NAME="ansible_client_ubuntu"
HOSTS_FILE="/usr/local/docker/ansible/server/ansible/hosts"

rm -f $HOSTS_FILE


for i in `docker container ls -q -f "ancestor=$IMAGE_NAME"`
do 
	CONTAINER_NAME=$(docker inspect $i -f \{\{.Name\}\}|sed -e 's/\///g')
	CONTAINER_IP=$(docker inspect $i -f \{\{.NetworkSettings.IPAddress\}\})

	echo "$CONTAINER_IP" >> $HOSTS_FILE
	echo "$i => $CONTAINER_NAME => $CONTAINER_IP"
done

