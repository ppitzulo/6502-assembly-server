#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <input_file.asm>"
    exit 1
fi

input_file=$1
output_file=${input_file%.*}.bin
object_file=${input_file%.*}.o

# Check if running inside Docker
if grep -q docker /proc/1/cgroup; then
    config_path="config.cfg"
else
    config_path="config.cfg"
fi

# Assemble the input file
ca65 -o $object_file $input_file

if [ $? -ne 0 ]; then
    echo "Error: Assembly failed"
    exit 1
fi

# Link the object file to create the binary
ld65 -o $output_file -C $config_path $object_file

if [ $? -ne 0 ]; then
    echo "Error: Linking failed"
    exit 1
fi

# Print the assembled binary to stdout
cat $output_file
