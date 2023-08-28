# aws_ecs_pipeline
Repository created for my mba final project. The idea is create a pipeline for python etls witch will run between an aws ecs cluster


Some docker command we will initialy use:
docker build -t app_test
docker run app_test

docker run -v C:/Users/caiov/.aws:/root/.aws -d app_test