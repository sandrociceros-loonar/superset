#!/bin/bash
# Script para verificar e instalar o sqlcmd no Ubuntu

if ! command -v sqlcmd &> /dev/null; then
    echo "sqlcmd não encontrado. Instalando..."
    # Importa a chave pública da Microsoft (método recomendado)
    curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
    # Usa o repositório do Ubuntu 22.04 (jammy) para compatibilidade
    sudo tee /etc/apt/sources.list.d/mssql-release.list > /dev/null <<EOF
# Microsoft SQL Server Tools for Ubuntu 22.04 (jammy)
deb [arch=amd64] https://packages.microsoft.com/ubuntu/22.04/prod jammy main
EOF
    sudo apt-get update
    sudo ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
    echo "sqlcmd instalado com sucesso. Abra um novo terminal para usar o comando."
else
    echo "sqlcmd já está instalado."
fi

# Conexão automática ao SQL Server após instalação
SQL_SERVER="DC1MRTPRD04\\SQLEXPRESS"
DATABASE="SondaHybrid"
USER="morpheus-service"
PASSWORD="M0rph3us#2024"

if command -v sqlcmd &> /dev/null; then
    echo "Conectando ao SQL Server..."
    sqlcmd -S "$SQL_SERVER" -d "$DATABASE" -U "$USER" -P "$PASSWORD"
fi
