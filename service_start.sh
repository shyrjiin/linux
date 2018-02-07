while true; do

cmd=$(ps -elf | awk -F ' ' '{print $15}' | sort | uniq | grep ssh)
string="ssh"

if [[ "$cmd" =~ [$string] ]];

then

echo "SSH is started"

else systemctl start ssh

echo "SSH not started so I am starting it"

fi
sleep 60
done

