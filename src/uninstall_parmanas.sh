function uninstall_pamanas {
while true ; do
set_terminal ; echo -e "$blue
########################################################################################
$orange
                                 Uninstall ParmaNas

$green
    The data directory will not be deleted.                                 

$blue
    Are you sure? (y) (n)

########################################################################################
"
choose "xpmq" ; read choice
jump $choice || { invalid ; continue ; } ; set_terminal
case $choice in
q|Q) exit ;; p|P) return 1 ;; m|M) backtomain ;;
y) break ;;
n) return 1 ;;
*) invalid ;;
esac
done
set_terminal

source $pc
[[ $nas == samba ]] && {
sudo systemctl stop samba.service nmbd.service >$dn 2>&1
sudo systemctl disable samba.service nmbd.service >$dn 2>&1
sudo rm /etc/samba/smb.conf >$dn 2>&1
sudo apt-get purge samba -y
sudo apt-get autoremove --purge -y
}

[[ $nas == nfs ]] && {
sudo systemctl stop nfs* >$dn 2>&1
sudo systemctl disable nfs-server >$dn 2>&1
sudo apt-get purge nfs-kernel-server -y 
sudo apt-get autoremove --purge -y
sudo rm -f /etc/exports >$dn 2>&1
}

parmanode_conf_remove "nas="
installed_conf_remove "parmanas-"
success "${blue}Parmanas has been uninstalled$orange"
}