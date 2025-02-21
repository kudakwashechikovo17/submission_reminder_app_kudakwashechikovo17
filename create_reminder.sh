#!/bin/bash

# Function to input name
read -p "Please Put Name (ZITA RAKO): " UserName
dirName="submission_reminder_${UserName}"

mkdir -p "$dirName"
cd "$dirName" || { echo "Cannot change directory $dirName"; exit 1; }

mkdir -p app modules assets config

touch app/reminder.sh
touch modules/functions.sh
touch assets/submissions.txt
touch config/config.env
touch startup.sh

# Create reminder.sh script
cat << 'EOF' > ./app/reminder.sh
#!/bin/bash

# Determine the directory of the current script
SCRIPT_D="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source environment variables and helper functions
source "$SCRIPT_D/../config/config.env"
source "$SCRIPT_D/../modules/functions.sh"

# Path to the submissions file
submissions_file="$SCRIPT_D/../assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions "$submissions_file"
EOF

# Create functions.sh script
cat << 'EOF' > ./modules/functions.sh
#!/bin/bash

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

        # Check if assignment matches and status is "not submitted"
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

# Create config.env file
cat << 'EOF' > ./config/config.env
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# Create submissions.txt file
cat << 'EOF' > ./assets/submissions.txt
KUDA, Shell Navigation, submitted
MUFARO, Shell Navigation, not submitted
KUKU, Shell Navigation, not submitted
TAVONGA, Shell Navigation, submitted
MUMU, Shell Navigation, submitted
EOF

# Create startup.sh file
echo 'bash app/reminder.sh' > ./startup.sh

# Make the scripts executable
chmod +x ./app/reminder.sh
chmod +x ./modules/functions.sh
chmod +x ./startup.sh

