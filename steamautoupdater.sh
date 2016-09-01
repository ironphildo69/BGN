#!/bin/bash
#AUTHORS - Phillip Inman (Iron_Phildo69) && Saxon Dakin (AgentBlue)
#Make sure this script has both execute and write permissions as it creates a file called "version" to keep track of the app id.

#ABOUT: This script was made for Binary Gaming Network to fully automate the game servers and their updates. 
#This script should in theory work for any game server so long as you add the sudo entry for the game account to start the service. I've enclosed the needed entry below as an example.
#WARNING: If you don't understand what the lines below do then read up on visudo! DO NOT attempt to blindly edit the file as it can render your linux system inoperable.

#BEGIN EXAMPLE

#run "sudo visudo" then add the following:

#NOTE: starbound is used as an example service here. You must have made the systemd unit file first!

#starbound ALL = NOPASSWD: /bin/systemctl stop starbound-dedicated.service

#starbound ALL = NOPASSWD: /bin/systemctl start starbound-dedicated.service

#sudo apt-get install postfix

#END EXAMPLE
#BEGIN SCRIPT

BRANCH="public"
SERVICE="systemd_unitname.service" #Change this to your service file. For more info read about systemd units. This can also be a script.

#BE SURE TO CHANGE THE STEAM ID BELOW TO YOUR GAME

GETLATESTVERSION=$(./steamcmd/steamcmd.sh +login anonymous +app_info_print 211820 +quit | grep -w $BRANCH -A 3 | grep "buildid" | grep -o '[0-9]*')
GETCURRENTVERSION=$(cat "version")

echo "Latest Update Avaliable is $GETLATESTVERSION"
echo "Current Reported Version is $GETCURRENTVERSION"

if [ "$GETLATESTVERSION" -gt "$GETCURRENTVERSION" ]
then 
	echo "GAME UPDATE AVALIABLE"
	echo "Stopping Game Server..."
	sudo systemctl stop $SERVICE 
	GETSTATUS=$(systemctl is-active $SERVICE)
	echo "Game Server is Currently: $GETSTATUS"
	
	#NOTE: read the next few lines carefully, steamcmd does NOT allow passing of variables! These must be changed manually!
	
	echo "Updating Server..."
	./steamcmd/steamcmd.sh +login username_here "password-if needed" +force_install_dir ../(CHANGE TO GAME NAME)_server +app_update ADDID_HERE +quit # CHANGE THIS LINE AS NEEDED!
	sudo systemctl start $SERVICE # Same as the the above, put your startup script here or systemd unit file.
	
	echo "Starting Game Server..."
	GETSTATUS=$(systemctl is-active $SERVICE)
	echo "Game server is Currently: $GETSTATUS"
	echo $GETLATESTVERSION > version
	echo "Update Complete! Server has Started! :)"
	
else 
	echo "Game is up to date, Exiting Script"
	exit
	fi
