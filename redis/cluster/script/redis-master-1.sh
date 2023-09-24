#!/bin/sh

# Start the first Redis server with the specified configuration file
redis-server /etc/redis.conf &

# Sleep for a moment to allow the server to start
sleep 5

# Create the Redis cluster with the specified nodes
redis-cli --cluster create 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 --cluster-yes

echo "Master node setup is complete."
sleep 5

# Add nodes as slaves to existing nodes
redis-cli --cluster add-node 127.0.0.1:7004 127.0.0.1:7001 --cluster-slave
redis-cli --cluster add-node 127.0.0.1:7005 127.0.0.1:7002 --cluster-slave
redis-cli --cluster add-node 127.0.0.1:7006 127.0.0.1:7003 --cluster-slave

# Print a message indicating the cluster setup is complete
echo "Redis cluster setup is complete."

# Keep the script running in the foreground
touch /dev/null
tail -f /dev/null
