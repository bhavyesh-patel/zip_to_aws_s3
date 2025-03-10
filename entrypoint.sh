#!/bin/sh

# Define Variables for ZIP
ZIP_SOURCE=$1
ZIP_FILE=$2

# Define Variables for AWS Auth and S3
AWS_ACCESS_KEY=$3
AWS_SECRET_ACCESS_KEY=$4
AWS_DEFAULT_REGION=$5
AWS_S3_BUCKET=$6
AWS_S3_PATH="s3://$AWS_S3_BUCKET/$ZIP_FILE"

# Function to create a zip from the source folder

create_zip() {
    echo "Creating Zip archive..."
    zip -r "$ZIP_FILE" "$ZIP_SOURCE"

    if [[ $? -eq 0 ]]; then
        echo "ZIP file created: $ZIP_FILE"
    else
        echo "Failed to create ZIP file" >&2
        exit 1
    fi
}

# Function to configure AWS CLI

configure_aws() {
    echo "Configuring AWS CLI..."
    aws configure set aws_access_key_id "$AWS_ACCESS_KEY"
    aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
    aws configure set region "$AWS_DEFAULT_REGION"

    if [[ $? -eq 0 ]]; then
        echo "AWS CLI configured successfully!!"
    else
        echo "Failed to configure AWS CLI" >&2
        exit 1
    fi
}

# Function to upload zip to S3

upload_to_s3() {
    echo "Uploading $ZIP_FILE to S3..."
    aws s3 cp "$ZIP_FILE" "$AWS_S3_PATH"

    if [[ $? -eq 0 ]]; then
        echo "File uploaded successfully to $AWS_S3_PATH"
    else
        echo "Failed to upload file" >&2
        exit 1
    fi
}

# Main Funtion

main() {
    create_zip
    configure_aws
    upload_to_s3
}

# Execute main function

main