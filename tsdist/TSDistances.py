class TSDistances:
    def __init__(self):
        self._possible_distances = ["euclidean", "manhattan", "minkowski"]
        # "infnorm", "ccor", "sts", "dtw", "lb.keogh",
        # "edr", "erp", "lcss", "fourier", "tquest", "dissim", "acf", "pacf", "ar.lpc.ceps",
        # "ar.mah", "ar.mah.statistic", "ar.mah.pvalue", "ar.pic", "cdm", "cid", "cor",
        # "cort", "int.per", "per", "mindist.sax", "ncd", "pred", "spec.glk", "spec.isd",
        # "spec.llr", "pdc", "frechet", "tam"]

    @property
    def possible_distances(self):
        return self._possible_distances

    @possible_distances.setter
    def possible_distances(self, value):
        raise Exception("possible_distances is a read-only value")
