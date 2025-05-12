# Deploy

## Requirements

- Ubuntu 22.04 with root access

## Files in this directory

| File                        | Description                                                      |
|-----------------------------|------------------------------------------------------------------|
| README.md                   | Instructions and documentation for deployment and setup.          |
| install-docker-root.sh      | Script to install Docker with root privileges.                   |
| install-docker-rootless.sh  | Script to install Docker in rootless mode (no root required).    |
| uninstall-docker.sh         | Script to uninstall Docker from the system.                      |

## Steps to install Docker

1. Clone the repository

    ```bash
    cd /opt
    git clone https://github.com/loonar-morpheus/superset.git
    cd superset
     ```

2. Create the solution configuration file

    ```bash
    cd docker
    cp .env-local.sample .env-local
    nano .env-local
    ```

3. Change the configuration variables values to meet the implementation needs. Updated the SUPERSET_SECRET_KEY with the out value generated:

    ```bash
    openssl rand -base64 42 | tr -d '\n'
    ```

4. In the root directory build the solution

    ```bash
    docker-compose build --no-cache

## Maintenance

- Run with reasonable period the command below to delete containers, volumes, networks and unused images:

```bash
docker system prune -a --volumes -f
```
