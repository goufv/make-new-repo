#!/bin/bash

# Function to sanitize the project name
sanitize_name() {
    echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-zA-Z0-9-]/-/g' | sed 's/--*/-/g' | sed 's/^-*//' | sed 's/-*$//'
}

# Get GitHub username
GITHUB_USERNAME=$(gh api user -q .login)
if [ -z "$GITHUB_USERNAME" ]; then
    echo "Failed to get GitHub username. Make sure you're logged in with 'gh auth login'"
    exit 1
fi

# Prompt user for project name
echo "Enter your project name:"
read project_name

# Sanitize the project name
sanitized_name=$(sanitize_name "$project_name")

# Create remote repo on GitHub
echo "Creating remote repository on GitHub..."
gh repo create "$sanitized_name" --public

# Check if repo creation was successful
if [ $? -ne 0 ]; then
    echo "Failed to create repository. Exiting."
    exit 1
fi

# Clone the repository to local machine
echo "Cloning the repository to local machine..."
git clone "https://github.com/$GITHUB_USERNAME/$sanitized_name.git"

# Check if clone was successful
if [ $? -ne 0 ]; then
    echo "Failed to clone repository. Exiting."
    exit 1
fi

# Change directory to the new repo
cd "$sanitized_name" || exit 1

# Create .gitignore file
echo "Creating .gitignore file..."
cat << EOF > .gitignore
# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Node modules
node_modules/

# Environment variables
.env

# Log files
*.log

# IDE specific files
.vscode/
.idea/
*.swp
*.swo
EOF

# Create README.md file
echo "Creating README.md file..."
cat << EOF > README.md
# $project_name

This project was created using a GitHub repository setup script.

## Description

Add a brief description of your project here.

## Installation

Provide installation instructions here.

## Usage

Explain how to use your project here.

## Contributing

If you want to contribute to this project, please follow these steps...

## License

Specify your project's license here.
EOF

# Add and commit the new files
git add .gitignore README.md
git commit -m "Initial commit: Add .gitignore and README.md"

# Push changes to remote repository
git push -u origin main

echo "Repository setup complete! You can find your new project at: https://github.com/$GITHUB_USERNAME/$sanitized_name"
