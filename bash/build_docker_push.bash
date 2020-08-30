#! /bin/bash

docker build -t localhost:5000/rust.brimborium.xyz:latest . --no-cache
docker push localhost:5000/rust.brimborium.xyz:latest
docker run localhost:5000/rust.brimborium.xyz:latest

