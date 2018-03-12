# filamennts
A Neural Network Approach to Filament Classification

## Team members
- Jay Newby (Lead)
- Kevin Curran (Sys Admin)
- Mike Pablo (Writer)
- Sherry Chao
- Ben Walker
- Ian Seim

## Goal
We'd like to automatically segment microscopy images of filaments and stem cells:

<div align="center">
  <img src="images/filaments.jpg", width="400px"> <n>
  <img src="images/stemcells.jpg", width="400px">
</div>

We're using <a href="https://github.com/facebookresearch/Detectron">Detectron</a>, Facebook AI Research's "software system that implements state-of-the-art object detection algorithms". This method was able to segment even objects that were not originally in the training data set ([Fig. 2 in Learning to Segment Object Candidates](https://arxiv.org/abs/1506.06204)). In the same way, we want to see whether Detectron can segment our images without any microscopy training data.

<div align="center">
<img src="images/bicycles.jpg", width="800px">
</div>

## To do
1. Get <a href="https://github.com/facebookresearch/Detectron">Detectron</a> installed and running.
2. Try it on our dataset and test images.
  - Establish required image pre/post-processing steps
3. Build pipelines
  - Pre-processing
  - Segmentation with Detectron
  - Post-processing


## References
- [Detectron](https://github.com/facebookresearch/detectron). Ross Girshick, Ilija Radosavovic, Georgia Gkioxari, Piotr Dollár and Kaiming He. 2018.
- [Learning to Segment Object Candidates](https://arxiv.org/abs/1506.06204). Pedro O. Pinheiro, Ronan Collobert, and Piotr Dollár. arXiv, 2015.
