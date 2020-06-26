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

## Step-by-step Instruction to Create Lab Assignments (for Instructor)

- EXERCISE_DIR = Directory on your local system containing lab repositories
- CLASSORG = GitHub Organization for your classroom

### Create Development repository from template:
   - Create an empty _private_ repository ("repo") named labN-dev at GitHub.
      + Go to https://github.com/CLASSORG, click New
      + Repository Name: labN-dev
      + Description: Lab N
      + Private
      + Uncheck Initialize README, .gitignore: None, License: None
      + Create repository- Change into directory of lab exercises
   - Change into directory of lab exercises `cd EXERCISE_DIR`
   - Clone lab repository `git clone git@github.com:CLASSORG/labN-dev.git`
   - Change into lab repository `cd labN-dev`
   - Copy standard files from template repository (lab-template) into labN-dev directory

```shell
cp ../lab-template/* .
cp ../lab-template/{.gitignore,.travis.yml} .
cp -r ../lab-template/test .
```

### Commit template files

```shell
# Add generic files in template repo
git add .gitignore LICENSE README.md test
# Add files specific to Julia assignments (may substitute files for other langauges)
git add REQUIRE Project.toml
# Add config files for automatic testing via Travis-ci.com (optional)
git add .travis.yml docker-compose.yml environment.yml
git commit -m "template"
```

### Rename to use main branch and push to GitHub

```shell
git branch -m master main
git push -u origin main
```

### Create & Switch to solution branch

```shell
git checkout -b solution
```

### Make exercises (named exN.ipynb) and tests (named test/testN.jl)
   - Pro tip:  Indicate code to be removed with SOLUTION in a comment so its easy to find.

```shell
git add ex?.ipynb test/test?.jl
git commit -m "new exercise"
```
   - Test each exercise as you go:  `julia -e 'include("test/test1.jl")'`
   - Test as a group:  `julia -e 'include("test/runtests.jl")'`

Make remote solution branch track local solution branch
```shell
git push -u origin solution
```

### Check solution passes CI testing

Check status of test at https://travis-ci.com/CLASSORG/labN-dev/ .


### Make Markdown version of solutions

- Once it passes tests using Travis-CI and you\'re ready to share, use Weave package (or nbconvert for languages other than Julia) to convert notebooks into jmd (or other flavor of markdown) files.

```shell
julia -e 'using Weave; convert_doc("ex1.ipynb","ex1.jmd");'
julia -e 'using Weave; convert_doc("ex2.ipynb","ex2.jmd");'
julia -e 'using Weave; convert_doc("exN.ipynb","exN.jmd");'
```

- Add and commit exN.jmd to solution branch

```shell
git add ex?.jmd; git commit -m "convert from ipynb"
```

- Checkout main branch and add Markdown files for each exercise and test from solution branch
```shell
git checkout main
git checkout solution exN.jmd
git checkout solution test/testN.jl
```

- Edit each exN.jmd to remove code
   - Search for SOLUTION and remove code that students should not see
   - (Note to future self: Should I automate this?)
   - Recreate cleaned notebook files exN.ipynb using Weave (or nbconvert for languages other than Julia)

```shell
julia -e 'using Weave; convert_doc("ex1.jmd","ex1.ipynb");'
julia -e 'using Weave; convert_doc("ex2.jmd","ex2.ipynb");'
julia -e 'using Weave; convert_doc("exN.jmd","exN.ipynb");'
```

   - Check that you're happy with the resulting notebooks, then add & commit them to main branch.

```shell
git add ex?.jmd ex?.ipynb test/test?.jl
git commit -m "cleaned ex"
git push
```

### Create Clean Starter Repository for Students
Create a clean starter repository on GitHub.com from the development repository (so students don't see all commits you've made while creating the exercise).

   - Create an empty public lab named labN-start at GitHub as part of the organization for the class.
      + Go to https://github.com/CLASSORG, click New
      + Description: Lab N:  List super-short lesson goals
      + Public
      + Uncheck Initialize README, .gitignore: None, License: None
      + Create repository
   - Change into directory of lab exercises `cd EXERCISE_DIR`
   - `cp -r labN-dev labN-start`
   - `cd labN-start`
   - Make _sure_ you're in the labN-start subdirectory
   - `rm -rf .git`
   - `git init`
   - `git remote add origin git@github.com:CLASSORG/labN-start.git`
   - Edit .travis.yml to no longer just test solution and now exclude original branch

```shell
git add *
git add .gitignore .travis.yml
git commit -m "init"
git branch -m master main
git push --set-upstream origin main
```

Make original branch for comparison purposes and switch back to main branch

```shell
git checkout -b original
git push -u origin original
git checkout main
```

Check that you're happy with the labN-start repository

### Distribute new laboratory assignment to students
Go to https://classroom.github.com/classrooms

   - Choose YOURCLASS
   - New Assignment
   - Create an Individual Assignment
      -  Title: YOURCLASS Lab N
      -  Repo prefix: labN
      -  Private
      -  Enable assignment invitation URL
      -  Add your starter code from GitHub:  https://github.com/CLASSORG/labN-start
      - Deadline: Sunday 23:59pm (or whatever time you decide)
      - Create Assignment
   -  Copy Invitation Link and send it to students in a Canvas announcement


