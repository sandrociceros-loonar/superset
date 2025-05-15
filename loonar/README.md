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

2. Change the configuration variables values to meet the implementation needs.

    ```bash
    cd docker
    nano .env-local
    ```

3. Copy certificate files superset.crt and superset.key

    ```bash
    cd "$(git rev-parse --show-toplevel)" # Go to root directory of git repository
    cd docker/nignx/certs
    # copy files to this directory
    ```

4. Go to the Loonar directory to configure NGINX, build the images and deploy the solution. Beware when responding to script prompts:

    ```bash
    cd "$(git rev-parse --show-toplevel)" # Go to root directory of git repository
    cd loonar
    ./up.sh    
    ```

## Maintenance

- Run with reasonable period the command below to delete containers, volumes, networks and unused images:

```bash
docker system prune -a --volumes -f
```
