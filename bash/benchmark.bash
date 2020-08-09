#! /bin/bash

wrk -t12 -c400 -d30s http://localhost:10001/hello/tim/46