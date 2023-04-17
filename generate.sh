#!/bin/bash

echo -e "\n\033[1mProject successfully created! Enjoy coding with Django!\033[0m"
echo -e "\e[38;5;196m\e[1m █████╗░░█████╗░░█████╗░██╗░░██╗███████╗███╗░░██╗██╗░░██╗"
echo -e "\e[38;5;208m\e[1m██╔══██╗██╔══██╗██╔══██╗██║░░██║██╔════╝████╗░██║╚██╗██╔╝"
echo -e "\e[38;5;220m\e[1m███████║██║░░██║██║░░██║███████║█████╗░░██╔██╗██║░╚███╔╝░"
echo -e "\e[38;5;46m\e[1m██╔══██║██║░░██║██║░░██║██╔══██║██╔══╝░░██║╚████║░██╔██╗░"
echo -e "\e[38;5;48m\e[1m██║░░██║╚█████╔╝╚█████╔╝██║░░██║███████╗██║░╚███║██╔╝╚██╗"
echo -e "\e[38;5;93m\e[1m╚═╝░░╚═╝░╚════╝░░╚════╝░╚═╝░"

# Function to install the dependencies
install_dependencies() {
    echo -e "\033[1mInstalling Django...\033[0m"
    pip3 install django

    if [ "$1" == "Yes" ]; then
        echo -e "\033[1mInstalling Django Rest Framework...\033[0m"
        pip3 install djangorestframework
    fi
}

# Function to create a new Django app
create_app() {
    app_name=$1

    # Create the app
    echo -e "\n\033[1mCreating new Django app '$app_name'...\033[0m"
    python manage.py startapp $app_name

    # Create an empty __init__.py file in the app's migrations directory to avoid errors
    echo -e "\033[1mCreating empty __init__.py file in migrations directory...\033[0m"
    touch $app_name/migrations/__init__.py
}

# Prompt the user for input
echo -e "\033[1mWelcome to the Django project generator!\033[0m"
read -p "Want to install Django Rest Framework? (Yes/No) " install_drf
read -p "Enter the name of your project: " project_name
read -p "Enter the author of the project: " author
read -p "Enter the directory for the project (enter '.' for current directory): " directory

# Create the virtual environment based on the user's OS
echo -e "\n\033[1mCreating virtual environment...\033[0m"
python3 -m pip3 install virtualenv
python3 -m virtualenv venv

# Activate the virtual environment
echo -e "\n\033[1mActivating virtual environment...\033[0m"
# TODO: fix this for zsh shells
source venv/bin/activate

# Install the required dependencies
install_dependencies $install_drf

# Create the project with the name and author provided by the user
echo -e "\n\033[1mCreating Django project '$project_name'...\033[0m"
django-admin startproject $project_name .

# Create the requirements.txt file using only the dependencies installed in the virtual environment
echo -e "\n\033[1mGenerating requirements.txt file...\033[0m"
pip freeze > requirements.txt

# Create a new Django app
read -p "Want to create a new Django app? (Yes/No) " create_app

if [ "$create_app" == "Yes" ]; then
    read -p "Enter the name of the app: " app_name
    create_app $app_name
fi

# Run the Django development server
echo -e "\n\033[1mStarting Django development server...\033[0m"
python manage.py runserver

# Print "Pulse" in multi-colors to celebrate the successful project creation
echo -e "Project Succesfully Created by \n\033[1m\033[38;5;196mP\033[38;5;208mu\033[38;5;220ml\033[38;5;46ms\033[38;5;48mE\033[38;5;93m!\033[0m\033[1m\033[38;5;196mP\033[38;5;208mu\033[38;5;220ml\033[38;5;46ms\033[38;5;48mE\033[38;5;93m!\033[0m - Made with Love by Manoj"
