
function nas_intro_and_choice {
while true ; do
set_terminal ; echo -e "
########################################################################################$cyan
                                     ParmaNas$orange
########################################################################################


    ParmaNas will enable drive sharing on your network. You have two protocol options.

$cyan      
               1)$orange Samba (Works on Linux/Mac and Windows clients)
$cyan
               2)$orange NFS (Linux/Mac only but faster)
      

   If you anticipate connecting with a Windows computer, then select Samba.

   This software does not support connnecting with both as it can lead to data
   corruption. Please don't try to override this yourself.


########################################################################################
"
choose "xpmq" ; read choice
jump $choice || { invalid ; continue ; } ; set_terminal
case $choice in
q|Q) exit ;; p|P) return ;; m|M) back2main ;;
1)
install=samba
;;
2)
install=nfs
;;
*)
invalid
;;
esac
done

}