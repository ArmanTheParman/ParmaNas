function install_nfs {
#install dependendcies
sudo apt-get update  -y
sudo apt-get install -y nfs-kernel-server
sudo systemctl enable --now nfs-server

while true ; do
set_terminal ; echo -e "$blue
########################################################################################

    Would you like any device from anywhere to be able to connect to your NAS so
    long as they have the correct password? This is less secure than allowing only
    devices in your home network.
$orange
               all)$blue    Allow computers from anywhere
$orange            
                nn)$blue    Disallow all computers not in my home nework

########################################################################################
"
choose xq ; read choice
case $choice in
q|Q) exit ;; p|P) return 1 ;;
all) allowed_IP='*' ; break ;;
nn) unset allowed_IP ; break ;;
*) invalid ;;
esac
done

if [[ -z $allowed_IP ]] ; then

while true ; do
set_terminal ; echo -e "$blue
########################################################################################
        
    Would you like to allow all devices in your home network to try to connect with
    a password, or restrict to just one IP address of your choice?

$orange
               all)$blue    Allow computers from$pink the home nework
$orange            
               one)$blue    Manually enter one IP address of your choice

########################################################################################
"
choose xq ; read choice
case $choice in
q|Q) exit ;; p|P) return 1 ;;
all) 
IP_1=$(echo "$IP" | cut -d \. -f 1)
IP_2=$(echo "$IP" | cut -d \. -f 2)
IP_3=$(echo "$IP" | cut -d \. -f 3)
allowed_IP="$IP_1.$IP_2.$IP_3.0/24"
break
;;
one) 
    clear 
    echo -e "${blue}Please enter the IP address you want, then hit $orange<enter>$blue\n"
    read allowed_IP 
    yesorno "Go ahead with this IP address? $allowed_IP" || continue
    export allowed_IP
    break
    ;;
*) invalid ;;
esac
done
fi


# Set up /etc/exports
echo "
#ADDED BY PARMANAS:START

#If changing anything, run:
#    sudo exportfs -arv
#    sudo systemctl restart nfs-kernel-server

$nas_directory $allowed_IP(rw,sync,no_subtree_check,all_squash,anonuid=$(id -u $nasuser),anongid=$(id -g $nasuser))

#alternative is to use read only like this.
#    $nas_directory $allowed_IP(ro,sync,no_subtree_check)

#ADDED BY PARMANAS:END" | sudo tee -a /etc/exports >$dn 2>&1

# apply changes to table.
sudo exportfs -arv
sudo systemctl restart nfs-kernel-server
return 0
}