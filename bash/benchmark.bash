#! /bin/bash

wrk -t12 -c400 -d30s http://localhost:8080/10/50/