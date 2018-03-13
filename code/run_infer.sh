# download the model and weights if not present
wtdir=/root/weights
imdir=/root/run_detectron/images

cfgname=cfg_retina.yaml
wtname=retina_weights.pkl

# set up the default options for python script and configuration yaml
if [ -f ${wtdir}/${cfgname} ]; then
    echo "Base Config exists"
else
    echo "Base Config doesn't exist, downloading"
    wget -O ${wtdir}/cfg_base.yaml https://s3-us-west-2.amazonaws.com/detectron/35861858/12_2017_baselines/e2e_mask_rcnn_R-101-FPN_2x.yaml
fi
cfg=${wtdir}/cfg_base.yaml
inferscript="tools/infer_simple.py"

# if [ -f ${PWD}/infer.py ]; then
#     echo "Using custom python"
#     cp ${PWD}/infer.py ${wtdir}/infer.py
#     inferscript="/mnt2/infer.py"
# fi

cp /root/filamennts/code/infer0.py ${wtdir}/infer.py
#inferscript="/mnt2/infer.py"
#inferscript="tools/infer_simple.py"

# Handle the command line arguments for the input if we want custom stuff
# for i in "$@"
# do
# echo $i
# case $i in
#     --python=*)
#     echo "Using custom python"
#     CUSTOMPYTHON="${i#*=}"
#     cp CUSTOMPYTHON ${wtdir}/infer.py
#     inferscript="/mnt2/infer.py"
#     shift # past argument=value
#     ;;
#     --config=*)
#     echo "Using custom weights"
#     CUSTOMCONFIG="${i#*=}"
#     cp CUSTOMCONFIG ${wtdir}/cfg.yaml
#     cfg="${wtdir}/cfg.yaml"
#     shift # past argument=value
#     ;;
#     *)
#           # unknown option
#     ;;
# esac
# done

if [ -f ${wtdir}/$wtname ]; then
    echo "Weights exist"
else
    echo "Weights don't exist, downloading"
    wget -O ${wtdir}/model.pkl https://s3-us-west-2.amazonaws.com/detectron/35861858/12_2017_baselines/e2e_mask_rcnn_R-101-FPN_2x.yaml.02_32_51.SgT4y1cO/output/train/coco_2014_train:coco_2014_valminusminival/generalized_rcnn/model_final.pkl 
fi


# create the communications folder
rm -rf /tmp/docker_mount
mkdir -p /tmp/docker_mount
mkdir -p /tmp/docker_mount/images

# copy input file to mount
cp ${imdir}/* /tmp/docker_mount/images/


nvidia-docker run -it -v /tmp/docker_mount:/mnt -v ${wtdir}:/mnt2 detectron python2 $inferscript \
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
