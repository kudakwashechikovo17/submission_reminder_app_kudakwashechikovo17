#!/bin/bash

mkdir -p submission_reminder_app

cd submission_reminder_app
mkdir -p app modules assets config

touch app/reminder.sh
touch modules/functions.sh
touch assets/submissions.txt
touch config/config.env
touch startup.sh

echo '#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file' > ./app/reminder.sh
echo '#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}' > ./modules/functions.sh

echo '# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2' > ./config/config.env

cp ../submissions.txt ./assets/submissions.txt
echo 'Kuda, Shell Navigation, submitted
Kuda, Shell Navigation, not submit 
Taku, Shell Navigation, not submitted 
Mino, Shell Navigation, submitted
Tino, Shell Navigation, submitted' >> ./assets/submissions.txt

chmod +x ./app/reminder.sh
chmod +x ./modules/functions.sh
chmod +x ./startup.sh

echo '#!/bin/bash
./app/reminder.sh' > startup.sh
