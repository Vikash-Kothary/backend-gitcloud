#!/bin/bash
# file: deploy-backend.sh
# description: Deploy zip package.

PACKAGE_FOLDER=target
PACKAGE_NAME=backend-gitcloud
PACKAGE_VERSION=${GITCLOUD_BACKEND_VERSION}
PACKAGE_FILENAME=${PACKAGE_NAME}-${PACKAGE_VERSION}.zip
GITLAB_API_V4_URL=${CI_API_V4_URL}
GITLAB_PROJECT_ID=${CI_PROJECT_ID}
GITLAB_AUTH_TOKEN=${CI_JOB_TOKEN}
GITLAB_GENERIC_PACKAGE_REGISTRY="${GITLAB_API_V4_URL}/projects/${GITLAB_PROJECT_ID}/packages/generic/${PACKAGE_NAME}/${PACKAGE_VERSION}/${PACKAGE_FILENAME}"
[[ ! -z "${GITLAB_AUTH_TYPE}" ]] || GITLAB_AUTH_TYPE=JOB-TOKEN

echo "Deploying package to Gitlab Packages"

if [[ ! -f "${PACKAGE_FOLDER}/${PACKAGE_FILENAME}" ]]; then
	echo "--- Package not found."
	exit 1
fi

echo "--- Found package: ${PACKAGE_FOLDER}/${PACKAGE_FILENAME}"

echo "--- Uploading to Gitlab Generic Package "
RESPONSE=$(curl \
--header "${GITLAB_AUTH_TYPE}: ${GITLAB_AUTH_TOKEN}" \
--upload-file "${PACKAGE_FOLDER}/${PACKAGE_FILENAME}" \
${GITLAB_GENERIC_PACKAGE_REGISTRY} \
--progress-bar)

# If doesn't return 201
if [[ -z `echo ${RESPONSE} | jq .message | grep '201'` ]]; then
	echo "Upload failed: `echo ${RESPONSE} | jq .message`"
	exit 1
else
	echo "Package Upload Successful: `echo ${RESPONSE} | jq .message`"
	exit 0
fi