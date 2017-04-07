After reading below but before taking an action, check compose folder ;)

## MY LITTLE ANSIBLE PLANET
This place is my ansible playground.I prepared scripts inside folders to automatically prepare my ansible testing environment. As seen, there are folders: "server" and "client".

It is simple, server is used to run ansible management server and client for managed hosts.
Both server and clients are based on Ubuntu image.

### SERVER:

To run server, you must create server image first by using "Dockerfile". Use "ansible_server_ubuntu" as servername to be compatible with samples or you may change it accordingly. Dockerfile updates base image, installs ansible and utilities such as *iputils-ping*, *ssh-client* and *vim*. I need these utilities to work and debug.
There are two folders that map to ansible server:

* `ansible`. This folder keeps */etc/ansible* configurations such as *hosts* and *ansible.cfg*. I also put my works under this folder to be able to use them later.

* `ssh`. This folder is mapped to */root/.ssh* folder. When server started, ssh keys are created or overwritten inside this folder. I'll explain later why this map is needed.

In order to connect to client with passwordless login, a key with no passphrase is created on the server automatically. `ansible_server_first_run_script.sh` is used in this part. If id_rsa files exists in the directory, user is prompted to accept overwrite. To eliminate interaction need, script first removes previous files.

For passwordless login, you may google or look at this "https://www.cyberciti.biz/faq/how-to-set-up-ssh-keys-on-linux-unix/" for example.

The tricky part here is, `id_rsa.pub` file under ssh folder is also **mapped to the client as read-only and name changing `authorized_keys`**. That means, if server is started, ssh key is created for root, and if client is started after this time, client automatically has server public ssh key in its /root/.ssh/authorized_keys file. Nothing else is needed for passwordless login.

There is one more file under ssh directory: `rebuild_known_hosts.sh`. This script is run with `docker exec` after clients are run. You may find it in client/newClient.sh. It scans client keys and add them to server's /root/.ssh/known_hosts file to prevent prompt on first ssh connection. Another way of preventing ssh client check message is modifying host_key_checking option in ansible. Details are here : http://docs.ansible.com/ansible/intro_getting_started.html#host-key-checking

### CLIENT
Ansible client has nothing different from ubuntu docker image exept `ssh-server` and `python`. client/Dockerfile updates base image and installs these two packages. I used client image name as "ansible_client_ubuntu"
As you see, there are several script files under client directory. Let's see what they are:
- `run.sh`: Runs an ansible client container in daemon mode.
- `start_ssh.sh`: Starts sshd service on all clients run from base image "ansible_client_ubuntu".
- `get_client_ip.sh`: Lists name and ip addresses of clients run from "ansible_client_ubuntu". In addition, it rebuilds /etc/ansible/hosts file according to client IP addresses.
- `newClient.sh` : Gets a parameter, *count* of the client, and runs run.sh `count` times. Then `start_ssh.sh` and `get_client_ip.sh` At the end, rebuilds known_hosts file of the server.
- `kill.sh`: Stops and removes all containers run from "ansible_client_ubuntu".

To sum up:

1. Go to server directory and run `run.sh`.
2. Go to client directory and run `newClient.sh 3`
3. Run `docker exec -it ansibleServer /bin/bash`
4. Begin using ansible like `ansible all -m ping`
 
That is all folks to have a sample ansible environment :) Of course things can be more automated or manual. You may change them according to your comfort.

Good days...
