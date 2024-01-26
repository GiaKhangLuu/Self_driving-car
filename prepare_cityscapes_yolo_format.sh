#2. Create train.txt and val.txt
#3. Create dataset.yaml
orig_img_dir="$(pwd)/dataset_zoo/city_scapes/leftImg8bit_trainvaltest/leftImg8bit"
yolo_dir="$(pwd)/dataset_zoo/city_scapes/yolo_format"
orig_label_dir="$yolo_dir"

des_img_dir="$yolo_dir/images"
des_label_dir="$yolo_dir/labels"

# Check if the symbolic link exists
if [ -d "$des_img_dir" ]; then
    # If it exists, remove the existing symbolic link
    rm -rf "$des_img_dir"
    echo "Existing symbolic link removed."
fi
mkdir $des_img_dir

if [ -d "$des_label_dir" ]; then
    # If it exists, remove the existing symbolic link
    rm -rf "$des_label_dir"
    echo "Existing symbolic link removed."
fi
mkdir $des_label_dir

for split in train val
do
    # Add images and labels to images/ and labels/
    find "$orig_img_dir/$split/" -type f -exec ln -s {} "$des_img_dir" \;
    ln -s "$orig_label_dir/$split"/* "$des_label_dir"

    # Create train.txt and val.txt
    output_filename="$yolo_dir/$split".txt

    if [ -f "$output_filename" ]; then
        # If it exists, remove the file
        rm "$output_filename"
    fi

    # Write the filenames with the extension changed to .png to the output file
    txt_files=("$orig_label_dir/$split"/*.txt)
    for txt_file in "${txt_files[@]}"; do
        base_name=$(basename "$txt_file")
        png_file="$des_img_dir/${base_name%.txt}".png
        echo "$png_file" >> "$output_filename"
    done
done

# Create .yaml file
./create_yaml_file.sh \
    -d "$(pwd)"/dataset_zoo/city_scapes/yolo_format \
    -t train.txt \
    -v val.txt \
    -c "$(pwd)"/dataset_zoo/city_scapes/labels.txt \
    -o "$(pwd)"/dataset_zoo/city_scapes/dataset.yaml

echo Total images: $(ls "$des_img_dir" | wc -l)
echo Total labels: $(ls "$des_label_dir" | wc -l)