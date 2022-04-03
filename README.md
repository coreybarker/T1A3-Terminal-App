# Terminal Application - Virtual Job Organiser
---

## Link to Repository

---
## Code Styling
- Rubocop: https://rubystyle.guide/
---
## App Features
### 1: Add Jobs
- The 'Add Job' feature, allows the user to input an incomplete job, to then be sorted into lists by status, depending on the status of the job, being 'Incomplete'. The user can then view the job they have added in the incomplete jobs list, along with any other incomplete jobs that have been entered.

### 2: Stage Jobs
- The 'Stage Job' feature, allows the user to make a job as complete from the incomplete jobs list, moving it into the Staged job list, where it is then needing approval to be marked as complete. This allows a two factor authentication for jobs that are said to be complete, to then be checked and marked off accordingly. 
### 3: Complete Jobs
- The 'Complete Job' feature, allows the user to approve staged jobs, one at a time that are said to be completed, moving them into the Completed jobs list.
### 4: Remove Jobs
- The 'Remove Job' feature, allows the user to remove a job from the any job list by typing in the job name. This allows room for error from the user, giving them more than one chance to add, stage or complete a job. 
### 5: Enter/Exit
- The 'Enter & Exit' feature, allows the user to enter the application by typing any key and pressing enter. If no input is given, the user is prompted with an error message, letting them try again. The user is given 3 attempts before the application ends. The Exit feature exit the application when they are done, by typing 'Exit', terminating the application and providing a goodbye message. This was achieved using a simple While loop, getting the users input to break the loop and no input to continue the loop. While the attempts are less than 3 the loop continues, until the attempts are greater than 3 terminating the application using the 'exit' statement.
--- 
## Planning (Trello)

---
## Help Documention
### How to Install (Virtual Job Organiser)

### Dependencies & Requirements
- Ruby Version 2.3.0 or higher
- Ruby Gems
- Ruby Bundler
- Ruby Gem 'Rainbow' Version 3.1 or higher

### User Guide

---
## References
- Ruby Gem 'Rainbow': https://rubygems.org/gems/rainbow (Authors:Marcin Kulik, Olle Jonsson)