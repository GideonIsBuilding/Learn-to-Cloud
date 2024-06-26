#!/usr/bin/bash

green_echo() {
    echo -e "\e[32m$1\e[0m"
}

red_echo() {
    echo -e "\e[31m$1\e[0m"
}

#----------------------
# Install Pipe Viewer
#----------------------
green_echo "Installing Pipe Viewer to monitor data being sent"
sudo apt install pv

#----------------------
# Creating an S3 Bucket
#----------------------
read -rp 'S3 Bucket Name: ' bucket
read -rp 'Region: ' region
green_echo "Creating an S3 bucket..."
aws s3 mb "s3://$bucket" --region "$region"

#--------------------
# Check for S3 Bucket
#--------------------
if aws s3api head-bucket --bucket "$bucket" 2>/dev/null; then
    green_echo "S3 bucket created successfully!"
else
    red_echo "Failed to create S3 bucket."
    exit 1
fi

#-----------
# File Check
#-----------
green_echo "Checking file..."
if [ ! -f "$1" ]; then
    red_echo "File does not exist."
    exit 1
fi

#-----------------------
# File Upload & Feedback
#-----------------------
green_echo "Uploading & getting feedback..."
file_size=$(stat -c %s "$1")
if ! pv -p "$1" | aws s3 cp "$1" "s3://$bucket/$(basename "$1")" --storage-class STANDARD --expected-size "$file_size"; then
    red_echo "Upload failed."
else
    green_echo "Upload successful."
fi

#------------------------------------
# Sharing Objects with Presigned URLs
#------------------------------------
green_echo "Now generating shareable link to upload..."
aws s3 presign "s3://$bucket/$(basename "$1")" --expires-in 604800 --region "$region" --endpoint-url "https://s3.$region.amazonaws.com"