import random
import argparse
import logging
import sys
import os

def parse_args():
    parser = argparse.ArgumentParser(description='split to train and val sets')
    required = parser.add_argument_group('required arguments')
    required.add_argument('--from-path',
                          dest='from_path',
                          required=True,
                          help=f'Path to dataset you wish to split.')
    
    args = parser.parse_args()
    logging.info(args)
    return args

def split(filepath):
    # Read the list of image names from trainval.txt
    with open(filepath, 'r') as file:
        image_names = file.read().splitlines()

    # Shuffle the image names to randomize the order
    random.seed(12)
    random.shuffle(image_names)

    # Define the split ratio (e.g., 80% for training, 20% for validation)
    split_ratio = 0.8
    split_index = int(len(image_names) * split_ratio)

    # Split the image names into train and val sets
    train_set = image_names[:split_index]
    val_set = image_names[split_index:]

    # Write the lists to train.txt and val.txt
    datasets = [train_set, val_set]
    filenames = ['train.txt', 'val.txt']
    filedir = '/'.join(filepath.split('/')[:-1])
    for filename, dataset in zip(filenames, datasets):
        filepath = os.path.join(filedir, filename)

        with open(filepath, 'w') as file:
            file.write('\n'.join(dataset))

if __name__ == '__main__':
    args = parse_args()
    sys.exit(split(filepath=args.from_path))