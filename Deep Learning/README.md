# Deep Learning

This is the code for Deep Learning part of the paper.

## Requirements

mmdetection

## How to use

The deep learning part is based on the mmdetection framework, we recommend read the mmdetection documentation for further detail: https://mmdetection.readthedocs.io/en/latest/2_new_data_model.html

### Configs

All model configurations and training/testing pipeline configurations are defined in mmdetection config file. config file is saved in folder **configs/**. To learn more about mmdetection config, please read https://mmdetection.readthedocs.io/en/latest/tutorials/config.html. 

### Training

1. Put all training images in folder **dataset/images/**, put all annotation files in folder **dataset/annotations/**. The annotations are COCO format.
2. Config training setting through mmdetection config file in folder **configs/**.
3. Run **train.py** to start training, the trainer could be configured in the script. Config file could be selected by the statement *config='mask_rcnn_r50_2s_scaled'*.  
4. In order to do 2 Stage training, you can firstly do the first stage training, then save the pretrained model in **checkpoints/**, then in the second stage, load the pretrained model by *load_from=...* in config. 

### Testing

run "test.py --show" for testing

Highly recommend reading: https://mmdetection.readthedocs.io/en/latest/2_new_data_model.html, then you will know how to use it in good detail
