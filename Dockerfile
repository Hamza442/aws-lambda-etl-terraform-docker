FROM public.ecr.aws/lambda/python:3.9
# Copy requirements.txt from local to image COPY local_file_path image_file_path 
COPY requirements.txt requirements.txt 
RUN pip install -r requirements.txt
# copy code to custom docker image while it is getting build
COPY app ${LAMBDA_TASK_ROOT}/app
ENV PYTHONPATH=${LAMBDA_TASK_ROOT}/app

CMD ["app.lambda_ingest"]