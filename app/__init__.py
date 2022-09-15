# This is driver program of our lambda function
import os
from util.bookmark import get_job_details, \
    get_next_filename, save_job_run_details, \
    get_job_start_time
from extract import upload_file_to_s3
from transform import transform_to_parquet

def ingest_to_s3():
    # set env
    bucket_name = os.environ.get('BUCKET_NAME')
    folder = os.environ.get('FOLDER')
    # get last executed job details
    job_details = get_job_details('lamdba-etl-job')
    # get info about which file to execute next
    job_start_time, next_file = get_next_filename(job_details)
    # make a request to API and save file on s3
    job_run_details = upload_file_to_s3(next_file, bucket_name, folder)
    # save job executionn details
    save_job_run_details(job_details, job_run_details, job_start_time)

    return job_run_details
# lamdba hanlder
def lambda_ingest(event, context):
    job_run_details = ingest_to_s3()

    return {
        'status': 200,
        'body': job_run_details
    }
# wrapper to call transform to parquet function
def transform_to_parquet(file_name):
    bucket_name = os.environ.get('BUCKET_NAME')
    target_folder = os.environ.get('TARGET_FOLDER')

    job_start_time = get_job_start_time()
    job_details = get_job_details('lambda-etl')
    job_run_details =  transform_to_parquet(file_name,bucket_name,target_folder)
    
    save_job_run_details(job_details,job_run_details, job_start_time)

    return job_run_details

# lambda hanlder for second lambda function
# this function will be trigger when ever a file is uploaded on s3 bucket
# event will be triggered on s3 bucket
def lambda_transform(event,context):
    file_name = event['jobRunDetails']['last_run_file_name']
    job_run_details = transform_to_parquet(file_name)

    return {
        'statusCode': 200,
        'statusMessage' : 'File Transformed Successfully',
        'jobRunDetails': job_run_details
    }