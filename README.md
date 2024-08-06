# make-new-repo

This project was created using a GitHub repository setup script.

## Description

This script does the following:

- Prompts the user for a project name.
- Creates a new public repository on GitHub using the gh CLI.
- Clones the repository to the local machine.
- Changes directory into the new repository.
- Creates a .gitignore file with some common ignore patterns.
- Creates a basic README.md file.
- Commits these new files and pushes them to the remote repository.


## Installation

Make sure you have the GitHub CLI (gh) installed and authenticated.

Save the script to a file, for example, setup_github_repo.sh.

Make the script executable: chmod +x setup_github_repo.sh

Run the script: ./setup_github_repo.sh


## Usage

Run the script: 

```
./setup_github_repo.sh
```

