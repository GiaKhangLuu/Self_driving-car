# 1. Convert kitti2voc
# 2. Convert voc2coco
# 3. Convert coco2yolo
# 4. Create symbolic links which link to train/val images and labels
# 5. Create train and val files
# 5. Create a .yaml file

kitti_dataset="$(pwd)"/kitti_dataset
yolo_format_dir="$kitti_dataset/training_yolo"
labels_dir="$yolo_format_dir/trainval/" 
images_dir="$kitti_dataset/training_voc/VOC2012/JPEGImages/"

des_images_dir="$yolo_format_dir/images"
des_label_dir="$yolo_format_dir/labels"

# Check if the symbolic link exists
if [ -L "$des_images_dir" ]; then
    # If it exists, remove the existing symbolic link
    rm -rf "$des_images_dir"
    echo "Existing symbolic link removed."
fi

if [ -L "$des_label_dir" ]; then
    # If it exists, remove the existing symbolic link
    rm -rf "$des_label_dir"
    echo "Existing symbolic link removed."
fi

# Create new symbolic link
ln -s  $images_dir $des_images_dir
ln -s $labels_dir $des_label_dir

# Create train and val files
for split in train val 
do
    # Create an array with the names of all .txt files in the directory
    txt_files=("$yolo_format_dir/$split"/*.txt)

    # Check if there are any .txt files in the directory
    if [ ${#txt_files[@]} -eq 0 ]; then
        echo "No .txt files found in the directory."
        exit 1
    fi

    # Specify the output filename
    output_filename="$yolo_format_dir/$split".txt

    if [ -f "$output_filename" ]; then
        # If it exists, remove the existing symbolic link
        rm "$output_filename"
    fi

    # Write the filenames with the extension changed to .png to the output file
    for txt_file in "${txt_files[@]}"; do
        base_name=$(basename "$txt_file")
        png_file="$des_images_dir/${base_name%.txt}".png
        echo "$png_file" >> "$output_filename"
    done

    echo "File list written to '$output_filename'."
done

# Create .yaml file
./create_yaml_file.sh \
    -d $yolo_format_dir \
    -t train.txt \
    -v val.txt \
    -c "$kitti_dataset"/labels.txt \
    -o "$yolo_format_dir"/dataset.yaml
