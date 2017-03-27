FROM ubuntu

RUN 	apt-get -y update && apt-get -y upgrade && \
###	Install Ansible
#	apt-get -y install python-software-properties && \
	apt-get -y install software-properties-common && \
	apt-add-repository ppa:ansible/ansible && \
	apt-get -y install ansible && \
###	Install Utilities
	apt-get -y install iputils-ping ssh-client vim

COPY 	ansible_server_first_run_script.sh /
ENTRYPOINT /ansible_server_first_run_script.sh

