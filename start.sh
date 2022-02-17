docker-compose up -d
docker exec -it consul-dc2-node1 consul join -wan consul-dc1-node1