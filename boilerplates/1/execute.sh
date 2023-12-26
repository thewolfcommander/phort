#!/bin/bash

# Capture the project name from the argument
project_dir=$1
project_name=$2

# Constants
settings_py="$project_dir/$project_name/settings.py"

# Step 1: Generate Django Project
django-admin startproject $project_name .

# Generate a random secret key for Django
DJANGO_SECRET_KEY=$(python -c 'from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())')

# Step 2: Create .env with generated secret key
cat <<EOT > .env
# Django settings
DJANGO_SECRET_KEY='$DJANGO_SECRET_KEY'
DJANGO_DEBUG=True
DJANGO_ALLOWED_HOSTS=localhost,127.0.0.1
EOT

# Create .env.example with a blank secret key
cat <<EOT > .env.example
# Django settings
DJANGO_SECRET_KEY=''
DJANGO_DEBUG=True
DJANGO_ALLOWED_HOSTS=localhost,127.0.0.1
EOT

# Step 3: Modify settings.py to read from .env file
# Install python-dotenv to manage environment variables
pip install python-dotenv

# Modify settings.py to import os and load dotenv
sed -i "1s/^/import os\nfrom dotenv import load_dotenv\nload_dotenv()\n\n/" $settings_py

# Replace SECRET_KEY, DEBUG, and ALLOWED_HOSTS
sed -i "/^SECRET_KEY/c\SECRET_KEY = os.getenv('DJANGO_SECRET_KEY', 'default-secret-key')" $settings_py
sed -i "/^DEBUG/c\DEBUG = os.getenv('DJANGO_DEBUG', 'False') == 'True'" $settings_py
sed -i "/^ALLOWED_HOSTS/c\ALLOWED_HOSTS = os.getenv('DJANGO_ALLOWED_HOSTS', '').split(',')" $settings_py

# Optionally, you can add more settings adjustments as needed

pip freeze > "$project_dir/requirements.txt"

echo "Django project $project_name has been set up with .env support"
