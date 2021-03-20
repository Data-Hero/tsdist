# tsdist
This is a port of the R package [TSdist](https://cran.r-project.org/web/packages/TSdist/index.html) to cython.


## List of all metrics
- [X] EuclideanDistance
- [X] ManhattanDistance
- [X] MinkowskiDistance
- [X] LCSSDistance (DP Algorithm with O(n^2) runtime)
- [X] ERPDistance
- ACFDistance
- ARLPCCepsDistance
- ARMahDistance
- ARPicDistance
- CCorDistance
- CDMDistance
- CIDDistance
- CorDistance
- CortDistance
- DissimDistance
- DTWDistance
- EDRDistance
- FourierDistance
- FrechetDistance
- InfNormDistance
- IntPerDistance
- KMedoids
- LBKeoghDistance
- LPDistance
- ManhattanDistance
- MindistSaxDistance
- NCDDistance
- OneNN
- PACFDistance
- PDCDistance
- PerDistance
- PredDistance
- SpecGLKDistance
- SpecISDDistance
- SpecLLRDistance
- STSDistance
- TAMDistance
- TquestDistance
- TSDatabaseDistances

## Packages with similar content
- [TSdist](https://cran.r-project.org/web/packages/TSdist/index.html): The original R package 
- [ts-dist](https://github.com/ymtoo/ts-dist): A python implementation with a few metrics 
- [tslearn](https://tslearn.readthedocs.io/en/stable/index.html): A python package for time series analysis that 
contains a few metrics like dynamic time warping
- [pyts](https://pyts.readthedocs.io/en/stable/index.html) A second python package for time series analysis that 
contains a dtw implementation
