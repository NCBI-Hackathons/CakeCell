# filamennts
A Neural Network Approach to Filament Classification

<b> Hackathon team: Jay Newby (Lead), Ben Walker (Sys Admin), Mike Pablo (Writer),  Sherry Chao, Ian Seim </b>

Identifying objects of interest in microscopy data is a critical task, but it is time-consuming and subject to variability over time and between researchers. We'd like to automatically segment microscopy images in a generic way, using images of filaments and stem cells as two test cases.

<div align="center">
  <img src="images/filaments.jpg", width="400px"> <n>
  <img src="images/stemcells.jpg", width="400px">
</div>

To achieve generic segmentation, we're using <a href="https://github.com/facebookresearch/Detectron">Detectron</a>, Facebook AI Research's "software system that implements state-of-the-art object detection algorithms". This method was able to segment even objects that were not originally in the training data set ([Fig. 2 in Learning to Segment Object Candidates](https://arxiv.org/abs/1506.06204)). In the same way, we want to see whether Detectron can segment our images without any microscopy training data.

<div align="center">
<img src="images/bicycles.jpg", width="800px">
</div>

## Dependencies
[Detectron](https://github.com/facebookresearch/Detectron) is a software system for object detection.
As described on their [installation page](https://github.com/facebookresearch/Detectron/blob/master/INSTALL.md)
  - Requires a NVIDIA GPU, Linux, Python2.
  - Requires Caffe2, various standard Python packages, and the COCO API.


## Workflow diagram
<div align="center">
  <img src="workflow/diagram1.png",width="400px">
</div>

## Workflow method
1. For any images with a dimension greater than 800 px, crop them into a set of overlapping chunks.
2. Submit the images to Detectron to generate segmentation masks
3. For any images composed of overlapping chunks, reassemble them. Combine segments if at least one pixel in the segment mask is shared between chunks.

## Installation
Our installation of Detectron was as follows.
Using CentOS 7 with NVIDIA GPU...
1. Install latest NVIDIA driver.
2. Install CUDA 9.1 on the system
3. Install Docker CE (17.12.1)
4. Install NVIDIA-Docker 2
5. Clone the Detectron repo.
6. Build the Docker file in the Detectron folder
```bash
cd docker
docker build -t detectron .
```
7. Run tests
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
  - This will put the demo output in the docker_mount folder.

## Usage
Any image data where...
- manual segmentation is needed but problematic (time, difficulty, ...), and
- there are not enough examples to train a classifier directly on the dataset

## Input format
So far we have tested .jpg files. Other image formats TBD.

## Output
Segmented images.

<div align="center">
  <img src="images/guydog2.jpg", width="400px">
  <img src="images/guydog2_labeled.jpg", width="400px">
</div>



## Validation

## FAQ

## References
- [Detectron](https://github.com/facebookresearch/detectron). Ross Girshick, Ilija Radosavovic, Georgia Gkioxari, Piotr Dollár and Kaiming He. 2018.
- [Learning to Segment Object Candidates](https://arxiv.org/abs/1506.06204). Pedro O. Pinheiro, Ronan Collobert, and Piotr Dollár. arXiv, 2015.

## People
- [Jay Newby](http://newby.web.unc.edu/), UNC, Chapel Hill, NC, jaynewby@email.unc.edu
- [Ben Walker](https://github.com/bwalker1), UNC, Chapel Hill, NC, walkeb6@live.unc.edu
- [Mike Pablo](http://github.com/mikepab), UNC, Chapel Hill, NC, mikepab@live.unc.edu
- [Sherry Chao](), UNC, Chapel Hill, NC, hchao@email.unc.edu
- [Ian Seim](https://github.com/iseim), UNC, Chapel Hill, NC, iseim@live.unc.edu
