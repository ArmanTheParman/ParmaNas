function start_parmanas {
source $pc

[[ $nas == nfs ]] && {
please_wait
sleep 0.25
sudo systemctl start nfs-server
return 0
}

[[ $nas == samba ]] && {
please_wait
sleep 0.25
sudo systemctl start nmbd samba
return 0
}

}
function stop_parmanas {
source $pc

[[ $nas == nfs ]] && {
please_wait
sleep 0.25
sudo systemctl stop nfs-server
return 0
}

[[ $nas == samba ]] && {
please_wait
sleep 0.25
sudo systemctl stop nmbd samba
return 0
}

}

function restart_parmanas {
source $pc

[[ $nas == nfs ]] && {
please_wait
sleep 0.25
sudo systemctl restart nfs-server
return 0
}

[[ $nas == samba ]] && {
please_wait
sleep 0.25
sudo systemctl restart nmbd samba
return 0
}

}