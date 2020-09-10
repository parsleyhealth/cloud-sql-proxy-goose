#!/bin/bash

# Save credentials to disk
echo $GCP_CREDENTIAL_JSON > /tmp/credentials.json

# Start a headless cloudsql proxy and capture pid
/cloud_sql_proxy -credential_file /tmp/credentials.json -instances=$CLOUDSQL_INSTANCE & echo $! > /tmp/cloud_sql_proxy.pid

# Run goose command with retry and capture result
/run-with-retry.sh
result=$?

# shut down cloudsql pid
kill -s TERM $(cat /tmp/cloud_sql_proxy.pid)

# Exit with goose retry result
exit $result
