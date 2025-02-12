function install_samba {

sudo apt-get update  -y

sudo apt-get install -y samba
#Windows 10/11 relies on WS-Discovery instead of NetBIOS for network browsing. Install wsdd.
sudo apt-get install -y wsdd2


#enable services
sudo systemctl enable --now wsdd2
sudo systemctl enable --now smbd nmbd

#edit samba file & restart smbd

echo "
[parmanas]
   path = $nas_directory
   valid users = $nasuser
   read only = no
   browsable = yes
   guest ok = no
   create mask = 0750
   directory mask = 0750
" | sudo tee -a /etc/samba/smb.conf >$dn 2>&1

sudo systemctl restart smbd

#add Samba login password
announce "You will next be asked to set a password for 'nasuser', needed for
    secure access to your drive."
sudo smbpasswd -a $nasuser

#to list Samba users
#sudo pdbedit -L
}