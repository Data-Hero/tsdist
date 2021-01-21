import unittest
from src.tsdist import distances


class TestCase(unittest.TestCase):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.X = [-2, -1, 0, 1, 2]
        self.Y = [0, 0, 0, 0, 0]

    def test_minkowski_distances(self):
        l1 = distances.manhattan_distance(self.X, self.Y)