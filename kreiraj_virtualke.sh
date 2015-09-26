#!/bin/bash
KEY="Klaudovanje"
BOOTIMG="d34bafd1-e54f-41e7-a504-c6dd317af033"
ZONE="nova"
FLAVOR="m1.small"

source ~/admin-openrc.sh 

for RUN in {1..20}; do
    echo "Kreiram virtualku ${RUN}""
    VMUUID=$(nova boot \
        --image "${BOOTIMG}" \
        --flavor "${FLAVOR}" \
        --availability-zone "${ZONE}" \
        --nic net-id=5c492faa-a177-470a-9e74-fe030bd5f56e \
        --key-name "${KEY}" \
        --user-data skripta.sh \
        "VPS-${RUN}-${ZONE}" | awk '/id/ {print $4}' | head -n 1);

    until [[ "$(nova show ${VMUUID} | awk '/status/ {print $4}')" == "ACTIVE" ]]; do
        :
    done

    echo "VM ${RUN} (${VMUUID}) is active."

done
