function menu_parmanas {
if ! grep -q "parmanas-end" $ic ; then return 0 ; fi
debug 1

while true ; do 
source $pc
debug 2

[[ $nas == nfs ]] && {
    protocol=NFS
    if sudo systemctl status nfs-server ; then
        parmanasrunning="${green}NFS is RUNNING$blue"
    else
        parmanasrunning="${red}NFS is NOT RUNNING$blue"
    fi
}

[[ $nas == samba ]] && {
    protocol=Samba
    if sudo systemctl status nmbd || sudo systemctl status samba ; then
        parmanasrunning="${green}Samba is RUNNING$blue"
    elif ! sudo systemctl status nmbd && ! sudo systemctl status samba ; then
        parmanasrunning="${red}Samba is NOT RUNNING$blue"
    fi
}

debug 3
set_terminal ; echo -e "
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
debug 4
jump $choice || { invalid ; continue ; } ; set_terminal
case $choice in 
q|Q|QUIT|Quit) exit 0 ;;
p|P) menu_use ;; 
m|M) back2main ;;
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
fi
if [[ $nas == nas ]] ; then
    echo ""
    sudo showmount -a
    echo ""
    enter_continue
    return 0
fi


}