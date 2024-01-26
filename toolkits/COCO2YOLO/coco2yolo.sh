for split in train val 
do
    python COCO2YOLO.py \
        -j /Users/giakhang/dev/work/research_autopilot/dataset_zoo/city_scapes/instances_coco/instancesonly_filtered_gtFine_${split}.json \
        -o /Users/giakhang/dev/work/research_autopilot/dataset_zoo/city_scapes/yolo_format/${split}
done