#!/bin/bash -e

find_container_id() {
  echo $(docker ps \
    --filter "status=running" \
    --filter "label=com.docker.compose.project=kafkajs" \
    --filter "label=com.docker.compose.service=kafka1" \
    --no-trunc \
    -q)
}

if [ -z "$TOPIC" ]; then
  echo -d "TOPIC is mandatory"
  exit 1
fi

if [ -z "$PARTITIONS" ]; then
  echo -d "PARTITIONS is mandatory"
  exit 1
fi

docker exec \
  $(find_container_id) \
  bash -c "/opt/kafka/bin/kafka-topics.sh --zookeeper zk:2181 --alter --topic ${TOPIC} --partitions ${PARTITIONS}"
