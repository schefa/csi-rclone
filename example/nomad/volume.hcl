id = "postgres"
name = "postgres"
type = "csi"
plugin_id = "rclone"
external_id = "postgres"

capability {
    access_mode     = "multi-node-multi-writer"
    attachment_mode = "file-system"
}

context {
    remote = "s3"
    remotePath = "postgres"
    s3-provider = "Minio"
    s3-endpoint = "http://minio.minio:9000"
    s3-access-key-id = "ACCESS_KEY_ID"
    s3-secret-access-key = "SECRET_ACCESS_KEY"
    uid = "999"
    gid = "999"
    umask = "0077"
}
