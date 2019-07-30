#!/bin/bash 

#This script updates the local system and displays the progress of each step on the screen

#This function checks for available updates from the repo 
anyupdate="" #initializing variable that stores the result of repo check
update() {
    echo $'\n'$"Peforming full system upgrade..."
    echo "................................"
#Perform update and if there are no new packages, set anyupdate variable to 1
    sudo apt update | grep "All packages are up-to-date." &> /dev/null
	if [ $? == 0 ]; then 
	   anyupdate=1 
	fi
}

#This function checks if appdate.log file exists else create it in the user's home directory
checklog() {
    if [ ! -f ~/appdate.log ]; then
	echo $'\n'$"+++ Packages available for update +++ 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^" \
	> ~/appdate.log
    fi
}

#This function lists the upgradable packages and appends this list to a file, then performs upgrade
listupdate() {
    now=$(date)
    echo $'\n'$"Listing available updates..."
    echo "..............................."
    echo $'\n'$"+++Latest updates available on $now+++" | tee -a ~/appdate.log
    sudo apt list --upgradable | tee -a ~/appdate.log
    sudo apt -f upgrade
}

#This function cleans up after upgrading the packages and exits the script
cleanup() {
    echo $'\n'$"Cleaning up..."
    echo "................."
    sudo apt autoclean #; sudo apt autoremove
    echo ".........................."
    echo $'\n'$"+++ UPDATE COMPLETE +++"
    echo ".........................."
}

#Execute functions if there are new packages available for update else exit
	update #run update function and perform upgrade only if new packages available else exit
    if [[ $anyupdate == "1" ]]; then 
       echo "No new updates available, exiting..."
    else
	checklog
	listupdate
	cleanup
    fi

