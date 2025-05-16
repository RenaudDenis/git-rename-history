# Git Rename History

A tool to trace the rename/move history of directories in Git repositories in a non-destructive way.

## Overview

The `git-rename-history` script allows you to trace the history of directory renames and moves in a Git repository. It uses Git's rename detection capabilities to identify when directories have been renamed or moved, and provides a chronological history of these changes.

This tool is particularly useful for understanding how a directory has evolved over time in a repository, especially in large codebases where directories may have been reorganized multiple times.

## Features

- Non-destructive: Only reads Git history, doesn't modify any files
- Traces directory rename/move history back to its original location
- Configurable similarity threshold for rename detection
- Handles nested directory renames
- Compatible with Bash 3.x (no associative arrays used)

## Usage

```bash
./git-rename-history <current_path_to_directory_relative_to_repo_root>
```

Example:
```bash
./git-rename-history src/my_module
```

## Configuration

The script has a few configurable parameters at the top:

- `RENAME_SIMILARITY_THRESHOLD`: Similarity threshold for rename detection (default: "70%")
- `MIN_FILES_FOR_DIR_RENAME`: Minimum number of files that must be renamed from a common old directory to consider it a directory rename event (default: 1)

## Testing

The project includes a testing infrastructure to verify the script's functionality:

### Test Repository

The `init-test-repo.sh` script creates a test Git repository with a predefined history of directory renames and moves:

1. Creates `src/module1` with three files
2. Renames `src/module1` to `src/core`
3. Moves `src/core` to `lib/utils`
4. Moves some files from `lib/utils` to `components`
5. Creates `components/nested` with a file
6. Renames `components/nested` to `components/submodule`

To initialize the test repository:

```bash
./init-test-repo.sh
```

### Test Script

The `test-git-rename-history.sh` script tests the `git-rename-history` script against the test repository:

```bash
./test-git-rename-history.sh
```

This script:
1. Cleans up any existing test repository
2. Initializes a fresh test repository
3. Tests the `git-rename-history` script on various directories
4. Verifies that the output matches the expected results

## Development Guidelines

When working on this project, keep the following in mind:

1. **Compatibility**: The script should work with Bash 3.x (no associative arrays)
2. **Non-destructive**: The script should only read Git history, never modify it
3. **Performance**: Consider the performance implications of your changes, especially for large repositories
4. **Testing**: Always run the test script after making changes to ensure functionality is preserved
5. **Documentation**: Update this README if you add new features or change existing behavior

### Adding New Tests

To add new test cases:
1. Modify `init-test-repo.sh` to include the new directory structure or rename operations
2. Update `test-git-rename-history.sh` to include new test cases and expected results
3. Run the test script to verify your changes

## Limitations

- The script uses heuristics and may not detect all complex scenarios
- Very gradual moves (where files are moved one by one over time) might not be detected as a single move
- Merges, splits, and other complex operations may not be fully represented
- The script is designed for well-maintained monorepos with atomic move/rename operations

## License

This project is open source and available under the [MIT License](LICENSE).
