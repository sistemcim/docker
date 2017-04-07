#!/bin/bash
COUNT=$1
for i in $(seq 1 $COUNT)
do
	echo $i
	./run.sh
done

./start_ssh.sh
./get_client_ip.sh

echo ""
echo "Waiting 7 seconds..."
sleep 7
echo "Rebuilding known hosts..."
docker exec ansibleServer /bin/bash -c "/root/.ssh/rebuild_known_hosts.sh"
echo "Done"
