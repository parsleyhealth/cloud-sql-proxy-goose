# cloud-sql-proxy-goose

## Summary

A GitHub Action that uses a Docker image to create a temporary cloud_sql_proxy connection to a GCP CloudSQL Instance and runs a [goose](https://github.com/pressly/goose) command.

## Inputs

### `goose-command`

**Required** The goose command to run. Must include Database connection string and command.

**Note** For connection string host and port use `localhost:PORT` where `PORT` is the same specified in `cloud-sql-instance` input.

**Note** `cloud_sql_proxy` Handles E2E encryption for you and does not support TLS when connecting to it so ensure SSL is turned off for your connection string.

### `gcp-credential-json`

**Required** Contents of a service account GCP Key JSON that has `Cloud SQL Client` role.

### `cloud-sql-instance`

**Required** Comma delimited list of instances to open. Format `gcp_project:region:instance=tcp:PORT`.

See [cloudsql-proxy](https://github.com/GoogleCloudPlatform/cloudsql-proxy) command documentation for more info.

### `retries`

The number of times to retry the `goose` command. Defaults: 10

**Note** This should always be more than 1 as it takes cloud_sql_proxy a second or two to make a connection.

### `migrations-dir`

Directory holding migrations relative to repository root.

## Example usage

```yaml
uses: parsleyhealth/cloud-sql-proxy-goose@v2
with:
  goose-command: postgres "user=${{ env.DB_USER }} password=${{ env.DB_PASSWORD }} dbname=${{ env.DB_NAME }} port=1234 sslmode=disable host=localhost" up
  retries: '10'
  gcp-credential-json: ${{ secrets.GCP_CREDS }}
  cloud-sql-instance: 'my-project:us-east1:my-db=tcp:1234'
  migrations-dir: '/migrations'
```