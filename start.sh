mkdir -p /mnt/consul/node1
mkdir -p /mnt/consul/node2
mkdir -p /mnt/consul/node3

chmod 777 /mnt/consul/node1
chmod 777 /mnt/consul/node2
chmod 777 /mnt/consul/node3
docker stack deploy --compose-file docker-compose.yml consul