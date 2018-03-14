#! /bin/bash
if [ ! -e /installation_complete.txt ]
then
    yum install -y git
    git clone https://github.com/NCBI-Hackathons/CakeCell.git /cakecell
    sh /cakecell/install.sh
else
    systemctl start docker
fi