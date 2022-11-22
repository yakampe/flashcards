#!/bin/sh

flutter_image_name="flash-cards-flutter"
java_image_name="flash-cards-java"

echo "Stopping containers"
docker stop $(docker ps -a -q  --filter ancestor=$flutter_image_name)
docker stop $(docker ps -a -q  --filter ancestor=$java_image_name)
echo "Containers stopped"

docker rmi $flutter_image_name -f
docker rmi $java_image_name -f

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
