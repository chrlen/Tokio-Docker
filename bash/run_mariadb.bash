#! /bin/bash

docker stop rust_rest_mdb
docker run --rm --net=host --name rust_rest_mdb -e MYSQL_ROOT_PASSWORD=not-really-secret -d mariadb:latest




