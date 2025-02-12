
function nas_intro_and_choice {
while true ; do
set_terminal ; echo -e "$blue
########################################################################################$orange
                                     ParmaNas$blue
########################################################################################


    ParmaNas will enable drive sharing on your network. You have two protocol options.

$orange
               1)$blue   Samba (Works on Linux/Mac and all Windows clients)
$orange
               2)$blue   NFS (Linux/Mac but faster, can work on some Windows)
      

   If you anticipate connecting with a Windows computer, then select Samba. Samba is
   optimised for Windows, so it's better to choose that, even if NFS might work
   on your Windows machine. Ideally, discard all Windows computers - just get Bill
   Gates out of your life.

   This software does not support connnecting with both Samba and NFS as doing that 
   can lead to data corruption. Please don't try to override this yourself.


########################################################################################
"
choose "xpmq" ; read choice
jump $choice || { invalid ; continue ; } ; set_terminal
case $choice in
q|Q) exit ;; p|P) return ;; m|M) back2main ;;
1)
install=samba
break
;;
2)
install=nfs
break
;;
*)
invalid
;;
esac
done

}