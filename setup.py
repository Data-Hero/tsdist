import setuptools
import os

try:
    from Cython.Build import cythonize
except ImportError:
    cythonize = None

with open("README.md", "r") as fh:
    long_description = fh.read()


# https://cython.readthedocs.io/en/latest/src/userguide/source_files_and_compilation.html#distributing-cython-modules
def no_cythonize(extensions, **_ignore):
    for extension in extensions:
        sources = []
        for sfile in extension.sources:
            path, ext = os.path.splitext(sfile)
            if ext in (".pyx", ".py"):
                if extension.language == "c++":
                    ext = ".cpp"
                else:
                    ext = ".c"
                sfile = path + ext
            sources.append(sfile)
        extension.sources[:] = sources
    return extensions


extension = [
    setuptools.Extension("src", ["src/tsdist/distances.pyx"],
                         define_macros=[("NPY_NO_DEPRECATED_API", "NPY_1_7_API_VERSION")]),
    setuptools.Extension("src", ["src/tsdist/parallel_distances.pyx"],
                         define_macros=[("NPY_NO_DEPRECATED_API", "NPY_1_7_API_VERSION")],
                         extra_compile_args=['-fopenmp'],
                         extra_link_args=['-fopenmp'], )
]

CYTHONIZE = bool(int(os.getenv("CYTHONIZE", 0))) and cythonize is not None

if CYTHONIZE:
    compiler_directives = {"language_level": 3, "embedsignature": True}
    extensions = cythonize(extension, compiler_directives=compiler_directives)
else:
    extensions = no_cythonize(extension)

with open("requirements.txt") as fp:
    install_requires = fp.read().strip().split("\n")

with open("requirements-dev.txt") as fp:
    dev_requires = fp.read().strip().split("\n")

setuptools.setup(
    ext_modules=extensions,
    install_requires=install_requires,
    extras_require={
        "dev": dev_requires,
        "docs": ["sphinx", "sphinx-rtd-theme"]
    },
)
