#Black Thursday

[![Code Climate](https://codeclimate.com/github/jwashke/black_thursday/badges/gpa.svg)](https://codeclimate.com/github/jwashke/black_thursday) [![Build Status](https://travis-ci.org/jwashke/black_thursday.svg?branch=master)](https://travis-ci.org/jwashke/black_thursday) [![Test Coverage](https://codeclimate.com/github/jwashke/black_thursday/badges/coverage.svg)](https://codeclimate.com/github/jwashke/black_thursday/coverage)

Find the [project spec here](https://github.com/turingschool/curriculum/blob/master/source/projects/black_thursday.markdown).

##Overview
Project builds a system able to load, parse, search, and execute business intelligence queries against the data from a typical e-commerece business.

##Key Concepts

From a technical perspective, this project will emphasize:

* File I/O
* Relationships between objects
* Encapsulating Responsibilities
* Light data / analytics

##Running the program

To create the graphs, from the main project folder run

    ruby lib/charts.rb

This will create 3 html files in the graph folder each containing a graph.

To run the project against the spec harness, clone the spec harness into a directory in the same parent directory as this project. Then follow the instructions on the spec harness readme [here](https://github.com/turingschool/curriculum/blob/master/source/projects/black_thursday_spec_harness.markdown).

to run the project tests run

    rake test
