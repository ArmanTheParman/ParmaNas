#!/usr/bin/env bash
if [[ $(uname) == Darwin ]] && [[ $1 != d ]] ; then clear ; echo "Sorry, this doesn't work on Macs yet." ; exit ; fi

if echo $@ | grep -q debug || [[ $1 == d ]] ; then
debug=1
echo "Debug mode"
sleep 0.2
fi

if [ -e "$HOME/parman_programs/parmanode/src" ]; then

    source $HOME/parman_programs/parmanode/src/config/parmanode_variables.sh    

    for file in "$HOME/parman_programs/parmanode/src"/*/*.sh; do
        [ -f "$file" ] && source "$file"
    done

    if [[ $debug == 1 ]] ; then echo pause ; read ; fi

else
    clear
    echo -en "\n\n    Please install Parmanode first. \n\n"
    exit
fi

for file in $HOME/parman_programs/parmanas/src/*.sh ; do
    source "$file"
done
check_parmanode_version_3_54_0_plus || exit

export premium=1
do_loop $@ 
clear
menu_parmanas
exit
