# MY LITTLE ANSIBLE PLANET
This place is my ansible playground.I prepared scripts inside folders to automatically prepare my ansible testing environment. As seen, there are two folders: "server" and "client".

It is simple, server is used to run ansible management server and client is used to run ansible managed hosts.
Both server and clients are based on Ubuntu image.

### SERVER:

To run server, you must create server image first by using Dockerfile. It updates base image, installs ansible and utilities such as *iputils-ping*, *ssh-client* and *vim*. I need these utilities to work and debug.
There are two folders that map to ansible server:

* "ansible". This folder keeps */etc/ansible* configurations such as *hosts* and *ansible.cfg*. I also put my works under this folder to be able to use them later.

* "ssh". This folder is mapped to */root/.ssh* folder. When server started, ssh keys are created or overwritten inside this folder. I'll explain why is this map needed later.

In order to connect to client with passwordless login, a key with no passphrase is created on the server automatically. "ansible_server_first_run_script.sh" is used in this part. 
For passwordless login, you may google or "https://www.cyberciti.biz/faq/how-to-set-up-ssh-keys-on-linux-unix/" is a sample.
The tricky part here is, id_rsa.pub file under ssh folder is also mapped to the client as read-only and name changing "authorized_keys". That means, if server is started, ssh key is created for root, and if client is started after this time, client automatically has server ssh key in its /root/.ssh/authorized_keys file. Nothing else is needed to do for passwordless login.


