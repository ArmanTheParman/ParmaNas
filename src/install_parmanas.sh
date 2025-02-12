function install_parmanas {

#variables  
nas_directory=/srv/parmanas
nasuser=parmanasuser

nas_intro_and_choice || return 1

#make users
sudo adduser $nasuser

make_parmanas_directories || return 1
installed_conf_add "nas-start"

if [[ $install == "samba" ]] ; then 
    install_samba
    parmanode_conf_add "nas=samba"
else 
    install_nfs
    parmanode_conf_add "nas=nfs"
fi


}
