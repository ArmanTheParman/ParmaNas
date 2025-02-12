function check_parmanode_version_3_54.0_plus {

while true ; do

#future version 4 or more
if [[ $(head -n2 $HOME/parman_programs/parmanode/version.conf | tail -n1 | cut -d = -f 2) -gt 3 ]] ; then
break
fi

#version 3
#major
if [[ $(head -n2 $HOME/parman_programs/parmanode/version.conf | tail -n1 | cut -d = -f 2) -lt 3 ]] ; then
clear
echo -e "\n\n    This version of Parmanode is out of date. You need version 3.50.2 at least"
return 1
fi
#minor
if [[ $(head -n3 $HOME/parman_programs/parmanode/version.conf | tail -n1 | cut -d = -f 2) -lt 50 ]] ; then
clear
echo -e "\n\n    This version of Parmanode is out of date. You need version 3.50.2 at least"
return
fi

#patch
if [[ $(head -n3 $HOME/parman_programs/parmanode/version.conf | tail -n1 | cut -d = -f 2) = 50 ]] && \
   [[ $(head -n4 $HOME/parman_programs/parmanode/version.conf | tail -n1 | cut -d = -f 2) -lt 2 ]] ; then
clear
echo -e "\n\n    This version of Parmanode is out of date. You need version 3.50.2 at least"
return 1
fi

break
done
return 0
}
~    