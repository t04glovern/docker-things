#!/bin/bash

set -e

docker-compose -f conan-artifactory/docker-compose.yml down -v

# remove conan profile
source conan-artifactory/venv/bin/activate
conan remote remove conan-docker || 2>&1 >/dev/null

# Remove Python env
rm -rf conan-artifactory/venv
