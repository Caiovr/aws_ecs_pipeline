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
docker ./ build -t my-container --no-cache
docker run my-container
```

To Run locally, recommended to bind a volume with the local aws credentials folder as following (change "C:/Users/caiov/.aws" to your pc .aws folder path):
```
docker run -v C:/Users/caiov/.aws:/root/.aws -d my-container
```