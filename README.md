# aws_ecs_pipeline
Repository created for my mba final project. The idea is create a pipeline for python etls witch will run between an aws ecs cluster

Some terraform commands to use (make sure the prompt is inside terraform/ folder):
```
terraform init
terraform plan
terraform validate
terraform apply
```
Additionaly using the command `terraform fmt` is recommended to format the code

Some docker command we will initialy use (make sure is in the same folder as the Dockerfile):
```
docker build ./ -t my-container --no-cache
docker run my-container
```

To run locally, recommended to bind a volume with the local aws credentials folder as following (change "C:/Users/caiov/.aws" to your pc .aws folder path):
```
docker run -v C:/Users/caiov/.aws:/root/.aws -d my-container
```
To update the docker image in ecr repository locally, first get the <repo_uri> in aws ecr page, 
then you must use the following commands:
```
# Make login and store the token who will get in response
aws ecr get-login-password --region <region_name>

# Then make the docker login in the ecr repository
aws ecr --region <region> | docker login -u AWS -p <encrypted_token> <repo_uri>

# Tag the image
docker tag <source_image_tag> <target_ecr_repo_uri>

# Push image to ecr repository
docker push <ecr-repo-uri>
```