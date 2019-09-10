KEY_FILE:=client-secret.json
PROJECT_ID:=project2-userteam
K8s_CLUSTER:=standard-cluster-1
REGION:=us-central1

IMAGE_NAME:=user-service
IMAGE_VERSION:=v1

gauth:
	@gcloud auth activate-service-account --key-file ${KEY_FILE}
	@gcloud auth configure-docker

gconfig:
	@gcloud config set project $(PROJECT_ID)
	@gcloud container clusters \
		get-credentials $(K8s_CLUSTER) \
		--region $(REGION) \
		--project $(PROJECT_ID)

build:
	@docker build -t gcr.io/$(PROJECT_ID)/$(IMAGE_NAME):$(IMAGE_VERSION)  --build-arg db=$(DATABASE_NAME) --build-arg schema=$(JDBC_SCHEMA) --build-arg url=$(JDBC_URL) --build-arg username=$(JDBC_USERNAME) --build-arg password=$(JDBC_PASSWORD) .

run:
	@docker run -p 8000:8000 gcr.io/$(PROJECT_ID)/$(IMAGE_NAME):$(IMAGE_VERSION)

push:
	@docker push gcr.io/$(PROJECT_ID)/$(IMAGE_NAME):$(IMAGE_VERSION)

deploy: gconfig
	@kubectl apply -f k8s.yaml
	@kubectl patch deployment $(IMAGE_NAME) -p "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"
