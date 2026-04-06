# SP26 CS315 Lab 8 - Marc Robertson

Author: Marc Robertson
Title: Dockerize Al Folio Resume
Description: Simple Docker setup for running a Jekyll portfolio site.
Date Last Modified: 03/25/2026

## Prerequisites

- Docker Desktop installed and running
- Docker Compose available (`docker compose`)

## Run the project

From the repository root:

```bash
docker compose build
docker compose up
```

Open:

- http://localhost:4000

## Development mode (live reload)

```bash
docker compose --profile dev up --build
```

Open:

- http://localhost:4001

## Stop the project

In the same terminal:

```bash
Ctrl+C
```

Or in another terminal:

```bash
docker compose down
```

## Notes

- The portfolio source lives in the `Portfolio/` folder.
- If Docker is not running, compose commands will fail.
