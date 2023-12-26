#!/bin/bash

boilerplate_choice=$1
chosen_directory=$2
project_name=$3
github_repo=$4

echo "Project will be set up in: $chosen_directory/$project_name"
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Change to the chosen directory
cd "$chosen_directory"
mkdir "$project_name"
cd "$project_name"

# ... [rest of the script]

# Use absolute paths for boilerplate files
requirements_file="${script_dir}/boilerplates/${boilerplate_choice}/requirements.txt"
boilerplate_script="${script_dir}/boilerplates/${boilerplate_choice}/execute.sh"

# Step 1: Install virtualenv if not already
if ! command -v virtualenv &> /dev/null
then
    echo "virtualenv not found, installing..."
    pip install virtualenv
else
    echo "virtualenv is already installed."
fi

# Step 2: Detect Python version and OS information
python_version=$(python --version)
os_info=$(uname -a)
echo "Python Version: $python_version"
echo "OS Information: $os_info"

# Step 3: Create and activate virtual environment
virtualenv venv

# Activating environment depending on OS
case "$(uname -s)" in
    Linux*|Darwin*)
        source venv/bin/activate
        ;;
    CYGWIN*|MINGW32*|MSYS*|MINGW*)
        source venv/Scripts/activate
        ;;
    *)
        echo "OS not supported"
        exit 1
        ;;
esac

echo "Virtual environment activated."

# Step 4: Install dependencies from requirements file
requirements_file="boilerplates/${boilerplate_choice}/requirements.txt"
if [ -f "$requirements_file" ]; then
    echo "Installing dependencies from $requirements_file"
    pip install -r $requirements_file
else
    echo "Requirements file not found for the selected boilerplate."
    exit 1
fi

# Step 5: Pass control to another script to generate the boilerplate
boilerplate_script="boilerplates/${boilerplate_choice}/execute.sh"
if [ -f "$boilerplate_script" ]; then
    echo "Executing boilerplate setup script: $boilerplate_script"
    bash $boilerplate_script
else
    echo "Boilerplate script not found for the selected choice."
    exit 1
fi
