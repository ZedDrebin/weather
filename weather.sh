#! /bin/bash
# Get local weather in terminal
# bash CLI Weather script fetches weather from wttr.in
# Usage: Run weather.sh or run with a city on the commandlne. Aguments will become the default city.
#        Press q to Quit or any other key to enter a new city.
#
# Function to fetch weather information
weather() {
	local location=$1
	[ -z "$1" ] && echo "Usage: $0 <city>" && curl wttr.in/:help | less && exit 1
	curl wttr.in/"$location"
}
#Function to clear screan and exit nicely
cleanup() {
	clear
	exit 0
}

clear

default_city=""

if [ "$#" -eq 1 ]; then
	default_city="$1"
	weather "$default_city"
	read -rsp $'Press \'q\' to Quit. Any Other Key to Continue...\n' -n 1 key
	if [[ $key = q ]];then cleanup

	fi
fi

while true; do
	if [ -z "$default_city" ]; then
		read -rp "Enter city name (q to quit): " city
	else
		clear
		read -rp "Enter city name (default: $default_city, q to quit): " city
		if [[ $city == "" ]]; then
			city="$default_city"
		fi
	fi

	if [[ $city == "q" ]]; then cleanup

	fi

	clear

	weather "$city"
	read -rsp $'Press \'q\' to Quit. Press Any Other Key to Continue...\n' -n 1 key

	clear

	if [[ $key == "q" ]]; then cleanup

	fi

done
