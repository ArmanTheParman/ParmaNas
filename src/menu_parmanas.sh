function menu_parmanas {
while true ; do 
unset nas parmanasrunning installpnas
source $pc

[[ $nas == nfs ]] && {
    protocol=NFS
    if sudo systemctl status nfs-server >$dn 2>&1; then
        parmanasrunning="${green}NFS is RUNNING$blue"
    else
        parmanasrunning="${red}NFS is NOT RUNNING$blue"
    fi
}

[[ $nas == samba ]] && {
    protocol=Samba
    if sudo systemctl status nmbd >$dn 2>&1 || sudo systemctl status samba ; then
        parmanasrunning="${green}Samba is RUNNING$blue"
    elif ! sudo systemctl status nmbd && ! sudo systemctl status samba ; then
        parmanasrunning="${red}Samba is NOT RUNNING$blue"
    fi
}

[[ -z $nas ]] && parmanasrunning="${red}NOT INSTALLED
$orange

                        i)$blue                 Install ParmaNas" && installpnas=allowed


set_terminal ; echo -e "$blue
########################################################################################$orange
                                   ParmaNas Menu            $blue
########################################################################################

    $parmanasrunning
$orange
                        so)$blue                Status output
$orange
                        s)$blue                 Start $protcol
$orange
                        stop)$blue              Stop $protocol
$orange
                        r)$blue                 Restart $protocol


$red
NOTE: stopping the service may not disconnect existing connections$blue
########################################################################################
"
choose "xpmq" ; read choice
jump $choice || { invalid ; continue ; } ; set_terminal
case $choice in 
q|Q|QUIT|Quit) exit 0 ;;
p|P) menu_use ;; 
m|M) back2main ;;
i)
[[ -z $installpnas ]] && continue
install_parmanas
;;
so)
status_output_parmanas
;;
start|s)
start_parmanas
;;
stop)
stop_parmanas
;;
r)
restart_parmanas
;;
*)
invalid
;;
esac
done
} 

function status_output_parmanas {
sudo true
clear

if [[ $nas == samba ]] ; then
    sudo smbstatus
    enter_continue
    return 0
elif [[ $nas == nas ]] ; then
    echo ""
    sudo showmount -a
    echo ""
    enter_continue
    return 0
else
    enter_continue
    return 1
fi


}