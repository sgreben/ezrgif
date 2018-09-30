.PHONY: build push all

NAME := ezrgif
REPOSITORY := quay.io/sergey_grebenshchikov/$(NAME)
VERSION := 1.0.1

build: Dockerfile gif.sh
	docker build -t $(NAME) -t $(REPOSITORY) -t $(REPOSITORY):$(VERSION) .

push: build
	docker push $(REPOSITORY)
	docker push $(REPOSITORY):$(VERSION)

all: build push
