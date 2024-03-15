#! /bin/bash
# Weather bash CLI script fetches weather from wttr.in
# Usage: Enter a city at the commandlne. This will become the default city.
#               Press Enter again to enter a new city. Press q to quit.
# Get local weather in terminal
#
# Function to fetch weather information
weather() {
    local location=$1
    [ -z "$1" ] && echo "Usage: $0 <city>" && curl wttr.in/:help | less && exit 1
    curl wttr.in/"$location"
}

clear

default_city=""

if [ "$#" -eq 1 ]; then
    default_city="$1"
    weather "$default_city"
    read -rsp $'Press Enter to continue...\n' -n 1 key
    clear
fi

while true; do
    if [ -z "$default_city" ]; then
        read -p "Enter city name (q to quit): " city
    else
        read -p "Enter city name (default: $default_city, q to quit): " city
        if [[ $city == "" ]]; then
            city="$default_city"
        fi
    fi

    if [[ $city == "q" ]]; then
        clear
        exit 0
    fi
    clear
    weather "$city"
    read -rsp $'Press Enter to continue...\n' -n 1 key
    clear

    if [[ $key == "q" ]]; then
        clear
        exit 0
    fi
done
