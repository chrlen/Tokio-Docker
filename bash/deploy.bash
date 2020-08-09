docker stop rust.brimborium.xyz
docker rm rust.brimborium.xyz 

docker run -dit \
  --expose 443 \
  --expose 80 \
  --name rust.brimborium.xyz \
  --restart always \
  --net web \
  --label="traefik.enable=true" \
  --label="traefik.backend=rust.brimborium.xyz" \
  --label="traefik.frontend.rule=Host:rust.brimborium.xyz" \
  --label="traefik.docker.network=web" \
  --label="traefik.port=80" \
  ${1}
