# Configuration variables
CUDALOC="http://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-9.1.85-1.x86_64.rpm"
TESLADRIVERLOC="http://us.download.nvidia.com/tesla/390.30/nvidia-diag-driver-local-repo-rhel7-390.30-1.0-1.x86_64.rpm"


# TODO: clean up after ourselves

# Assume we are in the cakecell repository main directory


# do we need to update anything?
yum update git


# Install CUDA drivers

# See if we can find the right one automatically
# TODO: create override
echo "Beginning driver installation"
if [[ `lspci | grep NVIDIA` = *"Tesla"* ]]; then
    echo "Tesla GPU detected"
    wget -O driver.rpm $TESLADRIVERLOC
    # check that this is correct
    yum install driver.rpm
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
yum install -y cuda

echo "Completed CUDA installation"



echo "Beginning docker installation"
# Install docker-ce
yum install -y docker-ce-17.12.1.ce


# Install nvidia-docker
yum install -y nvidia-docker2-2.0.3-1.docker17.12.1.ce
echo "Completed docker installation"


# Download detectron
git clone https://github.com/facebookresearch/Detectron.git detectron/
# build docker file
cd detectron/docker
docker build -t detectron .


# TODO: Set up our wrapper stuff to make it more convenient to run

# Set up stuff to run

echo "Starting docker"
systemctl start docker




# Need to reboot the system for driver changes to take effect
read -p "Reboot now? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    reboot
fi