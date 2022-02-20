# TSdist
This is a port of the R package [TSdist](https://cran.r-project.org/web/packages/TSdist/index.html) to cython.


## List of all metrics
- [X] EuclideanDistance
- [X] ManhattanDistance
- [X] MinkowskiDistance
- [X] LCSSDistance (DP Algorithm with O(n^2) runtime)
- [X] ERPDistance
- [X] STSDistance (single-pass O(n) implementation from Möller-Levet (2003), no sampling rate yet)
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
- TAMDistance
- TquestDistance
- TSDatabaseDistances

things to do afterwards:
- parallelization
- integrations

## Packages with similar content
- [TSdist](https://cran.r-project.org/web/packages/TSdist/index.html): The original R package 
- [ts-dist](https://github.com/ymtoo/ts-dist): A python implementation with a few metrics 
- [tslearn](https://tslearn.readthedocs.io/en/stable/index.html): A python package for time series analysis that 
contains a few metrics like dynamic time warping
- [pyts](https://pyts.readthedocs.io/en/stable/index.html) A second python package for time series analysis that 
contains a dtw implementation
- [sktime](https://www.sktime.org/en/latest/index.html) A scikit-learn compatible framework for time series analysis planning on extending the amount of metrics available in the future. currently implementing LCSS, MPDist, some DTW variations, Euclidean & ERP
