import pyximport
import numpy as np

pyximport.install(setup_args={"script_args": ["--force"]})
import unittest

from src.tsdist.distances import euclidean_distance


class TSDTest(unittest.TestCase):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.X = np.array([1., -1., 1., -1., 0.])
        self.Y = np.array([0., -1., 1., -1., 0.])

    def test_euclidean(self):
        self.assertAlmostEqual(euclidean_distance(self.X, self.Y), 1.0, places=5)


if __name__ == "__main__":
    unittest.main()
