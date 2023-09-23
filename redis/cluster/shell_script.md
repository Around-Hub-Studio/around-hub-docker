```shell
## host
docker compose -p "redis-cluster" up -d

docker exec -it redis-master-1 bash

## host >> container "redis-master-1"
redis-cli -c -p 7001

## host >> container "redis-master-1" >> master-node
cluster info
```