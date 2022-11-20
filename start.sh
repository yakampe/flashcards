#!/bin/sh

docker rmi flash-cards-flutter -f
docker rmi flash-cards-java -f

# # start the container stack
# # (assumes the caller has permission to do this)
docker compose up -d

#Send json
curl -i \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-X POST --data @./flash-cards.json "http://localhost:8080/api/flashcards"

open http://localhost:5000/
start http://localhost:5000/
