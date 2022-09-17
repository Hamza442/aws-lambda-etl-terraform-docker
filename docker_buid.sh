# remove exisitng images
# first remove image that we tag to push into ecr becuase this images depends on base image
docker rmi ${ECR_DOCKER_IMAGE_URI}

# remove base image
docker rmi aws-lambda-etl

# build custom image
docker build -t aws-lambda-etl .

export AWS_PROFILE=aws-lambda-etl-user

# login into aws ecr
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ECR_REPOSITORY}

# tag the image
docker tag aws-lambda-etl:latest ${ECR_DOCKER_IMAGE_URI}

# push local image to ecr
docker push ${ECR_DOCKER_IMAGE_URI}

# when new image is pushed its tagged with latest and old image becomes un-tagged
# we want to make sure when new image is pushed lamdba function use that image
# image with latest tag will have latest changes

aws lambda update-function-code --function-name etl_pipelinne_ingestor --image-uri ${ECR_DOCKER_IMAGE_URI}

aws lambda update-function-code --function-name etl_pipelinne_transformer --image-uri ${ECR_DOCKER_IMAGE_URI}