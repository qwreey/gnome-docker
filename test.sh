#!/bin/bash

docker compose build
docker compose up -d
docker compose exec gnome-docker journalctl -f
docker compose down
