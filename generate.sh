#!/bin/bash

# Greet with ASCII art "Pulse"
echo -e "\033[1;36m" # Set color to cyan
cat << "EOF"
 ____  _                _ 
|  _ \| |              | |
| |_) | |__   ___  _ __| |_ 
|  __/| '_ \ / _ \| '__| __|
| |   | | | | (_) | |  | |_ 
|_|   |_| |_|\___/|_|   \__| |_| |_| |_|
EOF
echo -e "\033[0m" # Reset color

# Provide options for the type of Django boilerplate
echo -e "\033[1mWelcome to the Django project generator!\033[0m"
echo -e "\033[1mCreated by thewolfcommander for the community :)\033[0m"
echo "Please choose the type of Django boilerplate you want to use:"
echo "1) Simple Django app with SQLite3"
echo "2) Simple Django app with PostgreSQL"
echo "3) Simple Django App with MongoDB"
echo "4) Advanced Django App with PostgreSQL"
echo "5) Advanced Django App with MongoDB"
read -p "Enter your choice (1-5): " boilerplate_choice

# Ask for preferred Python environment creation method
echo -e "\033[1mSelect your preferred Python environment setup method:\033[0m"
echo "1) Poetry"
echo "2) Virtualenv"
read -p "Enter your choice (1-2): " env_setup_choice


# Execute the appropriate script based on the user's choice
case $env_setup_choice in
    1) 
        ./setup_poetry.sh $boilerplate_choice
        ;;
    2) 
        ./setup_virtualenv.sh $boilerplate_choice
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac