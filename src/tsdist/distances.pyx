cimport cython
from libc.math cimport sqrt, pow

@cython.boundscheck(False)
@cython.wraparound(False)
cpdef double euclidean_distance(double[:] x, double[:] y):
    cdef int i
    cdef double result = 0.0
    for i in range(len(x)):
        result += pow(x[i]-y[i],2)
    return sqrt(result)

@cython.boundscheck(False)
@cython.wraparound(False)
cpdef double manhattan_distance(double[:] x, double[:] y):
    cdef int i
    cdef double result = 0.0
    for i in range(len(x)):
        result += abs(x[i]-y[i])
    return result

@cython.boundscheck(False)
@cython.wraparound(False)
cpdef double minkowski_distance(double[:] x, double[:] y, int p):
    """Computes the Minkowski distance between a pair of numeric time series.
    
    Args:
        x (double[]): Numeric vector containing the first time series.
        y (double[]): Numeric vector containing the second time series.
        epsilon (double): A positive threshold value that defines the distance.

    Returns:
        double: Longest Common Subsequence distance between x and y.
    """
    cdef int i
    cdef double result = 0.0
    for i in range(len(x)):
        result += pow(x[i]-y[i],p)
    return pow(result, 1/p)

@cython.boundscheck(False)
@cython.wraparound(False)
cpdef double lcss_distance(double[:] x, double[:] y, int p, double epsilon):
    """Computes the Longest Common Subsequence distance between a pair of numeric time series.

    TODO Long description

    Args:
        x (double[]): Numeric vector containing the first time series.
        y (double[]): Numeric vector containing the second time series.
        epsilon (double): A positive threshold value that defines the distance.

    Returns:
        double: Longest Common Subsequence distance between x and y.
    """
    cdef int i
    cdef double result = 0.0
    cdef int i, j, t1, t2, sigma1, sigma2, max
    cdef double result = 0.0
    t1 = len(x)
    t2 = len(y)
    cdef double[][] cost_matrix = new double[t1][t2]
    cdef int[] subcost = new int[t1+t2]

    length_combined = len(0,t1+t2,1)
    cost_matrix[0][0] = 0.0


    length1 = len(range(0,t1,1))
    for i in range(length1):
        cost_matrix[i,0] = 0.0

    length2 = len(range(0,t2,1))
    for j in range(length2):
        cost_matrix[0,j] = 0.0

    ## TODO check how dist matrix in R is created https://rdrr.io/cran/TSdist/src/R/lcss_distance.R
    for i in range(length1):
        subcost[i] = 0

    ## TODO implement main algorithm https://github.com/cran/TSdist/blob/master/src/LCSSnw.c
    length1 = len(range(1,t1,1))
    length2 = len(range(1,t2,1))
    for i in range(length1):
        for j in range(length2):
            pass


@cython.boundscheck(False)
@cython.wraparound(False)
cpdef double lcss_distance(double[:] x, double[:] y, int p, double epsilon, double sigma):
    """Computes the Longest Common Subsequence distance between a pair of numeric time series.

    TODO Long description

    Args:
        x (double[]): Numeric vector containing the first time series.
        y (double[]): Numeric vector containing the second time series.
        epsilon (double): A positive threshold value that defines the distance.
        sigma (double): If desired, a Sakoe-Chiba windowing contraint can be added by specifying a positive integer 
        representing the window size

    Returns:
        double: Longest Common Subsequence distance between x and y.
    """
