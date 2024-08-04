#!/bin/bash

docker compose build
docker compose up -d
docker compose exec arch-docker bash
docker compose down
