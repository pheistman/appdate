#!/bin/bash 

#This script updates the local system and displays the progress of each step on the screen

#This function checks for available updates from the repo and appends updates to a file

update() {
    echo $'\n'$"Peforming full system update..."
    echo "................................"
    sudo apt update
}

#This function lists the upgradable packages and appends this list to a file, then performs upgrade

listupdate() {
    now=$(date)
    echo $'\n'$"Listing available updates..."
    echo "..............................."
    echo $'\n'$"+++Listing available updates on $now+++" | tee -a ~/bin/newpackages.txt
    sudo apt list --upgradable | tee -a ~/bin/newpackages.txt
    sudo apt -f upgrade
}

#This function cleans up after upgrading the packages and exits the script
cleanup() {
    echo $'\n'$"Cleaning up..."
    echo "................."
    sudo apt autoclean && apt autoremove
    echo ".........................."
    echo $'\n'$"+++ UPDATE COMPLETE +++"
    echo ".........................."
}

#Execute functions
update
listupdate
cleanup

