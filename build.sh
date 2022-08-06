#!/bin/bash

if [ -z $1  ]; then
  echo "Pass tag"
  exit
fi

TAG=$1
echo "TAG=${TAG}"

IMAGE_ID=`docker images phpmyfunction --format "table {{.ID}}" | grep -v "IMAGE ID"`
echo "IMAGE_ID=${IMAGE_ID}"

if [ -z $IMAGE_ID ]; then
  echo "IMAGE_ID is not set"
  exit
fi

if [ -z $AWS_ACCOUNT_ID ]; then
  echo "AWS_ACCOUNT_ID is not set"
  exit
fi
echo "AWS_ACCOUNT_ID=${AWS_ACCOUNT_ID}"

docker build -t phpmyfunction .
aws ecr get-login-password --region ap-southeast-1 --profile production | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.ap-southeast-1.amazonaws.com
docker tag 8e15f54fcc54 ${AWS_ACCOUNT_ID}.dkr.ecr.ap-southeast-1.amazonaws.com/phpmyfunction:${TAG}
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.ap-southeast-1.amazonaws.com/phpmyfunction:${TAG}
