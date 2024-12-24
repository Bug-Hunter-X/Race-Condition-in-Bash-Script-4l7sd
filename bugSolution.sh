#!/bin/bash

# This script demonstrates a solution to the race condition using a lock file.

# Create two files
touch file1.txt
touch file2.txt

# Function to write to a file with locking
write_to_file() {
  local file=$1
  local message=$2
  # Acquire lock
  flock "$file.lock" 
  echo "$message" >> "$file"
  # Release lock
  flock -u "$file.lock"
}

# Start two processes that modify the files concurrently using the function
(while true; do write_to_file file1.txt "Process 1"; sleep 0.1; done) &
(while true; do write_to_file file2.txt "Process 2"; sleep 0.1; done) &

# Wait for a short time to allow the processes to run
sleep 2

# Try to copy the contents of the files to the console
cat file1.txt
cat file2.txt

# Stop the processes
kill %1
kill %2