function install_parmanas {

#variables  
nas_directory=/srv/parmanas
nasuser=parmanasuser

nas_intro_and_choice || return 1

make_parmanas_directories || return 1


#make users
sudo adduser $nasuser

}
