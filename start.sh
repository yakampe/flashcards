#!/bin/sh

docker rmi flash-cards-flutter -f
docker rmi flash-cards-java -f

# # start the container stack
# # (assumes the caller has permission to do this)
docker compose up -d

#Wait ill the API is up and running
echo "Waiting for back-end to be up"
isUnhealthy=''
while [ -z "$isUnhealthy"  ]
do
    isUnhealthy=$(curl -si http://localhost:8080/)
    sleep 1
done
echo "Backend up and running"

#Send json
curl -i \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-X POST --data @./flash-cards.json "http://localhost:8080/api/initiate"

open http://localhost:5000/
start http://localhost:5000/
