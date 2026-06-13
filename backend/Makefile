.PHONY: run build test test-int db-up db-down

run:
	go run ./cmd/api

build:
	go build -o bin/api ./cmd/api

test:
	go test ./... -v -count=1

test-int:
	go test ./... -v -count=1 -tags=integration

db-up:
	docker compose -f ../docker-compose.yml up -d

db-down:
	docker compose -f ../docker-compose.yml down
