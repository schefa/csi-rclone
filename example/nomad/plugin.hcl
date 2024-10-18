job "plugin-rclone" {
    datacenters = ["*"]
    type        = "system"

    group "nodes" {
        task "plugin" {
            driver = "docker"
            resources {
                memory = 256
            } 

            config {
                image = "docker.io/wunderio/csi-rclone:latest"

                args = [
                    "/bin/csi-rclone-plugin",
                    "--endpoint=unix://csi/csi.sock",
                    "--nodeid=${node.unique.name}",
                    "--v=1",
                ]

                privileged = true
            }

            csi_plugin {
                id          = "rclone"
                type        = "monolith"
                mount_dir   = "/csi"
            }
        }
    }
}