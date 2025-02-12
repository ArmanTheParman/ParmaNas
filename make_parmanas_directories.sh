function make_parmanas_directories {

while true ; do
set_terminal ; echo -e "
########################################################################################$cyan
                                Directory Choice$orange
########################################################################################


    ParmaNas will create a directory on your system:$cyan /srv/parmanas$orange if it
    doesn't exist.
    
    You can put your files here, or, you can mount a drive to this location, which
    will temporarily hide the contents of the original directory, and replace it with
    the contents of the mounted drive.

    The ownership of the target directory is the$green $nasuser$orange user.

    This program will set it up for you, but if you're going to tinker and mount
    a drive there, you need to change the ownership of the drive like this, after
    mounting...
$cyan
       sudo chown -R $nasuser:$nasuser /srv/parmanas 
    
    Then it should work. If you have issues mounting, make sure you use$cyan sudo$orange and
    make sure no clients are connected to the drive.

    You can get really fancy if you want and replace the target directory with a 
    symlink to wherever you want, but expect issues unless you are experience.
    Getting the ownership right using symlinks can be tricky.
   
########################################################################################
"
enter_continue ; jump $choice 

sudo test -e /srv/parmanas 2>$dn || sudo mkdir /srv/parmanas >$dn 2>&1
sudo chown -R $nasuser:$nasuser /srv/parmanas
}