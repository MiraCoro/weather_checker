# Weather checker
## Goal: Demonstrate the ability to automate the deployment of dockerized application 

Terraform was used to accomplish the task's goals because it's suitable for building infrastructure more than Ansible.

Microservices architecture is used due to the specific goals - we need to download data repeatedly, and this job takes a little time, so provisioning and terminating ec2 instance each time would be resource and time-wasting. Also, microservice architecture will allow scaling of the infrastructure further by easily adding new functionalities. 
AWS Lambda function was used because it allows running code without provisioning additional resources and there is no need to manage them.
AWS base image for Lambda was used because it already has Python runtime and other components required to run the code already installed.
AWS CloudWatch Event was used to run the job scheduled by cron.
S3 bucket versioning is disabled because it allows overwriting the existing file when the new one must be uploaded.

Python app was created using Boto3 framework. The app downloads weather data using API from https://openweathermap.org/current, puts it to the created S3 bucket, parses JSON object, selects specified fields, creates HTML page with a table containing the selected data, then puts created page as index.html page alongside with predefined error.html to the bucket.
## Project structure

The root module includes four modules:
- AWS CloudWatch Event module creates CloudWatch Event rule with Lambda as the Event target. Event is scheduled to run every 1 hour.
- AWS ECR module creates a repository in AWS ECR, builds a Docker image with Python app, and uploads the image to ECR.
- AWS Lambda function module creates Lambda function, a role, and a policy for Lambda.
- AWS S3 website bucket module creates AWS S3 buckets configured for static website hosting, acl for the bucket to allow read-only public access, and bucket policy.

## Next steps to make this small application being ready for production

To be able to use the app in production the credential's securing problem must be solved. Although the credentials are not stored in Terraform files, and tfstate is not shared in the repo, we cannot consider it safe to have the file contains credentials locally. We need to modify the code to use encrypted storage, for example, HashiCorp Vault, or to assume an IAM role in AWS account, and in the process, generate a set of temporary credentials

Also, we can create a web app using API Gateway to expose the Lambda function to allow the user to make queries and select information that he wants to see by location and/or time.
A paid subscription is needed to be able to make bulk requests to https://openweathermap.org/