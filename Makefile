.PHONY: build dist redist install install-from-source clean uninstall

build:
	CYTHONIZE=1 ./setup.py build

dist:
	CYTHONIZE=1 ./setup.py sdist bdist_wheel

redist: clean dist

install:
	CYTHONIZE=1 pip install .

install-from-source: dist
	pip install dist/tsdist-0.1.0.tar.gz

clean:
	$(RM) -r build dist src/*.egg-info
	$(RM) -r src/tsdist/{distances.c}
	$(RM) -r .pytest_cache
	find . -name __pycache__ -exec rm -r {} +

uninstall:
	pip uninstall tsdist
