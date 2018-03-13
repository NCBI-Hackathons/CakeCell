# Configuration variables
CUDALOC="http://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-9.1.85-1.x86_64.rpm"


# Assume we are in the cakecell repository main directory


# Install CUDA drivers

# See if we can find the right one automatically
# TODO: create override
echo "Beginning driver installation"
if [[ `lspci | grep NVIDIA` = *"Tesla"* ]]; then
    echo "Tesla GPU detected"
else
    echo "Could not determine GPU"
    exit 1
fi

echo "Completed driver installation"


# Install CUDA
echo "Beginning CUDA installation"

wget -O cuda_install.rpm $CUDALOC
rpm -i cuda_install.rpm
yum clean all
yum install cuda

echo "Completed CUDA installation"



echo "Beginning docker installation"
# Install docker-ce
yum install docker-ce-17.12.1.ce


# Install nvidia-docker
yum install nvidia-docker2-2.0.3-1.docker17.12.1.ce
echo "Completed docker installation"


# Download detectron
git clone https://github.com/facebookresearch/Detectron.git detectron/
# build docker file
cd detectron/docker
docker build -t detectron .

# Set up stuff to run

echo "Starting docker"
systemctl start docker
