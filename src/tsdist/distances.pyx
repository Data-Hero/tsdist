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
    cdef int i
    cdef double result = 0.0
    for i in range(len(x)):
        result += pow(x[i]-y[i],p)
    return pow(result, 1/p)
