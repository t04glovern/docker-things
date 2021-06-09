#!/bin/bash

set -e

echo "[INFO] Bringing container up: please wait..."
CONAN_ARTIFACTORY_DIR="$( cd "$( dirname "$0" )" && pwd )"
docker-compose -f $CONAN_ARTIFACTORY_DIR/conan-artifactory/docker-compose.yml up -d

# Random sleep
echo "[INFO] please hold for a bit..."
sleep 60

# Fetch password
curl \
    --location \
    --request PATCH 'http://localhost:8081/artifactory/api/system/configuration' \
    --header 'Content-Type: application/yaml' \
    --header 'Authorization: Basic YWRtaW46cGFzc3dvcmQ=' \
    --data-binary '@.$CONAN_ARTIFACTORY_DIR/conan-artifactory/repositories.yml'
ARTIFACTORY_PASSWORD=$(curl --location --request GET 'http://localhost:8081/artifactory/api/security/encryptedPassword' --header 'Authorization: Basic YWRtaW46cGFzc3dvcmQ=')

# Setup Python env
python3 -m venv conan-artifactory/venv
source conan-artifactory/venv/bin/activate
pip install -U pip
pip install conan

# login to conan
conan remote remove conan-docker || 2>&1 >/dev/null
conan remote add conan-docker http://localhost:8081/artifactory/api/conan/conan
CONAN_REVISIONS_ENABLED=1 conan user -p $ARTIFACTORY_PASSWORD -r conan-docker admin
