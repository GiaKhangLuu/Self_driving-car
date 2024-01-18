#!/bin/bash

# Specify the directory path
directory_path="/Users/giakhang/Downloads/kitti_dataset/training_yolo/labels/val"

# Create an array with the names of all .txt files in the directory
txt_files=("$directory_path"/*.txt)

# Check if there are any .txt files in the directory
if [ ${#txt_files[@]} -eq 0 ]; then
    echo "No .txt files found in the directory."
    exit 1
fi

# Specify the output filename
output_filename="val.txt"

# Write the filenames with the extension changed to .png to the output file
for txt_file in "${txt_files[@]}"; do
    base_name=$(basename "$txt_file")
    png_file="${base_name%.txt}"
    echo "$png_file" >> "$output_filename"
done

echo "File list written to '$output_filename'."
