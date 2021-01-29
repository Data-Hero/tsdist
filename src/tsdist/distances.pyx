cimport cython
from libc.math cimport sqrt, pow, fmax
import numpy as np
cimport numpy as np

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
    cdef int i, j, t1, t2, max
    cdef dist = 0.0
    t1 = len(x)
    t2 = len(y)
    cost_matrix = np.zeros((t1+1,t2+1))
    subcost = np.zeros((t1*t2))


    # Calculate distances
    for i in range(t1):
        for j in range(t2):
            dist = sqrt(pow(x[i]-y[i],2))
            if dist > epsilon:
                subcost[i*t1+j] = 1
            else:
                subcost[i*t2+j] = 0

    # DP Algorithm
    for i in range(1,t1+1,1):
        for j in range(1,t2+1,1):
            if subcost[(i-1)*t1+(j-1)]==0.0:
                cost_matrix[i,j] = cost_matrix[i-1,j-1]+1
            else:
                cost_matrix[i,j] = fmax(cost_matrix[i-1,j], cost_matrix[i,j-1])

    return cost_matrix[t1,t2]
