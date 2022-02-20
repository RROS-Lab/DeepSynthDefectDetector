Requirements:

mmdetection


How to use:

run "train.py" for training

run "test.py --show" for testing

Highly recommend reading: https://mmdetection.readthedocs.io/en/latest/2_new_data_model.html, then you will know how to use it in good detail


Configs:

You need to edit config files to designate the dataset you want to use to train, test, and valid

The path of each image will be img_prefix+relative path in your coco format dataset file