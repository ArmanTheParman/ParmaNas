function menu_parmanas {
while true ; do 
unset nas parmanasrunning installpnas
source $pc
debug "nas = $nas"

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
$orange
                        c)$blue                 How to connect
$orange
                        sript)$blue             Make a connection/disconnection script
$orange
                        uninstall)$blue         Uninstall ParmaNas

$blue
########################################################################################
"
choose "xpmq" ; read choice
jump $choice || { invalid ; continue ; } ; set_terminal
case $choice in 
q|Q|QUIT|Quit) exit 0 ;;
p|P) menu_use ;; 
m|M) back2main ;;
debugon) export debug=1 ;;
debugoff) unset debug ;;
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
c)
how_to_connect_parmanas
;;
script)
make_connection_script
;;
uninstall)
uninstall_parmanas
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
    echo -e "Status Output for SAMBA\n"
    sudo smbstatus
    enter_continue
    return 0
elif [[ $nas == nfs ]] ; then
    echo -e "Status Output for NFS\n"
    sudo ss -tnp | grep :2049 | head -n100 #head removes colour
    echo ""
    enter_continue
    return 0
else
    enter_continue
    return 1
fi


}

function how_to_connect_parmanas {

if [[ $nas == samba ]] ; then
set_terminal ; echo -e "$blue
########################################################################################$orange 
             Connecting to a NAS drive with SAMBA protocol $green(WINDOWS)$blue
########################################################################################

    Type on windows file explorer...
$green
        \\\\\\$IP\\parmanas
$blue
    or right click MyComputer, map network drive, and enter credentials (parmanasuser
    and the password).
########################################################################################
"
enter_continue

set_terminal ; echo -e "$blue
########################################################################################$orange 
             Connecting to a NAS drive with SAMBA protocol $green(MAC & FreeBSD)$blue
########################################################################################

    Create a directory on the client computer to mount to, eg ~/Desktop/nas
    
    Run this command, or put it in a script:
$green
        mount_smbfs //parmanasuser@$IP/parmanas ~/Desktop/nas
$blue
########################################################################################
"
enter_continue

set_terminal ; echo -e "$blue
########################################################################################$orange 
             Connecting to a NAS drive with SAMBA protocol $green(Linux/Mac)$blue
########################################################################################

    You need to make sure cifs-utils is insalled. For Debian based systems, do...
$green
    sudo apt-get install cifs-utils -y
$blue
    The mount command is:
$green
    sudo mount -t cifs -o username=parmanasuser //$IP/parmanas ~/Desktop/nas
$blue
    Make sure you have created a$orange ~/Desktop/nas$blue directory to mount to.

    When done, you can unmount:
    
       $green sudo umount ~/Desktop/nas
       $blue If it says 'busy', add -f:
       $green sudo umount -f ~/Desktop/nas
$blue
########################################################################################
"
enter_continue
return 0
fi

if [[ $nas == nfs ]] ; then
set_terminal "38" "140" ; echo -e "$blue
############################################################################################################################################$orange
                               Connecting to a NAS drive with NFS protocol using a Linux/Mac Client$blue
############################################################################################################################################$orange

    Make a target directory on the client computer, eg:
$green
             mkdir ~/desktop/nas
$blue
    Then run this command (a script will streamline it): 
$green
             sudo mount -t nfs -o resvport,rw $IP:/srv/parmanas ~/Desktop/nas 
$blue
    Note, that resvport selects a port lowever than 1024, an admin port which is needed if the nosecure setting is ommitted in the 
    ParmaNas's /etc/exports file (it is ommitted).

    You could mess around with the fstab file for auto mountint, but be careful, and make a back up of it first. 
$green
             $IP:/srv/parmanas /home/username/Desktop/nas nfs rw,nolockd,resvport,hard,bg,intr,rw,tcp,rsize=65536,wsize=65536
$blue
    Maybe better not to do that, leave it for Parman to help you with it. Or instead, learn about Linux scripts and just make one with the 
    earlier command so you don't have to type it out each time your computer reboots.

    When done, you can unmount:
    
       $green sudo umount ~/Desktop/nas
       $blue If it says 'busy', add -f:
       $green sudo umount -f ~/Desktop/nas
$blue
############################################################################################################################################
"
enter_continue
return 0
fi
}

function make_connection_script {

set_terminal ; echo -e "$blue
########################################################################################

    Help to create a double-clickable script on your$green client computer$blue to connect
    to this nas.

    For Windoze, you don't need a script, just map the drive. Right-click My Computer,
    and select the Map option. You need to put the parmanasuser as the user, and
    the password for the user.
    
    For Linux/Mac, create a text file, name it what you want but for Mac, it's best 
    to use the extension, ".command", and for Linux, ".sh".

    Edit it and on the first line put:
$orange
    #!/bin/bash
$blue
    Then on the next line add the details needed to connect (see connection help menu)

    Save and close the file, then make it executable:
$orange
    sudo chmod +x /path/to/file
$blue
    Now if you double click it the drive should mount.

    If you want, you can make one to unmount as well. Start with #!/bin/bash, then
    add the unmount command, save, and make it executable.

########################################################################################
"
enter_continue
}

