_base_ = [
    'MMDETECTION_DIR/configs/_base_/default_runtime.py',
    'MMDETECTION_DIR/configs/_base_/models/mask_rcnn_r50_fpn.py'
]

model = dict(
    roi_head=dict(
        bbox_head=dict(
            num_classes=1,),
        mask_head=dict(
            num_classes=1,)),)

img_norm_cfg = dict(
    mean=[123.675, 116.28, 103.53], std=[58.395, 57.12, 57.375], to_rgb=True)
albu_train_transforms = [
    dict(
        type='ShiftScaleRotate',
        shift_limit=0.0625,
        scale_limit=0.5,
        rotate_limit=180,
        interpolation=1,
        p=0.75),
    # dict(
    #     type='RandomBrightnessContrast',
    #     brightness_limit=[0.1, 0.3],
    #     contrast_limit=[0.1, 0.3],
    #     p=0.2),
    # dict(
    #     type='OneOf',
    #     transforms=[
    #         dict(
    #             type='RGBShift',
    #             r_shift_limit=10,
    #             g_shift_limit=10,
    #             b_shift_limit=10,
    #             p=1.0),
    #         dict(
    #             type='HueSaturationValue',
    #             hue_shift_limit=20,
    #             sat_shift_limit=30,
    #             val_shift_limit=20,
    #             p=1.0)
    #     ],
    #     p=0.1),
    # dict(type='JpegCompression', quality_lower=85, quality_upper=95, p=0.2),
    # dict(type='ChannelShuffle', p=0.1),
    # dict(
    #     type='OneOf',
    #     transforms=[
    #         dict(type='Blur', blur_limit=3, p=1.0),
    #         dict(type='MedianBlur', blur_limit=3, p=1.0)
    #     ],
    #     p=0.1),
]
train_pipeline = [
    dict(type='LoadImageFromFile'),
    dict(type='LoadAnnotations', with_bbox=True, with_mask=True),
    dict(type='Resize', img_scale=(1333, 800), keep_ratio=True),
    dict(type='Pad', size_divisor=32),
    dict(
        type='Albu',
        transforms=albu_train_transforms,
        bbox_params=dict(
            type='BboxParams',
            format='pascal_voc',
            label_fields=['gt_labels'],
            min_visibility=0.0,
            filter_lost_elements=True),
        keymap={
            'img': 'image',
            'gt_masks': 'masks',
            'gt_bboxes': 'bboxes'
        },
        update_pad_shape=False,
        skip_img_without_anno=True),
    dict(type='Normalize', **img_norm_cfg),
    dict(type='DefaultFormatBundle'),
    dict(
        type='Collect',
        keys=['img', 'gt_bboxes', 'gt_labels', 'gt_masks'],
        meta_keys=('filename', 'ori_shape', 'img_shape', 'img_norm_cfg',
                   'pad_shape', 'scale_factor'))
]
test_pipeline = [
    dict(type='LoadImageFromFile'),
    dict(
        type='MultiScaleFlipAug',
        img_scale=(1333, 800),
        flip=False,
        transforms=[
            dict(type='Resize', keep_ratio=True),
            dict(type='RandomFlip'),
            dict(type='Normalize', **img_norm_cfg),
            dict(type='Pad', size_divisor=32),
            dict(type='ImageToTensor', keys=['img']),
            dict(type='Collect', keys=['img']),
        ])
]

# Modify dataset related settings
dataset_type = 'CocoDataset'
classes = ('Defect',)
data = dict(
    samples_per_gpu=3,
    workers_per_gpu=3,
    train=dict(
        type=dataset_type,
        pipeline=train_pipeline,
        img_prefix='./dataset/images/',
        classes=classes,
        ann_file=[
                            './dataset/annotations/real_defect_train.json',
                            './dataset/annotations/real_predefect_train.json',
                            './dataset/annotations/real_undefective_train.json',
                            # Scaled dataset
                            # './dataset/annotations/real_defect_train_scaled.json',
                            # './dataset/annotations/real_predefect_train_scaled.json',
                            # './dataset/annotations/real_undefective_train_scaled.json',
                            ]),
    val=dict(
        type=dataset_type,
        img_prefix='./dataset/images/',
        classes=classes,
        ann_file=[
                            './dataset/annotations/real_defect_dev.json',
                            './dataset/annotations/real_predefect_dev.json',
                            './dataset/annotations/real_undefective_dev.json',
                            ],
        pipeline=test_pipeline),
    test=dict(
        type=dataset_type,
        img_prefix='./dataset/images/',
        classes=classes,
        ann_file=[
                            './dataset/annotations/real_defect_test.json',
                            './dataset/annotations/real_predefect_test.json',
                            './dataset/annotations/real_undefective_test.json',
                            ],
        pipeline=test_pipeline))
evaluation = dict(interval=1, metric=['bbox', 'segm'])

checkpoint_config = dict(interval=1)
log_config = dict(interval=50,)

# optimizer
optimizer = dict(type='SGD', lr=0.02, momentum=0.9, weight_decay=0.0001)
optimizer_config = dict(grad_clip=None)
# learning policy
lr_config = dict(
    policy='step',
    warmup='linear',
    warmup_iters=500,
    warmup_ratio=0.001,
    step=[8, 11])
runner = dict(type='EpochBasedRunner', max_epochs=12)

# load_from='./checkpoints/mask_rcnn_r50_fpn_mstrain-poly_3x_coco_20210524_201154-21b550bb.pth'
load_from='./checkpoints/mask_rcnn_r50_2s_scaled_stage1.pth'