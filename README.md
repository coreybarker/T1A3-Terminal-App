# Terminal Application - Virtual Job Organiser
---

## Link to Repository
https://github.com/coreybarker/T1A3-Terminal-App

---
## Code Styling
- Rubocop: https://rubystyle.guide/
---
## App Features
### 1: Add Jobs
- The 'Add Job' feature, allows the user to input an incomplete job, to then be sorted into lists by status. Each initial job added is declared as 'Incomplete'. The user can then view the job they have added in the incomplete jobs list, along with any other incomplete jobs that have been entered.

### 2: Stage Jobs
- The 'Stage Job' feature, allows the user to mark a job as complete from the incomplete jobs list, moving it into the Staged job list. From there it will then need further approval to be marked as complete. This allows a two factor authentication for jobs that are said to be complete, to then be checked and marked off accordingly. 
  
### 3: Complete Jobs
- The 'Complete Job' feature, allows the user to approve staged jobs that are said to be completed, moving them into the Completed jobs list once approved.
  
### 4: Remove Jobs
- The 'Remove Job' feature, allows the user to remove a job from any job list by typing in the job name. This allows errors to be made by the user and swiftly fixed accordingly.
  
### 5: Enter/Exit
- The 'Enter & Exit' feature, allows the user to enter the application by typing any key and pressing enter. If no input is given, the user is prompted with an error message, letting them try again. The user is given 3 attempts before the application ends. The Exit feature exit the application when they are done, by typing 'Exit', terminating the application and providing a goodbye message. This was achieved using a simple While loop, getting the users input to break the loop and no input to continue the loop. While the attempts are less than 3 the loop continues, until the attempts are greater than 3 terminating the application using the 'exit' statement.

--- 
## Planning (Trello)
- Trello Board link: https://trello.com/invite/b/inP4pBO3/456b04f59fdcf00779ff791045b45eb4/virtual-job-organiser-program
  
![Trelloboard](../docs/trello_board.png)  
---
## Help Documention
### How to Install (Virtual Job Organiser)
1. Ensure latest version of Ruby is installed on your device
2. Download Application file
3. Run Command: **./run_app.sh** in your terminal
4. Enjoy
   
### Dependencies & Requirements
- Ruby (Version 2.3.0 or higher)
- Ruby Gems ('Rainbow' Version 3.1 or higher)
- Ruby Bundler
 

### User Guide
#### How to use the application:

Once the application is running, you'll be prompted with a Welcome screen.
Every command typed in, must be confirmed by pressing 'Enter' on your keyboard

To Enter the application, type ANY key and press 'Enter'

You will be taken to a menu with a list of choices to choose from by typing the number prompted.

Help Menu - Typing 'h' when prompted on screen, provides a list of all the prompts and their functions.

Typing 'Exit' when you are prompted on screen, will exit the application.

'View All Jobs' - Type '1' - Displays all jobs that have been added with their status.

'Incomplete Jobs List' - Type '2' - Displays all the incomplete jobs added by the user and provides you with an option to stage a job by entering the name of the job and pressing 'Enter'. This moves the job to the staged job list. Typing 'Back' to return to the main menu.

'Staged Jobs List' - Type '3' - Displays all the staged jobs and provides you with an option to complete a job. This moves it to the completed job list by typing in the name of the job and pressing 'Enter'. Typing 'Back' to return to the main menu.

'Complete Jobs List' - Type '4' - Displays all the completed jobs list. Three are no other functions in this jobs list, so, to return to the main menu, press ENTER.

'Add New Job' - Type '5' - Provides the user with the option to add a new job to the incomplete list, by typing in the job name. The incomplete status will be automatically added once the job has been entered. Typing 'Back' to return to the main menu.

'Remove a Job' - Type '6' - Displays all jobs and their status to the user, with the option to remove a job by typing in the name of the job and pressing 'Enter'



---
## References
- Ruby Gem 'Rainbow': https://rubygems.org/gems/rainbow (Authors: Marcin Kulik, Olle Jonsson)
- Rubocop: https://rubystyle.guide/