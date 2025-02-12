#must make a directory that will convert to a nas drive - It wont just appear IN a directory,
#instead the directory that exists changes.
#Type on windows file explorer...
\\<Samba-Server-IP>\share
#or right click MyComputer, map network drive, enter credentials.


#NFS
    #mkdir ~/desktop/nas
    #resvport selects a port lowever than 1024, an admin port; needed if no secure/insecure 
    #setting in export file. Default is secure.
    sudo mount -t nfs -o resvport,rw 192.168.0.134:/srv/nas ~/Desktop/nas >/dev/null 2>&1
    # example fstab entry, mac or linux
    192.168.3.1:/nas /mountpoint nfs rw,nolockd,resvport,hard,bg,intr,rw,tcp,rsize=65536,wsize=65536

#Samba
    mount_smbfs //nasuser@192.168.0.134/nas ~/Desktop/nas


