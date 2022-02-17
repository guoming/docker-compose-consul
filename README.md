# Consul
## 启动
``` SHELL
docker-compose up -d
docker-compose exec consul-dc2-node1 consul join -wan consul-dc1-node1
```

## 访问
http://localhost:8500
