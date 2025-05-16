#!/bin/bash

# Script to initialize a test repository for git-rename-history

# Create the test repository directory and initialize git
mkdir -p test_repo
cd test_repo
git init

# Create initial directory structure with files
mkdir -p src/module1
echo "content1" > src/module1/file1.txt
echo "content2" > src/module1/file2.txt
echo "content3" > src/module1/file3.txt
git add .
git commit -m "Initial commit with src/module1 directory"

# Rename src/module1 to src/core
mkdir -p src/core
git mv src/module1/* src/core/
rmdir src/module1
git commit -m "Rename src/module1 to src/core"

# Move src/core to lib/utils
mkdir -p lib/utils
git mv src/core/* lib/utils/
rmdir src/core
rmdir src
git commit -m "Move src/core to lib/utils"

# Move some files from lib/utils to components
mkdir -p components
git mv lib/utils/file1.txt lib/utils/file2.txt components/
git commit -m "Move some files from lib/utils to components"

# Add nested directory in components
mkdir -p components/nested
echo "nested content" > components/nested/nested_file.txt
git add .
git commit -m "Add nested directory in components"

# Rename components/nested to components/submodule
mkdir -p components/submodule
git mv components/nested/* components/submodule/
rmdir components/nested
git commit -m "Rename components/nested to components/submodule"

echo "Test repository initialized successfully."
