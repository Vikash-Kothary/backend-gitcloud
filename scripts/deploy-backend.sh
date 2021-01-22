#!/bin/bash
# file: deploy-backend.sh
# description: Deploy zip package.

PACKAGE_FOLDER=target
PACKAGE_NAME=backend-gitcloud
PACKAGE_VERSION=${GITCLOUD_BACKEND_VERSION//\"}-${GIT_COMMIT_SHORT_SHA//\"}

# If is a stable release
if [[ "\"main\"" == "${GIT_BRANCH}" ]]; then
	PACKAGE_VERSION=${GITCLOUD_BACKEND_VERSION//\"}
fi

PACKAGE_FILENAME=${PACKAGE_NAME}-${PACKAGE_VERSION}.zip
PACKAGE_REGISTRY="${GITLAB_API_V4_URL}/projects/${GITLAB_PROJECT_ID}/packages/generic/${PACKAGE_NAME}/${PACKAGE_VERSION}/${PACKAGE_FILENAME}"

echo "Deploying package to Gitlab Packages: ${PACKAGE_REGISTRY}"

if [[ ! -f "${PACKAGE_FOLDER}/${PACKAGE_FILENAME}" ]]; then
	echo "--- Package not found."
	exit 1
fi

echo "--- Found package: ${PACKAGE_FOLDER}/${PACKAGE_FILENAME}"

echo "--- Uploading to Gitlab Generic Package "
RESPONSE=$(curl \
--header "${GITLAB_AUTH_TYPE}: ${GITLAB_AUTH_TOKEN}" \
--upload-file "${PACKAGE_FOLDER}/${PACKAGE_FILENAME}" \
${PACKAGE_REGISTRY} \
--progress-bar)

# If doesn't return 201
if [[ -z `echo ${RESPONSE} | jq .message | grep '201'` ]]; then
	echo "Upload failed: `echo ${RESPONSE} | jq .message`"
	exit 1
else
	echo "Package Upload Successful: `echo ${RESPONSE} | jq .message`"
	exit 0
fi