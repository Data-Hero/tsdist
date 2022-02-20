cimport cython
from libc.math cimport sqrt, pow, fmin, fmax, fabs
import numpy as np
cimport numpy as np

@cython.boundscheck(False)
@cython.wraparound(False)
cpdef double euclidean_distance(double[:] x, double[:] y):
    cdef Py_ssize_t k
    cdef double result = 0.0
    for k in range(0, len(x), 1):
        result += pow(x[k]-y[k],2)
    return sqrt(result)

@cython.boundscheck(False)
@cython.wraparound(False)
cpdef double manhattan_distance(double[:] x, double[:] y):
    cdef Py_ssize_t k
    cdef double result = 0.0
    for k in range(0, len(x), 1):
        result += fabs(x[k]-y[k])
    return result

@cython.boundscheck(False)
@cython.wraparound(False)
cpdef double minkowski_distance(double[:] x, double[:] y, int p):
    """Computes the Minkowski distance between a pair of numeric time series.
    
    Args:
        x (double[]): Numeric vector containing the first time series.
        y (double[]): Numeric vector containing the second time series.
        p (int): The p defining the which Lp distance is used.

    Returns:
        double: Longest Common Subsequence distance between x and y.
    """
    cdef Py_ssize_t k
    cdef double result = 0.0
    for k in range(0, len(x), 1):
        result += pow(x[k]-y[k],p)
    return pow(result, 1/p)


@cython.boundscheck(False)
@cython.wraparound(False)
cpdef double lcss_distance(double[:] x, double[:] y, double epsilon):
    """Computes the Longest Common Subsequence distance between a pair of numeric time series.

    TODO Long description

    Args:
        x (double[]): Numeric vector containing the first time series.
        y (double[]): Numeric vector containing the second time series.
        epsilon (double): A positive threshold value that defines the distance.

    Returns:
        double: Longest Common Subsequence distance between x and y.
    """
    cdef Py_ssize_t k, l, t1, t2, max
    cdef dist = 0.0
    t1 = len(x)
    t2 = len(y)
    cdef double[:,:] cost_matrix = np.zeros((t1+1,t2+1))
    cdef double[:] subcost = np.zeros((t1*t2))


    # Calculate distances
    for k in range(0, t1, 1):
        for l in range(0, t2, 1):
            dist = sqrt(pow(x[k]-y[k],2))
            if dist > epsilon:
                subcost[k*t1+l] = 1
            else:
                subcost[k*t2+l] = 0

    # DP Algorithm
    for k in range(1, t1+1,1):
        for l in range(1, t2+1, 1):
            if subcost[(k-1)*t1+(l-1)]==0.0:
                cost_matrix[k,l] = cost_matrix[k-1,l-1]+1
            else:
                cost_matrix[k,l] = fmax(cost_matrix[k-1,l], cost_matrix[k,l-1])

    return cost_matrix[t1,t2]

@cython.boundscheck(False)
@cython.wraparound(False)
cpdef double erp_distance(double[:] x, double[:] y, double g):
    """Computes the Edit Distance with Real Penalty between a pair of numeric time series.

    TODO Long description

    Args:
        x (double[]): Numeric vector containing the first time series.
        y (double[]): Numeric vector containing the second time series.
        g (double): The reference value used to penalize gaps.
        sigma (unsigned int): If desired, a Sakoe-Chiba windowing contraint can be added by specifying a positive 
            integer representing the window size.

    Returns:
        double: Edit Distance with Real Penalty between x and y.
    """
    cdef Py_ssize_t t1, t2, k, l
    cdef double dist1, dist2, dist12;
    t1 = len(x)+1
    t2 = len(y)+1
    cdef double[:] cost_matrix = np.zeros(t1*t2)
    cdef double[:,:] dist_matrix = np.zeros((t1,t2))

    # Calculate distances
    for k in range(0, t1 - 1, 1):
        for l in range(0, t2 - 1, 1):
            dist_matrix[k,l] = sqrt(pow(x[k]-y[k],2))

    for k in range(1, t1, 1):
        dist1 = fabs(g-x[k-1])
        cost_matrix[k*t2] = dist1 + cost_matrix[(k-1)*t2]

    for l in range(1, t2, 1):
        dist2 = fabs(g-y[l-1])
        cost_matrix[l] = dist2 + cost_matrix[l-1]

    for k in range(1, t1, 1):
        for l in range(1, t2, 1):
            dist1 = fabs(g-x[k-1])
            dist2 = fabs(g-y[l-1])
            dist12 = dist_matrix[k-1,l-1]
            cost_matrix[(k*t2)+l] = fmin(
                fmin(
                    dist1 + cost_matrix[(k-1) * t2 + l],
                    dist2 + cost_matrix[k * t2 + (l - 1)]
            ), dist12 + cost_matrix[(k-1) * t2 + (l - 1)])

    return cost_matrix[len(cost_matrix)-1]


