#!/bin/bash

sudo docker compose build ; sudo docker compose up -d
sudo docker compose exec arch-docker bash
sudo docker compose down
