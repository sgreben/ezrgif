.PHONY: build push all

NAME := ezrgif
REPOSITORY := quay.io/sergey_grebenshchikov/$(NAME)
VERSION := 1.2.0

build: Dockerfile gif.sh
	docker build -t $(NAME) -t $(REPOSITORY):latest -t $(REPOSITORY):$(VERSION) .

push: build
	docker push $(REPOSITORY):latest
	docker push $(REPOSITORY):$(VERSION)

all: build push
