# Used to build and run docker container

build:
	docker build -t fetchapi .

run:
	docker run -p 8080:8080 fetchapi:latest

clean:
	docker image prune -f

