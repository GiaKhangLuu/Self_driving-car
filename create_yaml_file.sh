#!/bin/bash

# Default values
dataset_root_dir="/Users/giakhang/Downloads/kitti_dataset/training_voc/VOC2012/JPEGImages"
train_file="/Users/giakhang/Downloads/kitti_dataset/training_voc/VOC2012/ImageSets/Main/train.txt"
val_file="/Users/giakhang/Downloads/kitti_dataset/training_voc/VOC2012/ImageSets/Main/val.txt"
class_names_file="/Users/giakhang/Downloads/kitti_dataset/labels.txt"
output_file="/Users/giakhang/Downloads/kitti_dataset/kitti_yolo.yaml"

# Function to display usage information
usage() {
    echo "Usage: $0 -d <dataset_root_dir> -t <train_file> -v <val_file> -c <class_names_file> -o <output_file> "
    exit 1
}

# Parse command-line options
while getopts ":d:t:v::c:o:" opt; do
    case $opt in
        d)
            dataset_root_dir="$OPTARG"
            ;;
        t)
            train_file="$OPTARG"
            ;;
        v)
            val_file="$OPTARG"
            ;;
        c)
            class_names_file="$OPTARG"
            ;;
        o)
            output_file="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            usage
            ;;
        :)
            echo "Option -$OPTARG requires an argument."
            usage
            ;;
    esac
done

# Check if the class names file exists
if [ ! -f "$class_names_file" ]; then
    echo "Class names file '$class_names_file' not found."
    exit 1
fi

# Write content to the file
echo "path: $dataset_root_dir" > "$output_file"
echo "train: $train_file" >> "$output_file"
echo "val: $val_file" >> "$output_file"
echo "" >> "$output_file"
echo "# Classes" >> "$output_file"
echo "names:" >> "$output_file"

# Read class names from the file and generate entries
index=0
while IFS= read -r class_name; do
    echo -e " $index: $class_name" >> "$output_file"
    ((index++))
done < "$class_names_file"

echo "File '$output_file' created successfully."
