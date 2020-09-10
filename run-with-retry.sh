#!/bin/bash

# Keep track of how many times we've tried
CURRENT_TRY=0

# Create a full command string by adding the passed in onto goose
GOOSE_COMMAND="goose $COMMAND"

# For Debugging
echo "running $GOOSE_COMMAND"

# Loop until things work or we hit our try limit
until [[ $CURRENT_TRY -eq $CONN_RETRIES ]] || eval $GOOSE_COMMAND; do
    sleep 1
    ((CURRENT_TRY++))
done

# If we hit the max ammount of attempts exit with 1
if [[ $CURRENT_TRY -eq $CONN_RETRIES ]]; then
    exit 1
fi
