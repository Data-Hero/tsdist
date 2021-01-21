from src.tsdist import distances


def test_the_answer():
    assert distances.euclidean_distance([1, 2, 2], [2, 2, 2]) == 1