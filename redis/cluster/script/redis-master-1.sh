#!/bin/sh

# Start the first Redis server with the specified configuration file
redis-server /etc/redis.conf &

# Sleep for a moment to allow the server to start
sleep 5

# Create the Redis cluster with the specified nodes
redis-cli --cluster create host.docker.internal:7001 host.docker.internal:7002 host.docker.internal:7003 --cluster-yes

echo "Master node setup is complete."
sleep 5

# Add nodes as slaves to existing nodes
redis-cli --cluster add-node host.docker.internal:7004 host.docker.internal:7001 --cluster-slave
redis-cli --cluster add-node host.docker.internal:7005 host.docker.internal:7002 --cluster-slave
redis-cli --cluster add-node host.docker.internal:7006 host.docker.internal:7003 --cluster-slave

# Print a message indicating the cluster setup is complete
echo "Redis cluster setup is complete."

# Keep the script running in the foreground
touch /dev/null
tail -f /dev/null
