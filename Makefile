KEY_FILE:=client-secret.json
PROJECT_ID:=project2-userteam
K8s_CLUSTER:=standard-cluster-1
REGION:=us-central1

IMAGE_NAME:=user-service
IMAGE_VERSION:=v1

#authorize gcloud access by providing the key file from our secrets in travis
gauth:
	@gcloud auth activate-service-account --key-file ${KEY_FILE}
	@gcloud auth configure-docker


gconfig:
	#the project we wish to work with
	@gcloud config set project $(PROJECT_ID)
	#cluster creation by providing credentials, what region, and for what project
	@gcloud container clusters \
		get-credentials $(K8s_CLUSTER) \
		--region $(REGION) \
		--project $(PROJECT_ID)


build:
	#build a docker file from a image we have through our project's url
	@docker build -t gcr.io/$(PROJECT_ID)/$(IMAGE_NAME):$(IMAGE_VERSION) .

run:
	@docker run -p 8000:8000 gcr.io/$(PROJECT_ID)/$(IMAGE_NAME):$(IMAGE_VERSION)

push:
	#push the image to our repository
	@docker push gcr.io/$(PROJECT_ID)/$(IMAGE_NAME):$(IMAGE_VERSION)

deploy: gconfig
	#we create the resource if it does not exist, if it already exist we update it
	@kubectl apply -f k8s.yaml
	@kubectl patch deployment $(IMAGE_NAME) -p "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"

set-image:
	#rolling update for our containers of our user-service deployment, with another of our images
	@kubectl set image deployments/user-service user-service=gcr.io/$(PROJECT_ID)/$(IMAGE_NAME):$(IMAGE_VERSION)
