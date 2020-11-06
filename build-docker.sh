#! /bin/bash

docker build --tag pidns .
docker run --rm pidns