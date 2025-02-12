
sudo apt-get update  -y

#variables  
nas_directory=/srv/nas
nasuser=$nasuser

#make users
sudo adduser $nasuser

#install dependencies
sudo apt-get install -y samba
#Windows 10/11 relies on WS-Discovery instead of NetBIOS for network browsing. Install wsdd.
sudo apt-get install -y wsdd2


#enable services
sudo systemctl enable --now wsdd2
sudo systemctl enable --now smbd nmbd

#edit samba file & restart smbd

echo "
[NAS]
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
sudo smbpasswd -a nas

#to list Samba users
sudo pdbedit -L