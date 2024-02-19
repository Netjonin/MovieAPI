# Include variables from the .envrc file
# The content of the file was taken from the $HOME/.profile file
include .envrc

confirm:
	@echo -n 'Are you sure? [y/N] ' && read ans && [ $${ans:-N} = y ]

run/api::
	go run ./cmd/api -db-dsn=${GREENLIGHT_DB_DSN}

db/psql:
	psql ${GREENLIGHT_DB_DSN}

db/migrations/new:
	@echo 'Creating migration files for ${name}...'
	migrate create -seq -ext=.sql -dir=./migrations ${name}

db/migrations/up:	confirm
	@echo 'Running up migrations...'
	migrate -path ./migrations -database ${GREENLIGHT_DB_DSN} up