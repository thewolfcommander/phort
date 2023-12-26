
# Phort - The Best Django Boilerplate

Welcome to Phort, the Best Django Boilerplate, a comprehensive setup for your Django projects. This README provides instructions on how to use the boilerplate to set up various Django projects, including configurations for different databases and advanced setups.

## Overview

This boilerplate offers several choices for setting up your Django project:

1\. Simple Django app with SQLite3 - [Read more](./boilerplates/1/info.md)

2\. Simple Django app with PostgreSQL - [Read more](./boilerplates/2/info.md)

3\. Simple Django App with MongoDB - [Read more](./boilerplates/3/info.md)

4\. Advanced Django App with PostgreSQL - [Read more](./boilerplates/4/info.md)

5\. Advanced Django App with MongoDB - [Read more](./boilerplates/5/info.md)

Each option is tailored to suit different project requirements, from basic to advanced needs.

## Prerequisites

Before you start, ensure you have the following installed:

- Python 3.x

- pip (Python package manager)

- Virtualenv or Poetry (depending on your choice for environment management)

- Git (for version control and repository management)

## Getting Started

1\. **Clone the Repository**: Start by cloning this repository to your local machine.

   ```bash

   git clone https://github.com/thewolfcommander/best_django_boilerplate

   ```

2\. **Run the Setup Script**: Navigate to the cloned directory and run the setup script.

   ```bash

   cd best_django_boilerplate

   ./generate.sh

   ```

3\. **Select Boilerplate Option**: When prompted, choose the desired boilerplate option by entering the corresponding number.

4\. **Choose Environment Setup**: Select either Virtualenv or Poetry for your Python environment setup.

5\. **Enter Project Details**: Provide the necessary details like project name, GitHub repository (optional), and project directory.

6\. **Follow On-Screen Instructions**: The script will guide you through the rest of the setup, including environment creation and package installations.

## Boilerplate Choices

### 1. Simple Django App with SQLite3

- Ideal for small projects or prototypes.

- Uses SQLite3, a lightweight database.

### 2. Simple Django App with PostgreSQL

- Suitable for projects requiring a more robust database.

- Ensure PostgreSQL is installed and running on your system.

### 3. Simple Django App with MongoDB

- For projects that prefer a NoSQL database.

- Requires MongoDB to be installed and running.

### 4. Advanced Django App with PostgreSQL

- Advanced configuration with additional features.

- Includes setup for more complex applications.

### 5. Advanced Django App with MongoDB

- Advanced setup using MongoDB.

- Includes additional configurations and dependencies for large-scale applications.

## Configuration

- **Environment Variables**: Set up your environment variables in the `.env` file. A `.env.example` file is provided for reference.

- **Database Setup**: Configure the database settings in `settings.py` according to your chosen database.

- **Static and Media Files**: Configure the paths for static and media files if necessary.

## Running the Project

To run the Django development server:

```bash

python manage.py runserver

```

Visit `http://localhost:8000` in your web browser to view the project.

## Additional Information

- **Customizing the Project**: Feel free to modify the boilerplate to suit your project's specific needs.

- **Dependencies**: Additional Python dependencies can be added as required.

## Contributing

Contributions to improve this boilerplate are welcome. Please feel free to fork, modify, and create pull requests or open issues for any enhancements or fixes.

---
