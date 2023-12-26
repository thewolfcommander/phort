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

# Step 1: Ask for project name and GitHub repository link
read -p "Enter the name of your project: " project_name
read -p "Enter your new GitHub repository link (optional): " github_repo

# Validate project name (only alphabets and underscores allowed)
if ! [[ $project_name =~ ^[a-zA-Z_]+$ ]]; then
    echo "Invalid project name. Project name should only contain alphabets and underscores."
    exit 1
fi

# Ask the user to choose a directory for the project
default_directory=$(dirname $(dirname $(realpath $0)))
read -p "Enter the directory for the project (default: $default_directory): " chosen_directory
chosen_directory=${chosen_directory:-$default_directory}

read -p "Enter a description for your project (Optional): " project_description

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
        ./setup_poetry.sh $boilerplate_choice "$chosen_directory" "$project_name" "$github_repo" "$project_description"
        ;;
    2) 
        ./setup_virtualenv.sh $boilerplate_choice "$chosen_directory" "$project_name" "$github_repo" "$project_description"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac