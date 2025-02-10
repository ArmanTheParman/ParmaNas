# NAS need Samba if Windows clients. Works with Linux
# NFS works on Linux only.


sudo apt-get update  -y

#variables  
nas_directory=/srv/nas
nasuser=$nasuser

#make users
sudo adduser $nasuser


#firewall
