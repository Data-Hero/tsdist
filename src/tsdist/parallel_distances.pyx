cimport cython
from cpython cimport array
from libc.math cimport sqrt, pow, fmin, fmax, fabs
import numpy as np
cimport numpy as np
from cython import parallel

@cython.boundscheck(False)
@cython.wraparound(False)
cpdef double parallel_euclidean_distance(double[:] x, double[:] y):
    cdef int i
    cdef double result = 0.0
    for i in range(0, len(x), 1):
        result += pow(x[i]-y[i],2)
    return sqrt(result)
