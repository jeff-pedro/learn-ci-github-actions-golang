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
cd:
	docker run --rm -itv $(CURDIR):/app -w /app golang:1.22 go build main.go
	scp -ri "~/.ssh/curso-cd-aws.pem" templates/ ec2-user@ec2-34-234-63-31.compute-1.amazonaws.com:/home/ec2-user
	scp -ri "~/.ssh/curso-cd-aws.pem" assets/ ec2-user@ec2-34-234-63-31.compute-1.amazonaws.com:/home/ec2-user
	scp -i "~/.ssh/curso-cd-aws.pem" main ec2-user@ec2-34-234-63-31.compute-1.amazonaws.com:/home/ec2-user
# Servidor
# ENV ./main
	# ssh -i "~/.ssh/curso-cd-aws.pem" ec2-user@ec2-34-234-63-31.compute-1.amazonaws.com "export $(cat .env-prod | xargs ) && ./main"

