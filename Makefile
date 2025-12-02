
NAME=mmbase/ffmpeg
VERSION=dev

build: Dockerfile  ## build docker image, no push, current platform. Handy for local testing
	docker build -t $(NAME):$(VERSION) .

run:
	docker run -it --entrypoint bash $(NAME):$(VERSION)
