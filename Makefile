lint:
	@docker run --rm -v $(CURDIR):/app -w /app  golangci/golangci-lint golangci-lint run controllers/ database/ models/ routes/ > /dev/null && echo "✅ LINT PASS" || { echo "❌ LINT FAIL"; exit 1; }
test:
	@docker compose exec -T app go test main_test.go && echo "✅ TEST PASS" || { echo "❌ TEST FAIL"; exit 1; }
start:
	@docker compose up -d --wait > /dev/null 2>&1
ci: lint start test
