import boto3
from botocore.exceptions import ClientError
import pathlib
import os

AWS_REGION = "us-west-2"
client = boto3.client("s3", region_name=AWS_REGION)
s3Res = boto3.resource('s3')
bucket_name = "scaling-fastapi-bucket-1"
location = {'LocationConstraint': AWS_REGION}

if(s3Res.Bucket(bucket_name)in s3Res.buckets.all()):
    print('S3 Bucket exist')
else:
    response = client.create_bucket(Bucket=bucket_name, CreateBucketConfiguration=location)
    print("Amazon S3 bucket has been created with the name: " + bucket_name + ' in region: ' + AWS_REGION)

s3C = boto3.client("s3")
object_name = "script.zip"
file_name = os.path.join(pathlib.Path(__file__).parent.resolve(), "script.zip")
response = s3C.upload_file(file_name, bucket_name, object_name)
print('File is Uploaded')