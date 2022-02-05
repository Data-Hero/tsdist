cimport cython

from libc.math cimport sqrt, pow
from cython.parallel import prange


@cython.boundscheck(False)
@cython.wraparound(False)
cpdef double parallel_euclidean_distance(double[:] x, double[:] y):
    cdef int i
    cdef double result = 0.0
    for i in prange(0, len(x), 1, nogil=True):
        result += pow(x[i]-y[i],2)
    return sqrt(result)
