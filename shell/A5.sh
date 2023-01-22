#!/bin/sh
MainMenu()
{
	while [ true ]
	do
		clear
		echo "===================================================="
		echo "|              Oracle All Inclusive Tool           |"
		echo "|      Main Menu - Select Desired Operations(s):   |"
		echo "| <CTRL-Z Anytime to Enter Interactive CMD Prompt> |"
		echo "----------------------------------------------------"

		echo "0) View Tables"
		echo "1) Drop Tables"
		echo "2) Create Tables"
		echo "3) Populate Tables"
		echo "4) Query Tables"
		echo "E) End/Exit"
		echo "Choose: "

		read CHOICE

		if [ $CHOICE = "0" ]
		then 
			bash view_table.sh
			read temp

		elif [ $CHOICE = "1" ]
		then
			bash drop_tables.sh
			read temp

		elif [ $CHOICE = "2" ]
		then 
			bash create_tables.sh
			read temp

		elif [ $CHOICE = "3" ]
		then 
			bash populate_tables.sh
			read temp

		elif [ $CHOICE = "4" ]
		then 
			bash queries.sh
			read temp

		elif [ $CHOICE = "E" ]
		then 
			exit
		fi
	done
}

MainMenu
