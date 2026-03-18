lint:
	@docker run --rm -v $(CURDIR):/app -w /app  golangci/golangci-lint golangci-lint run controllers/ database/ models/ routes/ > /dev/null && echo "✅ LINT PASS" || { echo "❌ LINT FAIL"; exit 1; }
test:
	@$(MAKE) -s start > /dev/null
	@docker compose exec -T app go test main_test.go > /dev/null 2>&1 && echo "✅ TEST PASS" || { echo "❌ TEST FAIL"; exit 1; }
	@$(MAKE) -s stop > /dev/null
start:
	@docker compose up -d --wait > /dev/null 2>&1 && echo '🚀 App started!'
stop:
	@docker compose down > /dev/null 2>&1 && echo '💥 App stoped!'
ci: start lint test

