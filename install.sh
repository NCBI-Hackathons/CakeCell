# Configuration variables
CUDALOC="http://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-9.1.85-1.x86_64.rpm"
TESLADRIVERLOC="http://us.download.nvidia.com/tesla/390.30/nvidia-diag-driver-local-repo-rhel7-390.30-1.0-1.x86_64.rpm"
#K80DRIVERLOC="http://us.download.nvidia.com/tesla/390.30/nvidia-diag-driver-local-repo-rhel7-390.30-1.0-1.x86_64.rpm"


# TODO: clean up after ourselves

if [ ! -e /install ]
then
    # begin and install drivers
    mkdir /install
    cd /install

    # do we need to update anything?
    yum update
    yum install -y git
    yum install -y wget



    # Install CUDA drivers

    # See if we can find the right one automatically
    # TODO: create override
    echo "Beginning driver installation"
    wget -O driver.rpm $TESLADRIVERLOC
    # check that this is correct
    yum install -y driver.rpm
    yum clean all
    yum install -y cuda_drivers
    echo "Completed driver installation"
    
    reboot

else
    # do rest of installation

    # Install CUDA
    echo "Beginning CUDA installation"

    wget -O cuda_install.rpm $CUDALOC
    rpm -i cuda_install.rpm
    yum clean all
    yum install -y cuda

    echo "Completed CUDA installation"



    echo "Beginning docker installation"
    # Install docker-ce
    yum install -y yum-utils \
      device-mapper-persistent-data \
      lvm2
  
    yum-config-manager \
        --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo


    yum install -y docker-ce-17.12.1.ce


    # Install nvidia-docker
    curl -s -L https://nvidia.github.io/nvidia-docker/centos7/x86_64/nvidia-docker.repo | \
      sudo tee /etc/yum.repos.d/nvidia-docker.repo
    yum install -y nvidia-docker2-2.0.3-1.docker17.12.1.ce
    systemctl start docker
    echo "Completed docker installation"


    # Download detectron
    git clone https://github.com/facebookresearch/Detectron.git /detectron
    # build docker file
    cd /detectron/docker
    docker build -t detectron .


    # TODO: Set up our wrapper stuff to make it more convenient to run

    # Set up stuff to run

    echo "Starting docker"
    systemctl start docker

fi