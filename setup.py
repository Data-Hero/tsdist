import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="tsdist",
    version="0.1",
    scripts=["tsdist"],
    author="Bijan Riesenberg",
    author_email="bijan.riesenberg@protonmail.com",
    description="A port of the R package TSdist to python.",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/Data-Hero/tsdist",
    packages=setuptools.find_packages(),
    classifiers= [
        "License :: OSI Approved :: GNU General Public License v3 (GPLv3)"
        "Programming Language :: Python :: 3.8"
        "Operating System :: OS Independent",
    ]
)