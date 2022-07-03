job "moodle" {
  datacenters = ["dc1"]
  type        = "service"

  group "app" {
    count = 1

    network {
      mode = "host"
      port "app" {
        to     = 80
        static = 80
      }
    }

    task "app" {
      driver = "docker"

      config {
        network_mode = "host"
        image        = "prasta/moodle:latest"
        ports        = ["app"]
      }

      resources {
        cores  = 1
        memory = 512
      }
    }
  }

  group "mariadb" {
    count = 1

    network {
      mode = "host"
      port "db" {
        to     = 3306
        static = 3306
      }
    }

    task "mariadb" {
      driver = "docker"
      env {
        MARIADB_ROOT_PASSWORD = "m00dle"
        MARIADB_DATABASE = "moodle"
        MARIADB_USER = "moodle"
        MARIADB_PASSWORD = "m00dle"
      }
      config {
        image = "mariadb:latest"
        ports = ["db"]
      }

      resources {
        cores  = 1
        memory = 256
      }
    }
  }
}