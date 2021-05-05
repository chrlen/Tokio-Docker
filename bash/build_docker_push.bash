#! /bin/bash

docker build -t localhost:5000/tokio-docker:latest . --no-cache
docker push localhost:5000/tokio-docker:latest
docker run localhost:5000/tokio-docker:latest

