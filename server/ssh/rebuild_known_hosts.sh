rm -f /root/.ssh/known_hosts
for i in $(cat /etc/ansible/hosts|grep 172*|sort -u)
do 
	ssh-keyscan $i >> /root/.ssh/known_hosts
done

echo ""
echo "Testing ansible ping..."
ansible all -m ping
