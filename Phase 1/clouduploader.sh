#!/usr/bin/bash

green_echo() {
    echo -e "\e[32m$1\e[0m"
}

#----------------------
# Creating an S3 Bucket
#----------------------
green_echo "Creating an S3 bucket..."
aws s3 mb s3://ltcbuckets --region us-east-1
green_echo "S3 bucket created!"

#-----------
# File Check
#-----------
green_echo "Checking file..."
if [ ! -f "$1" ]; then
    green_echo "File does not exist."
    exit 1
fi

#-----------------------
# File Upload & Feedback
#-----------------------
green_echo "Uploading & getting feedback..."
if ! aws s3 cp "$1" s3://ltcbuckets/"$(basename "$1")" --storage-class STANDARD; then
    green_echo "Upload failed."
else
    green_echo "Upload successful."
fi
