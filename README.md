# Consul
## 1、创建网络
``` SHELL
docker network create consul
```
## 2、启动
``` SHELL
docker-compose -f docker-compose-dc1.yml up
docker-compose -f docker-compose-dc2.yml up
docker-compose exec consul-dc2-node1 consul join -wan consul-dc1-node1
```

## 3、访问
http://localhost:8500
