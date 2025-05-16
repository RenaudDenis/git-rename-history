#!/bin/bash

# Script to test the git-rename-history script against a test repository

# Set up error handling
set -e

echo "=== Testing git-rename-history script ==="

# Clean up any existing test repository
if [ -d "test_repo" ]; then
    echo "Removing existing test repository..."
    rm -rf test_repo
fi

# Initialize a fresh test repository
echo "Initializing test repository..."
./init-test-repo.sh

# Define expected results
expected_lib_utils=".*: 'src/core' -> 'lib/utils'.*"
expected_components=".*: 'lib/utils' -> 'components'.*"
expected_components_submodule=".*: 'components/nested' -> 'components/submodule'.*"

# Test case 1: Trace history of lib/utils
echo -e "\nTest case 1: Tracing history of lib/utils"
cd test_repo
result=$(../git-rename-history lib/utils)
cd ..
if [[ "$result" =~ $expected_lib_utils ]]; then
    echo "PASS: lib/utils correctly traced back to src/core"
else
    echo "FAIL: lib/utils history not correctly traced"
    echo "Expected to find: $expected_lib_utils"
    echo "Got: $result"
fi

# Test case 2: Trace history of components
echo -e "\nTest case 2: Tracing history of components"
cd test_repo
result=$(../git-rename-history components)
cd ..
if [[ "$result" =~ $expected_components ]]; then
    echo "PASS: components correctly traced back to lib/utils"
else
    echo "FAIL: components history not correctly traced"
    echo "Expected to find: $expected_components"
    echo "Got: $result"
fi

# Test case 3: Trace history of components/submodule
echo -e "\nTest case 3: Tracing history of components/submodule"
cd test_repo
result=$(../git-rename-history components/submodule)
cd ..
if [[ "$result" =~ $expected_components_submodule ]]; then
    echo "PASS: components/submodule correctly traced back to components/nested"
else
    echo "FAIL: components/submodule history not correctly traced"
    echo "Expected to find: $expected_components_submodule"
    echo "Got: $result"
fi

echo -e "\n=== Test summary ==="
echo "All tests completed. Check the results above for any failures."