## Step-by-step Instruction to Begin Lab Assignments (Students)

<a id="clone-repo"></a>
### Clone your github repository to begin a new assignment

- Followed the link provided by the instructor to create your repo for this week's assignment.  Following that link should trigger GitHub to create a private git repository named labN-GITHUBID (where N is the week number and GITHUBID is the GitHub username that you're logged in as at the time you follow the link).
- Find repository url to clone
    + Navigate to the github repository you just created in your browser, likely https://github.com/GITHUBID/labN-GITHUBID
    + Click _Clone or download_.
    + If it says "Clone with https", click "Use ssh".
    + Click the clipboard icon to copy the url onto your clipboard, which we'll call REPO_URL
- From your local machine (or remote desktop if using a cloud environment)

```shell
git clone REPO_URL  # where REPO_URL is what you'll paste from the clipboard
```

- Change into the directory that was created for the repository (we'll call REPO_DIR).

- *Optional (can do later if needed):*  In case the instructor makes changes to the template, it would be useful to be able to merge in those changes easily.  To prepare for that, you can set a remote upstream repository.  Here I assume that your REPO_URL was https://github.com/GITHUBID/example-GITHUBID.git.  We'll be replacing the first GITHUB id with the organization name for your class (CLASSORG) and remove the "-GITHUBID" at the end.
```shell
git remote add upstream git@github.com:CLASSORG/example.git
```

- Open the Jupyter notebook for each exercise in this lab and begin working through the assignment.
- When you're done with a notebook, save it.

---
<a id="run-tests"></a>
### Test your code

- Make sure you've saved all your changes (including adding any new files you created)
- It's best to check that your code passes the tests for each exercise as you go.  In a separate test notebook like [Self-check.ipynb](https://github.com/PsuAstro528/TLTDemo-start/blob/main/Self-check.ipynb):

```julia
using NBInclude
@nbinclude("ex1.ipynb")
include("test/test1.jl")
```
- If you make changes and retest, then restart the kernel for the test notebook to be sure there aren't unintended carryover effects.  
- Altneratively, you can perofrm all the provided tests on your full repository by running `julia test/runtests.jl` (may need to adjust for your language).  This is very similar to how it will be tested by Travis-CI.

---
<a id="commit-push"></a>
### Commit your changes and push to Github

- From a terminal, generate markdown versions of your Jupyter notebooks.  If using Julia, then you could use run the following commands

```shell
cd YOUR_REPO_DIRECTORY     # You'll need to replace YOUR_REPO_DIRECTORY and NOTEBOOK_NAME
julia -e 'using Weave; convert_doc("NOTEBOOK_NAME.ipynb","NOTEBOOK_NAME.jmd")'
git add NOTEBOOK_NAME.jmd  # Only need to do this once per new file if you use the -a option with "git commit" below.  Otherwise, need to do each time you want to deposit a new version of the file into your respository.
git commit -a -m "note about what you've done"  # Commit all changes you've made
git push                                        # Uploads your progress to github
```
- If this repository is configured to apply tests via continuous integration, then check back on whether your changes pass the tests.  The results will be available at a url like https://travis-ci.com/CLASSORG/labN-GITHUBID/ .


---
<a id="submit-pr"></a>
### Submit your work via Github pull request

- Make sure you've saved, committed and pushed all your changes.
- Check that your code passes all the tests (or as many as practical in reasonable amount of your time)
- Navigate to your github repository for the assignment
- Click _New Pull Request_ button (second button from left, below the orange bar)
- Set the left button to "base:original".  Leave the right button "compare:main".
- Review the updates to the page and make sure this is the version you intend to submit.
- Enter a name for the pull request in the text box to the right of your avitar/icon.
- Optionally, write a longer messages in the larger box below
- Click _Create Pull Request_

---
<a id="discuss-pr"></a>
### Review the feedback on your submission (your pull request)
- Browse to your github repository.
- Click _Pull Requests_, click the name of your pull request.
- In the conversations tab (default), you and the instructor can discuss the pull request using the text box at the bottom of the page.
- In the "Files changed" tab, the instructor can provide comments on specific lines of your submission.
- You can view the comments, reply, close the pull request, make more changes, , etc.





## Room for Further Improvements
This seemed to work well for a small upper-level class.  However, for a larger or general education-level class, the process might need to be stream lined.  Possible improvements include:
- Automate generation of clean assignment from solutions (create grammar, writer script)
- Reduce command-line operations for students
   - Automate process of generating markdown version via git hooks
- Consider new tools/commercial services emerging
   - [NBDime](https://github.com/jupyter/nbdime)
   - [NBReview](https://www.reviewnb.com/)

¹ = Many feel Jupyter notebooks are inferior to traditional IDEs for traditional software development.
