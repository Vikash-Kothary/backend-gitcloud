#!/bin/bash
# file: package-backend.sh
# description: Build release zip.

PACKAGE_FOLDER=target/dist
PACKAGE_VERSION=${GITCLOUD_BACKEND_VERSION}-SNAPSHOT
PACKAGE_JAR=modules/core/target/gitcloud-core-${PACKAGE_VERSION}.jar
PACKAGE_NAME="gitcloud-${PACKAGE_VERSION}.zip"

echo "Building release package."
echo "--- Create release folder if it doesn't exist: ${PACKAGE_FOLDER}"
mkdir -p ${PACKAGE_FOLDER}

echo "--- Copy relevant files into dist folder."
cp "${PACKAGE_JAR}" "${PACKAGE_FOLDER}"

echo "--- Build release zip."
zip "$(dirname ${PACKAGE_FOLDER})/${PACKAGE_NAME}" "${PACKAGE_FOLDER}"