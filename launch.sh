#!/bin/bash

docker run --name aim --hostname aim -d -p 8080:8080 \
	-e DB_HOST=192.168.8.107 -e DB_PORT=3306 -e DB_USER=root -e DB_PASS=root -e DB_NAME=aim \
	docpath/aim

