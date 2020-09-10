FROM gcr.io/cloudsql-docker/gce-proxy as cloudsql-proxy

FROM golang:1.14

# Copy cloud-proxy binary
COPY --from=cloudsql-proxy /cloud_sql_proxy /cloud_sql_proxy

# copy entrypoint script
COPY entrypoint.sh /

# Get goose command
RUN go get -u github.com/pressly/goose/cmd/goose

# Copy over goose retry script script and env for the argument
COPY run-with-retry.sh /
ENV COMMAND="enter somthing"

# Execute cloudsql proxy wrapper
ENTRYPOINT /entrypoint.sh
