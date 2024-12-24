#!/bin/bash

# This script demonstrates a race condition bug.

# Create two files
touch file1.txt
touch file2.txt

# Start two processes that modify the files concurrently
(while true; do echo "Process 1" >> file1.txt; sleep 0.1; done) &
(while true; do echo "Process 2" >> file2.txt; sleep 0.1; done) &

# Wait for a short time to allow the processes to run
sleep 2

# Try to copy the contents of the files to the console
cat file1.txt
cat file2.txt

# Stop the processes
kill %1
kill %2