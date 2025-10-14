readonly IMAGE_VERSION=2
REMOTE_SERVICE_HOST=rp-app
REMOTE_SERVICE_PORT=8080

if [ -z "$1" ]; then
  echo "No svaramig-web-client version supplied"
  exit 1
fi

if [ -z "$2" ]; then
  echo "No environment specified. Default to LIVE"
elif [[ "$2"=="LOCAL" ]]; then
  REMOTE_SERVICE_HOST=192.168.178.177
  REMOTE_SERVICE_PORT=8080    
fi
echo Building for backend $REMOTE_SERVICE_HOST:$REMOTE_SERVICE_PORT

rm -fR svaramig
cp -a . ../../svaramig-web-client/svaramig .

sed -i.bak "s/XXX_HOST_XXX/${REMOTE_SERVICE_HOST}/g" ./svaramig/src/utils/remote-properties.json
sed -i.bak "s/XXX_PORT_XXX/${REMOTE_SERVICE_PORT}/g" ./svaramig/src/utils/remote-properties.json

docker build --tag=svaramig-web-client:$1.$IMAGE_VERSION .

if [[ "$2"=="LOCAL" ]]; then
  docker image tag svaramig-web-client:$1.$IMAGE_VERSION rp-db:5000/svaramig-web-client:$1.$IMAGE_VERSION.LOCAL
  echo "Local images do not get pushed to the registry"
  exit 0
fi

docker image tag svaramig-web-client:$1.$IMAGE_VERSION rp-db:5000/svaramig-web-client:$1.$IMAGE_VERSION

docker image push rp-db:5000/svaramig-web-client:$1.$IMAGE_VERSION

docker push rp-db:5000/svaramig-web-client:$1.$IMAGE_VERSION
