#!/bin/bash

#Student Name: Shiyu Wang

#This script outputs all subdirectories of the current working directory, also provide users with an option to make archive of each subdirectory.


if [ -z "$(ls -d */)" ]; then #error checking for if any subdirectory exists in current working directory
        echo "Error: No directories in current working directory. "
else

        
	dir=`ls -d1v */ | tr "/" " "` #store a list of subdirectories in dir

        counter=0 
        for d in $dir; do #use for loop to loop over the list of subdirectories and print the number and subdirectories

        	counter=$((counter+1))
		
		echo "$counter) $d"

        done

	
        read -p "Backup which directory? (0 to exit): " directory #read input from user for which subdirectory to make archive of


	while [ "$director" != " " ] ; do #as long as there is input 
		
	        test $directory -eq 0 2>/dev/null #to check if the input is integer, redirect the standard error to /dev/null so it doesn't show

        	if [ $? -eq 2 ]; then #to check is the input is integer, the following contains error checkings as well
                	echo "Error: not a valid directory number."		
		
		elif [ $directory -lt 0 ]; then 
			echo "Error: not a valid directory number."

		elif [ $directory -gt $counter ]; then 
			echo "Error: not a valid directory number."
		elif [ $directory -eq 0 ]; then
			echo "Good bye."
			exit 0
		else
			anotherCounter=0
			day=`date +%d` #use date command to generate the day, month and year separately
			month=`date +%m`
			year=`date +%Y`
			for d in $dir; do #use for loop to loop over subdirectories, once the counter matches the input number, use tar to make a tar file
				anotherCounter=$((anotherCounter+1))
				if [ $directory -eq $anotherCounter ]; then
					tar -cvf "$d-backup-$day-$month-$year.tgz" $d 1>/dev/null
					echo "Created backup file $d-backup-$day-$month-$year.tgz"
				fi
	
			done	
		fi	
	
		read -p "Backup which directory? (0 to exit): " directory

	
	done

	

fi

