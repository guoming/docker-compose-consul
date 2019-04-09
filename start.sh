mkdir -p /mnt/consul
chmod 777 /mnt/consul


docker node update --label-add consul=node1 sz-new-test
docker node update --label-add consul=node2 sz-itdev4
docker stack deploy --compose-file docker-compose.yml consul