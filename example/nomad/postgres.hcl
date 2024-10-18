job "postgres" {
  datacenters = ["*"]
  type = "service"
  group "postgres" {
 
    network {
      mode = "bridge"
      port "port_postgres_db" {
        host_network = "default"
      }
    }
 
    service {
      name = "postgres"
      port = "${NOMAD_ALLOC_PORT_port_postgres_db}"
      connect {
        sidecar_service {
          proxy {
            upstreams {
                destination_name = "postgres-service"
                local_bind_port  = 5432
            }
          }
        }
      }
    }
 
    volume "postgres" {
      type            = "csi"
      source          = "postgres"
      attachment_mode = "file-system"
      access_mode     = "multi-node-multi-writer"
    }

    task "postgres" {
      driver = "docker"
      config {
        image = "postgres"
        network_mode = "host" 
      }
      env = {
        PORT              = "${NOMAD_ALLOC_PORT_port_postgres_db}"
        POSTGRES_DB       = "postgres"
        POSTGRES_USER     = "postgres"
        POSTGRES_PASSWORD = "postgres"
        PGDATA            = "/var/lib/postgresql/data"
      }
      volume_mount {
        volume      = "postgres"
        destination = "/var/lib/postgresql/data"
        read_only   = false
      }
      resources {
        cpu    = 1000
        memory = 1024
      }
    }

  }
}
