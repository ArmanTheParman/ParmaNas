sudo adduser nasuser

sudo apt-get update  -y
sudo apt-get install -y nfs-kernel-server
sudo apt-get install -y samba
sudo apt-get install -y wsdd


sudo systemctl enable --now wsdd
sudo systemctl enable --now smbd nmbd
sudo systemctl enable --now nfs-server
