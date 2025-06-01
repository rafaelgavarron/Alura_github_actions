lint:
	docker run --rm -itv $(CURDIR):/app -w /app golangci/golangci-lint golangci-lint run controllers/ database/ models/ routes/
test:
	docker compose exec app go test main_test.go
start:
	docker compose up -d
ci: start lint test
cd:
	docker run --rm -itv $(CURDIR):/app -w /app golang:1.22-alpine go build main.go
	scp -ri "~/.ssh/curso-cd-aws.pem" $(CURDIR)/templates $(CURDIR)/assets $(CURDIR)/main ec2-user@ec2-54-235-226-74.compute-1.amazonaws.com:/home/ec2-user
	# Servidor de prod
	# ENV ./main