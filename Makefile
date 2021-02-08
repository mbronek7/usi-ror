
PROJECT ?= usi

export PROJECT

network:
	docker network create usi

fix_model:
		cd app/services/detect && rm yolov3.onnx && wget https://onnxzoo.blob.core.windows.net/models/opset_10/yolov3/yolov3.onnx
dev-build:
		docker-compose -f docker/development/docker-compose.yml -p $(PROJECT) build
dev-up:
		docker-compose -f docker/development/docker-compose.yml -p $(PROJECT) up -d
dev: dev-build dev-up
		docker-compose -f docker/development/docker-compose.yml -p $(PROJECT) exec app bash
bash:
		docker-compose -f docker/development/docker-compose.yml -p $(PROJECT) exec app bash

clean:
	docker-compose \
		-f docker/development/docker-compose.yml \
		-p $(PROJECT) \
		down \
		--remove-orphans
