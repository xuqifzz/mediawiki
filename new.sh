#!/bin/bash
mkdir -p ./backup/db
docker stack deploy -c stack1.yml mediawiki