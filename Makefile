.PHONY: build push all

NAME := ezrgif
REPOSITORY := quay.io/sergey_grebenshchikov/$(NAME)

build: Dockerfile gif.sh
	docker build -t $(NAME) -t $(REPOSITORY) .

push: build
	docker push $(REPOSITORY)

all: build push
