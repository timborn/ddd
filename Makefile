build:
	docker login
	docker build -t ddd .

run:
	docker run -d --name DDD1 ddd

debug:
	docker exec -it DDD1 bash
