deploy:
  docker-compose up -d
  
deploy-swarm:
  docker stack deploy -c docker-compose.yml app
  
destroy:
  docker-compose down
  
delete-all:
  docker stack rm app | true
  docker-compose down | true
