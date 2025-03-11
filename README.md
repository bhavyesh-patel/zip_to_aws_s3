# zip_to_aws_s3

Action for zipping files and folders and push zipped file to AWS S3 using AWS Access Key & AWS Secret Access Key

**Note: This is created for learning purpose but I will try to improve as time goes so for now you can try out v0.3-alpha version.**

## Usage

The only requirement is to use the official `actions/checkout@v4` first so the zip action has access to the repo files.

```yaml
name: Zip the Lambda code and upload to S3

on: workflow_dispatch # e.g. for manual trigger

jobs:
  ci:
    name: Zip the lambda code and upload to S3
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4

    - name: Authenticate with AWS
      uses: bhavyesh-patel/zip_to_aws_s3@v0.3-alpha
      with:
        zip-source: ./src
        zip-file: hello-world.zip
        aws-access-key: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws-default-region: us-west-2 # e.g. Default AWS Region
        aws-s3-bucket: test-bucket-hello-0458392 # e.g. The bucket name where you want to upload
```
## Inputs

#### `zip-source`

Files or directories to zip, relative to GITHUB_WORKSPACE environmental variable.

- **Required:** Yes

#### `zip-file`

Name of the output zip file.

- **Required:** Yes

#### `aws-access-key`

AWS ACCESS KEY for authentication. It must be refer from GITHUB SECRETS.

- **Required:** Yes

#### `aws-secret-access-key`

AWS SECRET ACCESS KEY for authentication. It must be refer from GITHUB SECRETS.

- **Required:** Yes

#### `aws-default-region`

AWS Default Region where your resources are placed.

- **Required:** Yes

#### `aws-s3-bucket`

AWS S3 Bucket Name where you want to upload your zip file.

- **Required:** Yes

If for example, you do the following:

```yaml
- uses: bhavyesh-patel/zip_to_aws_s3@v0.3-alpha
  with:
    zip-source: ./src
    zip-file: hello-world.zip
    aws-access-key: ${{ secrets.AWS_ACCESS_KEY_ID }}
    aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    aws-default-region: us-west-2
    aws-s3-bucket: test-bucket-hello-0458392
```