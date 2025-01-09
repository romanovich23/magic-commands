# File Management Scripts

This directory contains shell scripts for managing files, including renaming and organizing them efficiently.

## Available Scripts

### `rename_files.sh`

A versatile script for renaming files based on a prefix and optional suffix while preserving the file extension. It also supports processing files recursively in a specified directory.

#### Usage

```bash
./rename_files.sh -d <directory> -p <prefix_to_replace> -n <new_prefix> [-t <file_extension>] [-e <exclude_suffix>]
```

#### Options
- `-d <directory>`: The directory containing the files to rename (required).
- `-p <prefix_to_replace>`: The prefix in filenames to replace (required).
- `-n <new_prefix>`: The new prefix for the renamed files (required).
- `-t <file_extension>`: (Optional) The file type to rename (e.g., `groovy`, `txt`). Defaults to all files.
- `-e <exclude_suffix>`: (Optional) A suffix in the filename to exclude from renaming.

#### Examples

**Rename all files starting with `oldPrefix` to `newPrefix` in `/path/to/files`:**
```bash
./rename_files.sh -d /path/to/files -p "oldPrefix" -n "newPrefix"
```

**Rename `.groovy` files only, excluding files that end with `Test`:**
```bash
./rename_files.sh -d /path/to/files -p "oldPrefix" -n "newPrefix" -t "groovy" -e "Test"
```

## License

This project is licensed under the MIT License. See the LICENSE file for details.
