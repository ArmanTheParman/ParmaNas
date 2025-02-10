#install dependendcies
sudo apt-get install -y nfs-kernel-server

sudo systemctl enable --now nfs-server

# Set up /etc/exports

 /srv/nas $allowed_IP(rw,sync,no_subtree_check,all_squash,anonuid=$uid,anongid=$gid)
# or
/srv/nas $allowed_IP(ro,sync,no_subtree_check)

# apply changes to table.
sudo exportfs -arv
sudo systemctl restart nfs-kernel-server