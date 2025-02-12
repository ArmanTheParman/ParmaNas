function menu_parmanas {
if ! grep -q "parmanas-end" $ic ; then return 0 ; fi
while true ; do 
source $pc

[[ $nas == nfs ]] && {
    protocol=NFS
    if sudo systemctl status nfs-server ; then
        parmanasrunning="${green}NFS is RUNNING$orange"
    else
        parmanasrunning="${red}NFS is NOT RUNNING$orange"
    fi
}

if [[ $nas == samba ]] && {
    protocol=Samba
    if sudo systemctl status nmbd || sudo systemctl status samba ; then
        parmanasrunning="${green}Samba is RUNNING$orange"
    elif ! sudo systemctl status nmbd && ! sudo systemctl status samba ; then
        parmanasrunning="${red}Samba is NOT RUNNING$orange"
    fi
}


set_terminal ; echo -e "
########################################################################################$cyan
                                   ParmaNas Menu            $orange                   
########################################################################################

    $parmanasrunning
$cyan
                        s)               Start $protcol
$cyan
                        stop)            Stop $protocol
$cyan
                        r)               Restart $protocol



NOTE: stopping the service may not disconnect existing connections
########################################################################################
"
choose "xpmq" ; read choice
jump $choice || { invalid ; continue ; } ; set_terminal
case $choice in 
q|Q|QUIT|Quit) exit 0 ;;
p|P) menu_use ;; 
m|M) back2main ;;
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