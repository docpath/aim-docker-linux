#!/bin/bash

docker run --name aim --detach -p 8080:8080 -e DB_HOST=192.168.8.109 -e DB_PORT=3306 -e DB_USER=root -e DB_PASS=root -e DB_NAME=aim -e LICENSE_ADDRESS=192.168.8.109 
-e LICENSE_PORT=1765 -e TRANSACTION_ID=b0af24c2-718e-4abe-8c28-246f5c038818 -e SHUTDOWN_SESSION=yes docpath/aim