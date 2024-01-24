#!/bin/bash

# Input and output directories
input_folder="kitti_dataset/training_voc/VOC2012/JPEGImages"
output_folder="kitti_dataset/training_detr"
img_dir="kitti_dataset/training_voc/VOC2012/ImageSets/Main"

if [ -d "$output_folder" ]; then
    # If it exists, remove the existing symbolic link
    rm -rf "$output_folder"
fi
mkdir -p "$output_folder"

for split in train val 
do
  output_dir="${output_folder}/${split}"
  if [ -d "$output_dir" ]; then
      # If it exists, remove the existing symbolic link
      rm -rf "$output_dir"
  fi
  mkdir -p "$output_dir"

  image_set="${img_dir}"/"${split}.txt" 

  # Read image IDs from train.txt and copy corresponding images
  while IFS= read -r image_id; do
    image_file="${input_folder}/${image_id}.png"
    output_file="${output_dir}/${image_id}.png"
    
    if [ -e "$image_file" ]; then
      cp "$image_file" "$output_file"
    else
      echo "Image not found: $image_file"
    fi
  done < "$image_set"
done
