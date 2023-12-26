#!/bin/bash

# Validate input arguments
if [ $# -lt 2 ]; then
    echo "Usage: $0 <project_dir> <project_name>"
    exit 1
fi

project_dir=$1
project_name=$2

# Navigate to the project directory
mkdir -p "$project_dir"
cd "$project_dir"

# Check if Django is installed
if ! python -m django --version; then
    echo "Django is not installed. Please install Django first."
    exit 1
fi

# Check if MongoDB is running
if ! nc -z localhost 27017; then
    echo "MongoDB is not running. Please ensure MongoDB is installed and running."
    exit 1
fi

# Create a virtual environment (optional but recommended)
python -m venv venv

# Determine OS and activate the virtual environment
case "$(uname -s)" in
    Linux*|Darwin*)
        source venv/bin/activate
        ;;
    MINGW*|CYGWIN*|MSYS*)
        .\venv\Scripts\activate
        ;;
    *)
        echo "Unsupported OS for automatic activation of virtual environment"
        exit 1
        ;;
esac

# Step 1: Generate Django Project
django-admin startproject $project_name .

# Change to the newly created project directory
cd $project_name

# Generate a random secret key for Django
DJANGO_SECRET_KEY=$(python -c 'from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())')

# Step 2: Create .env with generated secret key and PostgreSQL settings
cat <<EOT > "$project_dir/.env"
# Django settings
DJANGO_SECRET_KEY='$DJANGO_SECRET_KEY'
DJANGO_DEBUG=True
DJANGO_ALLOWED_HOSTS=localhost,127.0.0.1

# PostgreSQL settings
POSTGRES_USER='your_postgres_user'
POSTGRES_PASSWORD='your_postgres_password'
POSTGRES_DB='your_database_name'
POSTGRES_HOST='localhost'
POSTGRES_PORT=5432
EOT

# Create .env.example with a blank secret key and database credentials
cat <<EOT > "$project_dir/.env.example"
# Django settings
DJANGO_SECRET_KEY=''
DJANGO_DEBUG=True
DJANGO_ALLOWED_HOSTS=localhost,127.0.0.1

# PostgreSQL settings
POSTGRES_USER=''
POSTGRES_PASSWORD=''
POSTGRES_DB=''
POSTGRES_HOST='localhost'
POSTGRES_PORT=5432
EOT

# Step 3: Modify settings.py to read from .env file and configure PostgreSQL
pip install python-dotenv djongo

# Modify settings.py for environment variables and MongoDB configuration
sed -i "1s/^/import os\nfrom dotenv import load_dotenv\nload_dotenv()\n\n/" "$project_dir/$project_name/settings.py"
sed -i "/^SECRET_KEY/c\SECRET_KEY = os.getenv('DJANGO_SECRET_KEY', 'default-secret-key')" "$project_dir/$project_name/settings.py"
sed -i "/^DEBUG/c\DEBUG = os.getenv('DJANGO_DEBUG', 'False') == 'True'" "$project_dir/$project_name/settings.py"
sed -i "/^ALLOWED_HOSTS/c\ALLOWED_HOSTS = os.getenv('DJANGO_ALLOWED_HOSTS', '').split(',')" "$project_dir/$project_name/settings.py"

# Replace existing DATABASES configuration with MongoDB configuration
sed -i '/^DATABASES = {/,+5 d' "$project_dir/$project_name/settings.py"
cat <<EOT >> "$project_dir/$project_name/settings.py"
DATABASES = {
    'default': {
        'ENGINE': 'djongo',
        'NAME': '$project_name',
    }
}
EOT


# Freeze dependencies
pip freeze > "$project_dir/requirements.txt"

echo "Django project $project_name has been set up with PostgreSQL support | Project location - $project_dir"
echo "Now committing changes to the git"

git add .
git commit -m "1.1.0/chore: Project Generated with PostgreSQL"

# ASCII Art Success Message
cat << "EOF"

  _____                 _ _                
 / ____|               | | |               
| (___   ___  _ __   __| | |__  _   _  ___ 
 \___ \ / _ \| '_ \ / _` | '_ \| | | |/ _ \
 ____) | (_) | | | | (_| | |_) | |_| |  __/
|_____/ \___/|_| |_|\__,_|_.__/ \__, |\___|
                                 __/ |     
                                |___/      

EOF

echo "Setup Successful!"
