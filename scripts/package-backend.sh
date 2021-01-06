#!/bin/bash
# file: package-backend.sh
# description: Build release zip.

PACKAGE_FOLDER=target
PACKAGE_NAME=backend-gitcloud
PACKAGE_VERSION=${GITCLOUD_BACKEND_VERSION}
PACKAGE_FILENAME=${PACKAGE_NAME}-${PACKAGE_VERSION}.zip
PACKAGE_JAR=modules/core/target/gitcloud-core-${PACKAGE_VERSION}.jar

echo "Building release package."

if [[ -f "${PACKAGE_FOLDER}/${PACKAGE_FILENAME}" ]]; then
	echo "--- Release package already exists. DELETING."
	rm "${PACKAGE_FOLDER}/${PACKAGE_FILENAME}"
fi

echo "--- Create release folder if it doesn't exist: ${PACKAGE_FOLDER}/dist"
mkdir -p ${PACKAGE_FOLDER}/dist

echo "--- Copy relevant files into dist folder."
cp "${PACKAGE_JAR}" "${PACKAGE_FOLDER}/dist"


echo "--- Build release zip."
pushd "${PACKAGE_FOLDER}/dist" >> /dev/null
zip  "../${PACKAGE_FILENAME}" "$(basename ${PACKAGE_JAR})"
popd >> /dev/null

echo "--- Release zip contains the following:"
unzip -l "${PACKAGE_FOLDER}/${PACKAGE_FILENAME}"