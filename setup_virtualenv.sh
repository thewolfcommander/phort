#!/bin/bash

# Inputs
boilerplate_choice=$1
chosen_directory=$2
project_name=$3
github_repo=$4
project_description=$5


echo "Project will be set up in: $chosen_directory/$project_name"
echo "Git Remote Link: $github_repo"
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Constants
requirements_file="${script_dir}/boilerplates/${boilerplate_choice}/requirements.txt"
boilerplate_script="${script_dir}/boilerplates/${boilerplate_choice}/execute.sh"
helpers_dir="${script_dir}/helpers"
project_dir="${chosen_directory}/$project_name"

# Helper functions
# Convert Unix path to Windows path if needed
convert_path_to_windows() {
    local unix_path=$1
    local win_path=$(echo $unix_path | sed -e 's|^/c|C:|' -e 's|/|\\\\|g')
    echo $win_path
}

# Creating project directory
cd "$chosen_directory"
mkdir "$project_name"
cd "$project_name"
git init
cp "${helpers_dir}/gitignore.txt" "$project_dir/.gitignore"

if [ -z "$project_description" ]; then
    project_description="# $project_name Project Generated from the Best Django Boilerplate, created by thewolfcommander for the community"
fi

echo "$project_description" >> "$project_dir/README.md"

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
        boilerplate_script=$(convert_path_to_windows "$boilerplate_script")
        source venv/Scripts/activate
        ;;
    *)
        echo "OS not supported"
        exit 1
        ;;
esac

echo "Virtual environment activated."
echo "Configuration Directory: ${script_dir}/boilerplates/${boilerplate_choice}/"

# Step 4: Install dependencies from requirements file
if [ -f "$requirements_file" ]; then
    echo "Installing dependencies from $requirements_file"
    pip install -r $requirements_file
else
    echo "Requirements file not found for the selected boilerplate."
    exit 1
fi

# Freeze the requirements to file
pip freeze > "$project_dir/requirements.txt"

# Commiting the initial results
git add .
git commit -m "1.0.0/chore: Initial Commit for the project"

# Step 5: Pass control to another script to generate the boilerplate
if [ -f "$boilerplate_script" ]; then
    echo "Executing boilerplate setup script: $boilerplate_script"
    sh $boilerplate_script "$project_dir" "$project_name"
else
    echo "Boilerplate script not found for the selected choice."
    exit 1
fi

# Pushing the initial changes to Git Remote
if [ -n "$github_repo" ]; then
    git remote add origin $github_repo
    git push -u origin master
fi