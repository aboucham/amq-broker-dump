FROM registry.redhat.io/amq7/amq-broker-init-rhel8:7.11.1-2
COPY ./config/ /amq/scripts/
