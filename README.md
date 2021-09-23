# Angular-Enhancement
Angular Resolution Enhancement for Diffusion MRI by a Gaussian Process
## About the project
This repository contains the source code of a method to enhance angular resolution of diffusion images. It uses matlab to run and some basic instructions.
## Installation
The code requires the toolbox: Tools for NIfTI and ANALIZE image available at [MathWorks](https://www.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image).

Once the toolbox is installed, it must be added to the matlab path using addpath function.
## Usage
From the command window in matlab call:
```
addpath('path/to/NIfTI_tools/');
```
It is neccesary to define the path to the images(dwi.nii) and bvec file (dwi.bvec) and bval file (dwi.bval):
```
gen_path='path/to/images/folder';
```
DWI images have to be without 
## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
