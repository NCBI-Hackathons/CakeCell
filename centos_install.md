# Installation checklist for a new system
### System requirements: CentOS 7, Nvidia GPU

_See also_ [install.sh](install.sh).

0. Root access
1. Possible `yum update`
2. Create /cakecell/ folder for everything
3. Clone detectron repo at https://github.com/facebookresearch/Detectron.git
4. Install latest driver

    ```bash
    wget -O nvidiadriver.rpm http://us.download.nvidia.com/tesla/390.30/nvidia-diag-driver-local-repo-rhel7-390.30-1.0-1.x86_64.rpm
    ```
5. Restart the system
6. Set up CUDA 9.1
    ```bash
    wget -O cuda_install.rpm http://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-9.1.85-1.x86_64.rpm
    rpm -i cuda_install.rpm
    yum clean all
    yum install cuda
    ```
7. Install docker-ce
    ```bash
    yum install -y docker-ce-17.12.1.ce
    ```

8. Install nvidia-docker
    ```bash
    yum install -y nvidia-docker2-2.0.3-1.docker17.12.1.ce
    ```


9. Build detectron docker file
    ```bash
    docker build -t detectron .
    ```


10. `systemctl start docker`
11. Test on images

    ```bash
    mkdir docker_mount
    nvidia-docker run --rm -it -v ${PWD}/docker_mount:/mnt detectron
    python2 tools/infer_simple.py
        --cfg  configs/12_2017_baselines/e2e_mask_rcnn_R-101-FPN_2x.yaml \
        --output-dir /mnt/detectron-visualizations \
        --image-ext jpg \
        --wts https://s3-us-west-2.amazonaws.com/detectron/35861858/12_2017_baselines/e2e_mask_rcnn_R-101-FPN_2x.yaml.02_32_51.SgT4y1cO/output/train/coco_2014_train:coco_2014_valminusminival/generalized_rcnn/model_final.pkl
        demo
    ```
