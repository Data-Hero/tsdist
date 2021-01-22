from src.tsdist import distances


class TSDistances:
    def __init__(self, x, y):
        self._possible_distances = ["euclidean", "manhattan", "minkowski", "lcss"]
        # "infnorm", "ccor", "sts", "dtw", "lb.keogh",
        # "edr", "erp", "fourier", "tquest", "dissim", "acf", "pacf", "ar.lpc.ceps",
        # "ar.mah", "ar.mah.statistic", "ar.mah.pvalue", "ar.pic", "cdm", "cid", "cor",
        # "cort", "int.per", "per", "mindist.sax", "ncd", "pred", "spec.glk", "spec.isd",
        # "spec.llr", "pdc", "frechet", "tam"]

    def distance(self, distance_name):
        if distance_name == "euclidean":
            return distances.euclidean_distance(self.x, self.y)
        else:
            return -1

    @property
    def possible_distances(self):
        return self._possible_distances

    @possible_distances.setter
    def possible_distances(self, value):
        raise Exception("possible_distances is a read-only value")


def distance():
    return distances.euclidean_distance([1, 2, 3], [2, 2, 2])


if __name__ == "__main__":
    t = TSDistances()
    print(t.distance("euclidean"))

