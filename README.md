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

## 3. 配置 ACL

### 3.1. 获取管理令牌

生成管理令牌

``` sh
consul acl bootstrap
```

AccessorID:       ***
SecretID:         ***
Description:      Bootstrap Token (Global Management)
Local:            false
Create Time:      
Policies:
   00000000-0000-0000-0000-000000000001 - global-management

将令牌 SecretID 保存到环境变量 MANAGEMENT_TOKEN

``` sh
export MANAGEMENT_TOKEN=xxx
```

### 4.2. 创建策略

``` sh
SERVICE_POLICY_ID=$(curl --request PUT --header "X-Consul-Token: $MANAGEMENT_TOKEN" \
  --data '{
  "Name": "service-policy",
  "Description": "Grants read/write access to all service",
  "Rules": "service_prefix \"\" { policy = \"read\"} service_prefix \"\" { policy = \"write\"}",
  "Datacenters": ["dc1"]
}
' "http://localhost:8500/v1/acl/policy?name=service-policy" | jq -r .ID)
echo "Service Policy ID: $SERVICE_POLICY_ID"
```

### 4.3. 创建 token
``` sh
SERVICE_TOKEN=$(curl --request PUT --header "X-Consul-Token: $MANAGEMENT_TOKEN" \
  --data '{
  "Description": "service-token",
  "Policies": [
    {
      "Name": "service-policy"
    }
  ]
}' http://localhost:8500/v1/acl/token | jq -r .SecretID)
echo "Service Token: $SERVICE_TOKEN"
```

# 4. 测试

* 访问 UI
http://localhost:8500

* 服务注册
``` sh
curl --request PUT --header "X-Consul-Token: $SERVICE_TOKEN" \
  --data '{"id":"test","name":"test","address":"127.0.0.0","port":80,"tags":[]}' http://localhost:8500/v1/agent/service/register 
```
