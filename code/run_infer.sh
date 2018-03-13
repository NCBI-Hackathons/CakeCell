# create the communications folder
rm -rf /tmp/docker_mount
mkdir -p /tmp/docker_mount
mkdir -p /tmp/docker_mount/images

# copy input file to mount
cp $1 /tmp/docker_mount/images/

cfg=https://s3-us-west-2.amazonaws.com/detectron/35859745/12_2017_baselines/e2e_mask_rcnn_X-101-64x4d-FPN_2x.yaml
wts=https://s3-us-west-2.amazonaws.com/detectron/35859745/12_2017_baselines/e2e_mask_rcnn_X-101-64x4d-FPN_2x.yaml.02_00_30.ESWbND2w/output/train/coco_2014_train:coco_2014_valminusminival/generalized_rcnn/model_final.pkl

nvidia-docker run -it -v /tmp/docker_mount:/mnt  detectron python2 tools/infer_simple.py \
    --cfg configs/12_2017_baselines/e2e_mask_rcnn_R-101-FPN_2x.yaml \
    --output-dir /mnt/detectron-visualizations \
    --image-ext jpg \
    --wts https://s3-us-west-2.amazonaws.com/detectron/35861858/12_2017_baselines/e2e_mask_rcnn_R-101-FPN_2x.yaml.02_32_51.SgT4y1cO/output/train/coco_2014_train:coco_2014_valminusminival/generalized_rcnn/model_final.pkl \
    /mnt/images
    

# copy output to permanent folder
mkdir -p ${PWD}/results
cp -r /tmp/docker_mount/* ${PWD}/results

# get rid of mount folder
#rm -rf /tmp/docker_mount