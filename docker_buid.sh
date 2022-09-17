# remove exisitng images
# first remove image that we tag to push into ecr becuase this images depends on base image
docker rmi 137300309230.dkr.ecr.us-east-1.amazonaws.com/aws-lambda-etl:latest

# remove base image
docker rmi aws-lambda-etl

# build custom image
docker build -t aws-lambda-etl .

export AWS_PROFILE=aws-lambda-etl-user

# login into aws ecr
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 137300309230.dkr.ecr.us-east-1.amazonaws.com

# tag the image
docker tag aws-lambda-etl:latest 137300309230.dkr.ecr.us-east-1.amazonaws.com/aws-lambda-etl:latest

# push local image to ecr
docker push 137300309230.dkr.ecr.us-east-1.amazonaws.com/aws-lambda-etl:latest

# when new image is pushed its tagged with latest and old image becomes un-tagged
# we want to make sure when new image is pushed lamdba function use that image
# image with latest tag will have latest changes

aws lambda update-function-code --function-name etl_pipelinne_ingestor --image-uri 137300309230.dkr.ecr.us-east-1.amazonaws.com/aws-lambda-etl:latest

aws lambda update-function-code --function-name etl_pipelinne_transformer --image-uri 137300309230.dkr.ecr.us-east-1.amazonaws.com/aws-lambda-etl:latest