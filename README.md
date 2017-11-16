# CrohnsMRI_tools
The folder contains matlab functions for generation of mpr views of Crohns patients MR data.
For viewing on example data run: demo.m
Use the mouse scroller to change views.

To use the tools you need to have T1-weighted post contrast MR data in nrrd format (3d image+meta).
Then, perform the following stages:
1)use gen_isotropic_volume.m
2)use centerlineExtractor.m to manualy add centeline points (left mouse- view, right mouse, add).
3)use curved_mpr.m and straight_mpr.m to view the mpr images.

