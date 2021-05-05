docker stop tokio-docker
docker rm tokio-docker 

docker run -dit \
  --expose 443 \
  --expose 80 \
  --name tokio-docker \
  --restart always \
  --net web \
  --label="traefik.enable=true" \
  --label="traefik.backend=tokio-docker" \
  --label="traefik.frontend.rule=Host:tokio-docker" \
  --label="traefik.docker.network=web" \
  --label="traefik.port=80" \
  ${1}
