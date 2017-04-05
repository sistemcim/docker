docker run \
	-d \
	--name ansibleServer \
	-v /usr/local/docker/ansible/server/ansible:/etc/ansible \
	-v /usr/local/docker/ansible/server/ssh:/root/.ssh \
        ansible_server_ubuntu
#docker exec ansibleServer /root/.ssh/rebuild_known_hosts.sh
