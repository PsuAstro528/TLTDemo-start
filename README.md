# TLT Demo Lab 

This repository includes Jupyter notebooks that demonstrate a workflow for version controlling Jupyter notebooks.
There are related [slides from a talk at Teaching & Learning with Technology 2020](https://psuastro528.github.io/tools_used/tlt2020/).


## Using Jupyter notebooks in educational setting
- Browser-based notebooks provide an interactive development environment
- Notebooks are interactive documents that integrate narrative text, equations, images, live code, live output and/or visualizations.
- Supports ≃40 programming languages
- JSON format stores a complete record of the user's session

## What is a Jupyter notebook good for?
- Data wrangling (cleaning, visualizing, transforming)
- Exploratory data analysis
- Data visualization
- Statistical modeling/machine learning
- Report generation
- Interactive Development Environment¹

For education:
- Interactive lessons
- Tutorials
- Assignments involving data analysis or computation
- Document of a student's work and decision making process

## The Problem
Comparison of two versions of a Jupyter notebook:
- Many differences in meta-data
- Effectively not human-readable
- Important differences hard to isolate
- Interferes with code review, feedback and discussion.

![Comparing Jupyter notebooks](https://psuastro528.github.io/images/github_pr_ipynb.png)

## One Solution
### Key idea: Version control and compare Markdown versions of notebooks.

![Comparing Markdown](https://psuastro528.github.io/images/github_pr_jmd.png)

## Room for Further Improvements
- Automate generation of clean assignment from solutions (create grammar, writer script)
- Reduce command-line operations for students
   - Automate process of generating markdown version via git hooks
- Consider new tools/commercial services emerging
   - [NBDime](https://github.com/jupyter/nbdime)
   - [NBReview](https://www.reviewnb.com/)

¹ = Many feel Jupyter notebooks are inferior to traditional IDEs for traditional software development.