cpdef double sts_distance(double[:] x, double[:] y):#, double[:] tx=None, double[:] ty=None):
    """Computes the Short Time Series Distance between a pair of numeric time series.

    The short time series distance between two series is designed specially for series with an equal but uneven sampling rate. 
    However, it can also be used for time series with a constant sampling rate. It is calculated as follows
    $$\text{STS}= \sqrt(\sum((y_{k+1}-y_{k})/(tx_{k+1}-tx_{k})-(x_{k+1}-x_{k})/(ty_{k+1}-ty_{k}))^2))$$
    Args:
        x (double[]): Numeric vector containing the first time series.
        y (double[]): Numeric vector containing the second time series.
        tx (double[]): If not constant, a numeric vector that specifies the sampling index of series x.
        ty (double[]): If not constant, a numeric vector that specifies the sampling index of series y. 

    Returns:
        double: Short Time Series Distance between a pair of numeric time series.
    """

    cdef double[:] lx, ly, ltx, lty
    cdef double distance = 0.0
    cdef Py_ssize_t k

    tx = np.arange(1, len(x))
    ty = tx
    ltx = np.ones(len(tx)-1)
    lty = ltx

    for k in range(1, len(x)-1, 1):
        distance = distance + pow((x[k]-x[k-1])/(tx[k]-tx[k-1])-(y[k]-y[k-1])/(ty[k]-ty[k-1]), 2.0)

    return sqrt(distance)


cpdef double sts_distance(double[:] x, double[:] y, double[:] tx, double[:] ty):
    """Computes the Short Time Series Distance between a pair of numeric time series.

    The short time series distance between two series is designed specially for series with an equal but uneven sampling rate. 
    However, it can also be used for time series with a constant sampling rate. It is calculated as follows
    $$\text{STS}= \sqrt(\sum((y_{k+1}-y_{k})/(tx_{k+1}-tx_{k})-(x_{k+1}-x_{k})/(ty_{k+1}-ty_{k}))^2))$$
    Args:
        x (double[]): Numeric vector containing the first time series.
        y (double[]): Numeric vector containing the second time series.
        tx (double[]): If not constant, a numeric vector that specifies the sampling index of series x.
        ty (double[]): If not constant, a numeric vector that specifies the sampling index of series y. 

    Returns:
        double: Short Time Series Distance between a pair of numeric time series.
    """

    cdef double[:] lx, ly, ltx, lty
    if tx is None:
        tx = ty
        ltx = np.ones(len(tx)-1)
        lty = ltx
    if ty is None:
        ty = tx
        ltx = np.ones(len(tx)-1)
        lty = ltx
    cdef double distance = 0.0
    cdef Py_ssize_t k
    for k in range(1, len(x)-1, 1):
        distance = distance + pow((x[k]-x[k-1])/(tx[k]-tx[k-1])-(y[k]-y[k-1])/(ty[k]-ty[k-1]), 2.0)

    return sqrt(distance)
