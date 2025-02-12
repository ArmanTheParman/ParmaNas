function install_parmanas {
if [[ $OS == "Mac" ]] ; then nomac ; return 1 ; fi

#variables  
nas_directory=/srv/parmanas
nasuser=parmanasuser

nas_intro_and_choice || return 1

#make users
announce "${blue}You will be asked to enter a new password for the user $nasuser"
sudo adduser --no-create-home --gecos "" $nasuser

make_parmanas_directories || return 1
installed_conf_add "parmanas-start"

if [[ $install == "samba" ]] ; then 
    install_samba
    parmanode_conf_add "nas=samba"
else 
    install_nfs
    parmanode_conf_add "nas=nfs"
fi

installed_conf_add "parmanas-end"
success "ParmaNas has been installed"
}
