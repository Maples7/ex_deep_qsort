TOP_DIR=.
README=$(TOP_DIR)/README.md
VERSION=$(strip $(shell cat version))

build:
	@echo "Building the software..."
	@mix compile

deps:
	@echo "Install dependencies required for this repo..."
	@mix deps.get

pre-build: deps
	@echo "Running scripts before the build..."

post-build:
	@echo "Running scripts after the build is done..."

all: pre-build build post-build

test:
	@echo "Running test suites..."
	@mix test

pre-commit: deps build
	@mix format
	@mix credo --strict
	@mix docs
	@mix test

clean:
	@echo "Cleaning the build..."
	@rm -rf _build

run:
	@echo "Running the software..."
	@iex -S mix

build-staging:
	@MIX_ENV=staging mix release --env=staging

build-prod:
	@MIX_ENV=prod mix release --env=prod

bump-version:
	@echo "Bump version..."
	@bin/bump_version.sh

.PHONY: build deps pre-build post-build all test pre-commit clean run build-staging build-prod bump-version
