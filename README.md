
Purpose
The purpose of this script is to(Gadzira File):

Create a standardized directory structure for the submission reminder project.

Generate necessary files with predefined templates.

Facilitate the management and reminders of student assignment submissions.

Setup Instructions
Save the provided script as create_environment.sh.

Make the script executable by running the appropriate command in your terminal.

Execute the script by running it.

When prompted, input your name.

Directory Structure
After running the script, the following directory structure will be created:

app/reminder.sh

modules/functions.sh

assets/submissions.txt

config/config.env

startup.sh

Script Files and Explanation
Main Script: This script is responsible for setting up the directory structure and creating necessary files. It reads the user's name and creates a directory based on the input, then creates the required directories and files.

reminder.shScript: This script determines the directory of the current script, sources environment variables and helper functions, and prints the remaining time to submit assignments. It then calls a function to check for submissions.

functions.shScript: This script contains a function to read the submissions file and output students who have not submitted their assignments. It iterates through the lines of the submissions file, removes leading and trailing whitespace, and checks the submission status of each student.

config.envFile: This file stores the assignment details and the number of days remaining for submission.

submissions.txtFile: This file contains the submission records for the assignment, including the names of students and their submission status.

startup.shFile: This script runs the reminder.sh script when executed.

Example Usage
