function menu_parmanas {
if ! grep -q "parmanas-end" $ic ; then return 0 ; fi
while true ; do 
source $pc
[[ $nas == nfs ]] && {
sudo systemctl status nfs-server &&
}


set_terminal ; echo -e "
########################################################################################$cyan
                                   ParmaNas Menu            $orange                   
########################################################################################
$parmanasrunning
$cyan
   


########################################################################################
"
choose "xpmq" ; read choice
jump $choice || { invalid ; continue ; } ; set_terminal
case $choice in 
q|Q|QUIT|Quit) exit 0 ;;
p|P) menu_use ;; 
m|M) back2main ;;

start|Start|START|S|s)
check_SSH || return 0
please_wait ; echo "" ; echo "A BitBox App window should open soon."
run_bitbox
return 0 ;;

*)
invalid
;;

esac
done
} 