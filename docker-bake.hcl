group "default" {
  targets = [
    "nginx",
    "redis",
    "db",
    "superset",
    "superset-websocket",
    "superset-init",
    "superset-node",
    "superset-worker",
    "superset-worker-beat",
    "superset-tests-worker"
  ]
}

target "nginx" {
  context = "."
  dockerfile = "Dockerfile"
  tags = ["nginx:latest"]
}

target "redis" {
  context = "."
  dockerfile = "Dockerfile"
  tags = ["redis:7"]
}

target "db" {
  context = "."
  dockerfile = "Dockerfile"
  tags = ["postgres:16"]
}

target "superset" {
  context = "."
  dockerfile = "Dockerfile"
  target = "dev"
  tags = ["superset:latest"]
}

target "superset-websocket" {
  context = "./superset-websocket"
  dockerfile = "Dockerfile"
  tags = ["superset-websocket:latest"]
}

target "superset-init" {
  context = "."
  dockerfile = "Dockerfile"
  target = "dev"
  tags = ["superset:latest"]
}

target "superset-node" {
  context = "."
  dockerfile = "Dockerfile"
  target = "superset-node"
  tags = ["superset-node:latest"]
}

target "superset-worker" {
  context = "."
  dockerfile = "Dockerfile"
  target = "dev"
  tags = ["superset:latest"]
}

target "superset-worker-beat" {
  context = "."
  dockerfile = "Dockerfile"
  target = "dev"
  tags = ["superset:latest"]
}

target "superset-tests-worker" {
  context = "."
  dockerfile = "Dockerfile"
  tags = ["superset:latest"]
}
