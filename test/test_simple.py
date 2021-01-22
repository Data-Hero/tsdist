import pyximport
import numpy as np

pyximport.install(setup_args={"script_args": ["--force"]}, language_level=3)
import unittest

from src.tsdist.distances import euclidean_distance


class TSDTest(unittest.TestCase):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.X1 = np.array([1.0, -1.0, 1.0, -1.0, 0.0])
        self.Y1 = np.array([0.0, -1.0, 1.0, -1.0, 0.0])
        self.X2 = np.array([0.2, 0.5, 0.1, 0.8, 1.2, 1.5])
        self.Y2 = np.array([0.1, 0.4, 0.05, 0.81, 1.25, 1.45])
        self.X3 = np.repeat(1, 1000000)
        self.Y3 = np.repeat(1, 1000000)

    def test_euclidean1(self):
        print(euclidean_distance(self.X1, self.Y1))
        self.assertAlmostEqual(euclidean_distance(self.X1, self.Y1), 1.0, places=5)

    def test_euclidean2(self):
        print(euclidean_distance(self.X2, self.Y2))
        self.assertAlmostEqual(euclidean_distance(self.X2, self.Y2), 0.1661325, places=5)


if __name__ == "__main__":
    unittest.main()
