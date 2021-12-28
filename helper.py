import tempfile
import boto3
import os
import logging
import json

s3_client = boto3.client('s3')

def download_from_s3(bucket, object_name):
    tempfile_path = os.path.join(tempfile.gettempdir(), object_name.split('/')[-1])

    try:
        s3_client.download_fileobj(bucket, object_name, open(tempfile_path, 'wb'))
        return tempfile_path
    except Exception as e:
        logging.error(e)
        return None

def upload_to_s3(bucket, key, filename):
    print(f"Uploading bucket {bucket} file {filename} as {key}")
    try:
        s3_client.upload_fileobj(open(filename, "rb"), bucket, key)
        return True
    except Exception as e:
        logging.error(e)
        return False    