build:
	docker login
	docker build -t ddd .

run:
	docker stop DDD1 || :
	docker rm   DDD1 || :
	docker run -d -p2222:22 -p5901:5901 -p6901:6901 --name DDD1 ddd

debug:
	docker exec -it DDD1 bash
