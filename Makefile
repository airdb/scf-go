SHELL = /bin/bash

VERSION:=$(shell git describe --dirty --always)
#VERSION := $(shell git describe --tags)
BUILD := $(shell git rev-parse HEAD)
REPO := github.com/airdb/scf-airdb

LDFLAGS=-ldflags
LDFLAGS += "-X=$(REPO)/internal/version.Repo=$(REPO) \
            -X=$(REPO)/internal/version.Version=$(VERSION) \
            -X=$(REPO)/internal/version.Build=$(BUILD) \
            -X=$(REPO)/internal/version.BuildTime=$(shell date +%s)"

default: build deploy

build:
	GOOS=linux go build $(LDFLAGS) -o main main.go
	GOOS=linux go build $(LDFLAGS) -o cli cmd/cli/main.go

deploy:
	sls deploy --stage test
	@echo checkout all scf apps, https://serverless.cloud.tencent.com/

release:
	sls deploy --stage release
	@echo checkout all scf apps, https://serverless.cloud.tencent.com/

log:
	sls logs --tail --stage test

logrelease:
	sls logs --tail --stage release

docker:
	docker run --platform linux/amd64 -it -v $(HOME)/go:/go airdb/serverless bash
