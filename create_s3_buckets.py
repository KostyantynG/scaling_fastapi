import boto3

AWS_REGION = "us-west-2"
client = boto3.client("s3", region_name=AWS_REGION)
s3Res = boto3.resource("s3")
bucket_name = "scaling-fastapi-bucket-1"
bucket_name_backend = "scaling-fastapi-backend"
location = {'LocationConstraint': AWS_REGION}

# Create s3 bucket for script
if(s3Res.Bucket(bucket_name)in s3Res.buckets.all()):
    print("S3 Bucket already exists")
else:
    response = client.create_bucket(Bucket=bucket_name, CreateBucketConfiguration=location)
    print(f"S3 bucket has been created with the name \"{bucket_name}\" in region \"{AWS_REGION}\"")

# Create s3 bucket for Terraform backend
if(s3Res.Bucket(bucket_name_backend)in s3Res.buckets.all()):
    print('S3 Bucket already exists')
else:
    response = client.create_bucket(Bucket=bucket_name_backend, CreateBucketConfiguration=location)
    print(f"S3 bucket has been created with the name \"{bucket_name_backend}\" in region \"{AWS_REGION}\"")


