import pyximport
import numpy as np

pyximport.install(setup_args={"script_args": ["--force"]}, language_level=3)
import unittest

from src.tsdist.distances import euclidean_distance, lcss_distance, erp_distance


class TSDTest(unittest.TestCase):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.X0 = np.array([1.0, 1.2, 1.4])
        self.Y0 = np.array([1.1, 1.2, 1.4])
        self.X1 = np.array([1.0, -1.0, 1.0, -1.0, 0.0])
        self.Y1 = np.array([0.0, -1.0, 1.0, -1.0, 0.0])
        self.X2 = np.array([0.2, 0.5, 0.1, 0.8, 1.2, 1.5])
        self.Y2 = np.array([0.1, 0.4, 0.05, 0.81, 1.25, 1.45])
        self.X3 = np.repeat(1, 1000000)
        self.Y3 = np.repeat(1, 1000000)
        self.X4 = np.array([0.2, 0.5, 0.1, 0.8, 1.2, 1.5])
        self.Y4 = np.array([0.15, 0.45, 0.1, 0.8, 1.23, 1.48])
        self.X5 = []
        self.Y5 = []

    def test_euclidean1(self):
        print(euclidean_distance(self.X1, self.Y1))
        self.assertAlmostEqual(euclidean_distance(self.X1, self.Y1), 1.0, places=5)

    def test_euclidean2(self):
        print(euclidean_distance(self.X2, self.Y2))
        self.assertAlmostEqual(euclidean_distance(self.X2, self.Y2), 0.1661325, places=5)

 #   def test_euclidean3(self):
 #       print(euclidean_distance(self.X3, self.Y3))
 #       self.assertAlmostEqual(euclidean_distance(self.X3, self.Y3), 0.1661325, places=5)

    def test_lcss4(self):
        print(lcss_distance(self.X0, self.Y0, 0.05))
        self.assertAlmostEqual(lcss_distance(self.X0, self.Y0, 0.05), 2, places=5)
        print(lcss_distance(self.X0, self.Y0, 0.15))
        self.assertAlmostEqual(lcss_distance(self.X0, self.Y0, 0.15), 3, places=5)
        # self.assertAlmostEqual(lcss_distance(self.X4, self.Y4, 0.1), 5, places=5)

    def testERP_distance1(self):
        print("ERP distance 1")
        print(erp_distance(self.X1, self.Y1, 0.001))
        self.assertAlmostEqual(erp_distance(self.X1, self.Y1, 0.001), 0.1, places=5)
        self.assertAlmostEqual(erp_distance(self.X1, self.Y1, 1), 0.1, places=5)
        self.assertAlmostEqual(erp_distance(self.X1, self.Y1, 5), 0.1, places=5)




if __name__ == "__main__":
    unittest.main()
