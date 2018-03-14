wtname=`python2 model_cache.py e2e_mask_rcnn_R-101-FPN_2x`
wtname=${wtname/shared_cache/mnt2}
cfgname="/cakecell/models/e2e_mask_rcnn_R-101-FPN_2x.yaml"
imdir="/cakecell/images"
# create the communications folder
rm -rf /tmp/docker_mount
mkdir -p /tmp/docker_mount
mkdir -p /tmp/docker_mount/images

# copy input file to mount
cp ${imdir}/*.jpg /tmp/docker_mount/images/

inferscript=tools/infer_simple.py


nvidia-docker run -it -v /tmp/docker_mount:/mnt -v /shared_cache:/mnt2 detectron python2 $inferscript \
    --cfg /mnt2/${cfgname} \
    --output-dir /mnt/detectron-visualizations \
    --image-ext jpg \
    --wts /mnt2/${wtname} \
    /mnt/images
    
    
# copy output to permanent folder
mkdir -p ${PWD}/results
cp -r /tmp/docker_mount/detectron-visualizations/* ${PWD}/results

# get rid of mount folder
rm -rf /tmp/docker_mount
