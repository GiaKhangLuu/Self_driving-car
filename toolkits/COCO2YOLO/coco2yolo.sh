for split in train val trainval
do
    python COCO2YOLO.py \
        -j /Users/giakhang/Downloads/kitti_dataset/training_coco/${split}.json \
        -o /Users/giakhang/Downloads/kitti_dataset/training_yolo/${split}
done