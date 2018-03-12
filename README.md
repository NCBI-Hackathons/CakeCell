# filamennts
A Neural Network Approach to Filament Classification

<b> Hackathon team: Jay Newby (Lead), Kevin Currin (Sys Admin), Mike Pablo (Writer),  Sherry Chao, Ben Walker, Ian Seim </b>

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

## Workflow diagram

## Workflow method

## Installation

## Usage

## Input format

## Output

## Validation

## FAQ

## References
- [Detectron](https://github.com/facebookresearch/detectron). Ross Girshick, Ilija Radosavovic, Georgia Gkioxari, Piotr Dollár and Kaiming He. 2018.
- [Learning to Segment Object Candidates](https://arxiv.org/abs/1506.06204). Pedro O. Pinheiro, Ronan Collobert, and Piotr Dollár. arXiv, 2015.

## People
- [Jay Newby](http://newby.web.unc.edu/), UNC, Chapel Hill, NC, jaynewby@email.unc.edu
- [Kevin Currin](), UNC, Chapel Hill, NC, kwcurrin@email.unc.edu
- [Mike Pablo](http://github.com/mikepab), UNC, Chapel Hill, NC, mikepab@live.unc.edu
- [Sherry Chao](), UNC, Chapel Hill, NC, hchao@email.unc.edu
- [Ben Walker](https://github.com/bwalker1), UNC, Chapel Hill, NC, walkeb6@live.unc.edu
- [Ian Seim](https://github.com/iseim), UNC, Chapel Hill, NC, iseim@live.unc.edu
