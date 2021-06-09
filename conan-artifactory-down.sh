#!/bin/bash

set -e

echo "[INFO] Bringing container down: please wait..."
CONAN_ARTIFACTORY_DIR="$( cd "$( dirname "$0" )" && pwd )"
docker-compose -f $CONAN_ARTIFACTORY_DIR/conan-artifactory/docker-compose.yml down -v

# remove conan profile
source $CONAN_ARTIFACTORY_DIR/conan-artifactory/venv/bin/activate
conan remote remove conan-docker || 2>&1 >/dev/null

# Remove Python env
rm -rf $CONAN_ARTIFACTORY_DIR/conan-artifactory/venv
