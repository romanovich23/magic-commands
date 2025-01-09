#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 -d <directory> -p <prefix_to_replace> -n <new_prefix> [-t <file_extension>] [-e <exclude_suffix>]"
    echo ""
    echo "  -d <directory>           Directory containing the files to rename"
    echo "  -p <prefix_to_replace>   Prefix in filenames to replace"
    echo "  -n <new_prefix>          New prefix for the renamed files"
    echo "  -t <file_extension>      Optional: File type to rename (e.g., groovy, txt, etc.). Defaults to all files."
    echo "  -e <exclude_suffix>      Optional: Suffix in the name (not the extension) to exclude from renaming"
    exit 1
}

# Parse arguments
directory=""
prefix_to_replace=""
new_prefix=""
file_extension="*"  # Default to all files
exclude_suffix=""

while getopts "d:p:n:t:e:" opt; do
    case "$opt" in
        d) directory="$OPTARG" ;;
        p) prefix_to_replace="$OPTARG" ;;
        n) new_prefix="$OPTARG" ;;
        t) file_extension="$OPTARG" ;;  # Optional argument for file extension
        e) exclude_suffix="$OPTARG" ;;
        *) usage ;;
    esac
done

# Check if required arguments are provided
if [[ -z "$directory" || -z "$prefix_to_replace" || -z "$new_prefix" ]]; then
    usage
fi

# Ensure the directory exists
if [[ ! -d "$directory" ]]; then
    echo "Error: Directory '$directory' does not exist."
    exit 1
fi

# Process files recursively
find "$directory" -type f -name "${prefix_to_replace}*.${file_extension}" | while read -r file; do
    # Extract the directory and filename
    dir=$(dirname "$file")
    base=$(basename "$file")

    # Remove the file extension from the name for processing
    name_without_extension="${base%.*}"

    # Skip files if they end with the excluded suffix (if specified)
    if [[ -z "$exclude_suffix" || "$name_without_extension" != *"$exclude_suffix" ]]; then
        # Create the new filename by replacing the prefix and retaining the extension
        new_name="${new_prefix}${name_without_extension#$prefix_to_replace}.${file##*.}"
        # Rename the file
        mv "$file" "$dir/$new_name"
        echo "Renamed: $file -> $dir/$new_name"
    else
        echo "Skipped: $file (ends with '$exclude_suffix')"
    fi
done
