#!/bin/bash
echo "Attempting to create Kafka topic ..."
/opt/bitnami/kafka/bin/kafka-topics.sh --create \
  --bootstrap-server localhost:9092 \
  --replication-factor 1 \
  --partitions 1 \
  --topic ${'KAFKA_TOPIC'} \
  --if-not-exists

echo "Topic creation attempt completed"