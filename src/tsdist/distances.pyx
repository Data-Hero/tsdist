cimport cython
from cpython cimport array
from libc.math cimport sqrt, pow, fmin, fmax, fabs
import numpy as np
cimport numpy as np

@cython.boundscheck(False)
@cython.wraparound(False)
cpdef double euclidean_distance(double[:] x, double[:] y):
    cdef int i
    cdef double result = 0.0
    for i in range(0, len(x), 1):
        result += pow(x[i]-y[i],2)
    return sqrt(result)

@cython.boundscheck(False)
@cython.wraparound(False)
cpdef double manhattan_distance(double[:] x, double[:] y):
    cdef int i
    cdef double result = 0.0
    for i in range(0, len(x), 1):
        result += fabs(x[i]-y[i])
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
    cdef int i
    cdef double result = 0.0
    for i in range(0, len(x), 1):
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
    cdef double[:,:] cost_matrix = np.zeros((t1+1,t2+1))
    cdef double[:] subcost = np.zeros((t1*t2))


    # Calculate distances
    for i in range(0, t1, 1):
        for j in range(0, t2, 1):
            dist = sqrt(pow(x[i]-y[i],2))
            if dist > epsilon:
                subcost[i*t1+j] = 1
            else:
                subcost[i*t2+j] = 0

    # DP Algorithm
    for i in range(1, t1+1,1):
        for j in range(1, t2+1, 1):
            if subcost[(i-1)*t1+(j-1)]==0.0:
                cost_matrix[i,j] = cost_matrix[i-1,j-1]+1
            else:
                cost_matrix[i,j] = fmax(cost_matrix[i-1,j], cost_matrix[i,j-1])

    return cost_matrix[t1,t2]


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
    cdef int t1, t2, i, j
    cdef double dist1, dist2, dist12;
    t1 = len(x)+1
    t2 = len(y)+1
    cdef double[:] cost_matrix = np.zeros(t1*t2)
    cdef double[:,:] dist_matrix = np.zeros((t1,t2))

    # Calculate distances
    for i in range(0, t1-1, 1):
        for j in range(0, t2-1, 1):
            dist_matrix[i,j] = sqrt(pow(x[i]-y[i],2))

    for i in range(1, t1, 1):
        dist1 = fabs(g-x[i-1])
        cost_matrix[i*t2] = dist1 + cost_matrix[(i-1)*t2]

    for j in range(1, t2, 1):
        dist2 = fabs(g-y[j-1])
        cost_matrix[j] = dist2 + cost_matrix[j-1]

    #print(np.asarray(cost_matrix))
    for i in range(1, t1, 1):
        for j in range(1, t2, 1):
            dist1 = fabs(g-x[i-1])
            dist2 = fabs(g-y[j-1])
            dist12 = dist_matrix[i-1,j-1]
            cost_matrix[(i*t2)+j] = fmin(
                fmin(
                    dist1 + cost_matrix[(i-1) * t2 + j],
                    dist2 + cost_matrix[i * t2 + (j - 1)]
            ), dist12 + cost_matrix[(i-1) * t2 + (j - 1)])

    return cost_matrix[len(cost_matrix)-1]

