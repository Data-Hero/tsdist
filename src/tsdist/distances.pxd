cpdef double euclidean_distance(double[:] x, double[:] y)
cpdef double manhattan_distance(double[:] x, double[:] y)
cpdef double minkowski_distance(double[:] x, double[:] y, int p)
cpdef double lcss_distance(double[:] x, double[:] y, double epsilon, double sigma)
cpdef double lcss_distance(double[:] x, double[:] y, double epsilon)
cpdef double erp_distance(double[:] x, double[:] y, double g, unsigned int sigma)
cpdef double erp_distance(double[:] x, double[:] y, double g)
cpdef double sts_distance(double[:] x, double[:] y)
cpdef double sts_distance(double[:] x, double[:] y, double[:] tx, double[:] ty)