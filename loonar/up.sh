#!/bin/bash
# Gera uma nova SUPERSET_SECRET_KEY e atualiza nos arquivos docker/.env e docker/.env-local

set -e

cd ..

# Solicita ao usuário a URL do host para o Superset
read -p "Informe a URL do host para acesso ao Superset (ex: superset.seudominio.com): " SUPERSET_HOST_URL

# Gera a chave secreta
SUPERSET_SECRET_KEY=$(openssl rand -base64 42 | tr -d '\n')

# Atualiza a chave nos arquivos .env
for file in docker/.env docker/.env-local; do
    if [ -f "$file" ]; then
        # Verifica o valor atual da chave
        CURRENT_KEY=$(grep '^SUPERSET_SECRET_KEY=' "$file" | cut -d'=' -f2-)
        if [ "$CURRENT_KEY" = "SUPERSET_SECRET_KEY" ]; then
            sed -i "s|^SUPERSET_SECRET_KEY=.*|SUPERSET_SECRET_KEY=$SUPERSET_SECRET_KEY|" "$file"
            echo "Atualizado SUPERSET_SECRET_KEY em $file"
        else
            echo "SUPERSET_SECRET_KEY já possui um valor customizado em $file: $CURRENT_KEY. Valor mantido."
        fi
    else
        echo "Arquivo $file não encontrado."
    fi
done

#Atualize o arquivo docker/nginx/nginx.conf alterando o valor de server_name para o valor de $SUPERSET_HOST_URL
NGINX_CONF_FILE="docker/nginx/nginx.conf"
if [ -f "$NGINX_CONF_FILE" ]; then
    sed -i "s|^    server_name .*;|    server_name $SUPERSET_HOST_URL;|" "$NGINX_CONF_FILE"
    echo "Atualizado server_name em $NGINX_CONF_FILE"
else
    echo "Arquivo $NGINX_CONF_FILE não encontrado."
fi

export COMPOSE_BAKE=true

# Remove imagens antigas para evitar erro de "already exists"
docker images --format '{{.Repository}}:{{.Tag}}' | grep '^superset' | xargs -r docker rmi -f

docker compose build --no-cache

