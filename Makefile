#!/bin/make

SHELL := /bin/bash
GITCLOUD_BACKEND_PATH := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
GITCLOUD_BACKEND_NAME ?= "Git Cloud"
GITCLOUD_BACKEND_VERSION ?= "0.1.0"
GITCLOUD_BACKEND_DESCRIPTION ?= "Manage all your Git repositories, organisations, providers from one place."

ENV ?= local
-include config/.env.${ENV}
-include config/secrets/.env.${ENV}
export

.DEFAULT_GOAL := help-backend
.PHONY: help-backend #: List available command.
help: help-backend # alias for quick access
help-backend:
	@awk 'BEGIN {FS = " ?#?: "; print ""$(GITCLOUD_BACKEND_NAME)" "$(GITCLOUD_BACKEND_VERSION)"\n"$(GITCLOUD_BACKEND_DESCRIPTION)"\n\nUsage: make \033[36m<command>\033[0m\n\nCommands:"} /^.PHONY: ?[a-zA-Z_-]/ { printf "  \033[36m%-10s\033[0m %s\n", $$2, $$3 }' $(MAKEFILE_LIST)

.PHONY: docs-backend #: Run documentation.
docs: docs-backend # alias for quick access
docs-backend:
	@cd ${GITCLOUD_BACKEND_PATH} && \
	${MVN} -f docs/pom.xml clean site:run

.PHONY: lint-backend #: Run linting.
lint: lint-backend # alias for quick access
lint-backend:
	@cd ${GITCLOUD_BACKEND_PATH} && \
	false

.PHONY: tests-backend #: Run tests.
tests: tests-backend # alias for quick access
tests-backend:
	@cd ${GITCLOUD_BACKEND_PATH} && \
	false

.PHONY: run-backend #: Run backend app.
run: run-backend # alias for quick access
run-backend: 
	@cd ${GITCLOUD_BACKEND_PATH} && \
	${MVN} -f modules/core clean spring-boot:run

.PHONY: build-backend #: Build backend app.
build: build-backend # alias for quick access
build-backend: 
	@cd ${GITCLOUD_BACKEND_PATH} && \
	false
	
# Run scripts using make
%:
	@cd ${GITCLOUD_BACKEND_PATH} && \
	test -f "scripts/${*}.sh" && \
	${SHELL} "scripts/${*}.sh"

.PHONY: init-backend #: Download project dependencies.
init: init-backend # alias for quick access
init-backend:
	@cd ${GITCLOUD_BACKEND_PATH} && \
	${MVN} initialize

.PHONY: clean-backend #: Clean project build files.
clean: clean-backend # alias for quick access
clean-backend:
	@cd ${GITCLOUD_BACKEND_PATH} && \
	${MVN} clean
