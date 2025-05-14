#!/usr/bin/env bash
set -euo pipefail

# Caminho do docker-compose
COMPOSE_FILE="docker-compose.yml"
PROJECT_NAME="superset"

cd ..

# Confirmação do usuário
read -rp "ATENÇÃO: Isso irá remover TODOS os dados persistidos, containers, volumes, redes, imagens criadas pelo docker-compose deste projeto E TAMBÉM APAGARÁ ARQUIVOS DO HOST MONTADOS COMO VOLUMES. Deseja continuar? (s/n): " CONFIRM
if [[ "$CONFIRM" != "s" ]]; then
  echo "Operação cancelada."
  exit 1
fi

# Para e remove containers, redes, volumes e imagens criadas pelo compose
echo "Parando e removendo containers, redes, volumes e imagens..."
docker compose -f "$COMPOSE_FILE" down --volumes --remove-orphans --rmi all

# Remove volumes nomeados explicitamente (caso não tenham sido removidos)
for VOLUME in superset_home db_home redis; do
  if docker volume inspect "${PROJECT_NAME}"_${VOLUME} &>/dev/null; then
    echo "Removendo volume: ${PROJECT_NAME}_${VOLUME}"
    docker volume rm "${PROJECT_NAME}"_${VOLUME} || true
  elif docker volume inspect "$VOLUME" &>/dev/null; then
    echo "Removendo volume: $VOLUME"
    docker volume rm "$VOLUME" || true
  fi
done

# Remove arquivos e pastas do host montados como bind mounts
HOST_MOUNTS=(
  "./docker"
  "./superset"
  "./superset-frontend"
  "./tests"
  "./docker/nginx/nginx.conf"
  "./docker/nginx/templates"
  "./docker/nginx/certs"
  "./docker/docker-entrypoint-initdb.d"
  "./superset-websocket"
)

for PATH in "${HOST_MOUNTS[@]}"; do
  if [ -e "$PATH" ]; then
    echo "Removendo arquivo/pasta do host: $PATH"
    rm -rf "$PATH"
  fi
done

echo "Reset concluído. Todos os dados persistidos, recursos docker e arquivos do host montados como volumes foram removidos."
