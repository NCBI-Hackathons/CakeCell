#! /bin/bash
if [ ! -e /installation_complete.txt ]
then
    yum install -y git
    git clone https://github.com/NCBI-Hackathons/CakeCell.git /cakecell
    sh /cakecell/install.sh
fi

systemctl start docker
nvidia-smi -pm 1