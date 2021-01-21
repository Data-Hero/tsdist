# test_cy.py
import pyximport

pyximport.install(setup_args={"script_args": ["--force"]}, language_level=3)
from test import *
