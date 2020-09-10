#!/bin/bash

# Save credentials to disk
echo $GCP_CREDENTIAL_JSON > /tmp/credentials.json

# Start cloudsql proxy and run goose retry script
/cloud_sql_proxy -credential_file /tmp/credentials.json -instances=$CLOUDSQL_INSTANCE & /run-with-retry.sh
