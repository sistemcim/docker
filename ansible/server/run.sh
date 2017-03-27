docker run \
	-it \
	--rm \
	--name ansibleServer \
	-v /usr/local/docker/ansible/server/ansible:/etc/ansible \
	-v /usr/local/docker/ansible/server/ssh:/root/.ssh \
	ansible_server_ubuntu_with_sshkey 

#docker exec ansibleServer /root/.ssh/rebuild_known_hosts.sh
