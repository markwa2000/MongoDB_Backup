
!/bin/bash

# Define the backup directory
backup_dir="/home/user/Backup/"

# Find files older than 7 days in the backup directory
old_files=$(find "$backup_dir" -type f -mtime +7)

if [ -n "$old_files" ]; then
    # Sort the files by modification time (oldest first)
    sorted_files=($(echo "$old_files" | tr ' ' '\n' | sort))

    # Delete the oldest file(s)
    oldest_file="${sorted_files[0]}"
    rm "$oldest_file"

    echo "Deleted the oldest backup file: $oldest_file"
else
    echo "No backup files older than 7 days found."
fi
