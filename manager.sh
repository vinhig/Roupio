#!/bin/bash

# Set up color output
bold=`tput bold`
blue=`tput setaf 4`
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
green=`tput setaf 2`
reset=`tput sgr0`

# Check if database is correctly set.
echo "${bold}${blue}Roupio${reset}${bold} server manager.${reset}"
echo "Type --help for basic usage."
echo "----------------------------"
init_db ()
{
	# Init folder for files uploaded
	mkdir public/uploads
	# Init sqlite3 database
	DB="./db.db"
	if [ -f "$DB" ]
	then
		echo "[${green}${bold}ok${reset}] A db.db file is found, great."
	else
		echo "[${yellow}${bold}warning${reset}] No db file found. Will init it with 'init.sql' script."
		sqlite3 db.db '.read init.sql' '.exit'
		echo "-->[${green}${bold}ok${reset}] Database ready."
	fi
}

show_help ()
{
	echo "Usage:"
	echo -e "\t${bold}dvpt${reset} : Run the server in dvpt mode."
	echo -e "\t${bold}prod${reset} : Build and run the server with optimization."
	echo -e "\t${bold}build${reset} : Build the server with optimization. Build the docs."
	echo -e "\t${bold}docs${reset} : Build the docs."
	echo -e "\t${bold}deps${reset} : Check and install dependencies."
}

if [ "$1" = 'dvpt' ]
then
	init_db
	echo "Run the server in dvpt mode."
	crystal run src/Roupio.cr
elif [ "$1" = "prod" ]
then
	init_db
	echo "Build the docs."
	crystal docs src/Roupio.cr
	echo "Build and run the server with optimization."
	crystal build --release src/Roupio.cr
	./Roupio
elif [ "$1" = "docs" ]
then
	echo "Build the docs"
	crystal docs src/Roupio.cr
	xdg-open docs/index.html
elif [ "$1" = "deps" ]
then
	echo "Check and install dependencies."
	if hash crystal 2>/dev/null; then
        echo "[${green}${bold}ok${reset}] Crystal is installed."
    else
        echo "[${red}${bold}error${reset}] Crystal isn't installed."
    fi

    if hash sqlite3 2>/dev/null; then
        echo "[${green}${bold}ok${reset}] SQLite3 is installed."
    else
        echo "[${red}${bold}error${reset}] SQLite3 isn't installed."
    fi

    if hash shards 2>/dev/null; then
        echo "[${green}${bold}ok${reset}] Shards is installed."
        echo "Launching shards fetching dependencies..."
        shards install
    else
        echo "[${red}${bold}error${reset}] Shards isn't installed."
    fi
elif [ "$1" = "--help" ]
then
	show_help
else
	echo "${bold}${yellow}Wrong usage...${reset}"
	show_help
fi

echo "-------------------------------------"
echo "${green}Thx${reset} for using Roupio."
