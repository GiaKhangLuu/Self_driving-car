for split in train val trainval 
do
    python voc2coco.py \
        --ann_dir /Users/giakhang/Downloads/kitti_dataset/training_voc/VOC2012/Annotations \
        --ann_ids /Users/giakhang/Downloads/kitti_dataset/training_voc/VOC2012/ImageSets/Main/${split}.txt \
        --labels /Users/giakhang/Downloads/kitti_dataset/training_voc/VOC2012/labels.txt \
        --output /Users/giakhang/Downloads/kitti_dataset/training_coco/${split}.json \
        --ext xml
done