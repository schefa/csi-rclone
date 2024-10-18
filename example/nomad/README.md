# Nomad

This is an example of a PostgreSQL database running on Nomad with the data directory mounted as a bucket in MinIO.

## Prerequisites

A S3 compatible storage (e.g. MinIO) is deployed and accessible.

## Steps

1. Deploy the plugin as system job: `nomad job run plugin.hcl`
2. Register the volume: `nomad volume register volume.hcl` 
3. Deploy the Postgres job:  `nomad job run postgres.hcl`
